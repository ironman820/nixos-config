#!/usr/bin/env bash

if [[ ! -f ".updated" ]]; then
  echo "Adding and updating Nix Channels"
  sudo nix-channel --add https://nixos.org/channels/nixos-22.05 nixos 2>&1 > /dev/null
  sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable 2>&1 > /dev/null
  sudo nix-channel --add https://github.com/ryantm/agenix/archive/main.tar.gz agenix 2>&1 > /dev/null
  sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz home-manager
  sudo nix-channel --update 2>&1 > /dev/null
  touch .updated
  echo "Finished adding channels."
fi

gpg -k > /dev/null 2>&1
if [ $? != 0 ]; then
  echo "Dropping into a shell to continue with the needed tools."
  nix-shell --command "./install.sh"
else

  echo "Cloning the repo to the NixOS directory at '/mnt/etc/nixos'"

  if [[ ! -d "/mnt/etc/nixos" ]]; then
    sudo git clone -b system --depth 1 https://github.com/ironman820/nixos-config.git /mnt/etc/nixos/ 2>&1 > /dev/null
  else
    cd /mnt/etc/nixos
    sudo git restore . 2>&1 > /dev/null
    sudo git pull 2>&1 > /dev/null
  fi

  sudo nixos-generate-config --root /mnt

  cd /mnt/etc/nixos

  if [[ ! -f ".host" ]]; then
    echo "What is the hostname of the system we are installing?"
    read hostname

    echo $hostname | sudo tee .host > /dev/null 2>&1
  else
    hostname=$(cat .host)
  fi

  sudo cp hosts/$hostname/configuration.nix ./

  if file -bL --mime-encoding secrets/secrets.nix | grep -iq binary ; then
    if sudo gpg -k --keyid-format LONG | grep -iq 11B0F08E0A4D904B ; then
      echo "Public GPG key found, skipping import."
    else
      echo "Please wait while we retrieve your GPG key..."
      sudo gpg --receive-keys 185B6FE0AC2034D0EB2F0ADD11B0F08E0A4D904B > /dev/null 2>&1
      echo "Updating trust level"
      echo -e "5\ny\n" | sudo gpg --command-fd 0 --expert --edit-key 11B0F08E0A4D904B trust > /dev/null;
    fi
    if sudo gpg -K --keyid-format=long | grep -iq 9F30DA1A16D74EA7 ; then
      echo "Private GPG key found, skipping import."
    else
      echo "If you don't have your GPG Card, the next phase will error out."
      echo "If that happens, run 'gpg --card-status' once your have your card connected."
      read -sp "Please insert your GPG Card and press 'Enter' to continue..."
      sudo gpg --card-status > /dev/null 2>&1
    fi

    if sudo gpg -K --keyid-format=long | grep -iq 9F30DA1A16D74EA7 ; then
      sudo git crypt unlock
      if file -bL --mime-encoding secrets/secrets.nix | grep -iq binary ; then
        for FILE in `find .git-crypt/keys/default -type f`; do
          if sudo gpg --pinentry-mode=loopback --decrypt < $FILE | sudo tee unlock-key > /dev/null 2>&1; then
            sudo git crypt unlock unlock-key
            sudo rm -f unlock-key
          fi
        done
        if file -bL --mime-encoding secrets/secrets.nix | grep -iq binary ; then
          echo "Secrets have not been unlocked!"
          echo "Please check for errors and try running the script again."
          exit
        fi
      fi
    else
      echo "Your private GPG key did not import properly, please try again."
      exit
    fi
  fi

  sudo sed -i 's/INSTALL_ROOT/\/mnt/' configuration.nix
  sudo sed -i 's/INSTALL_ROOT/\/mnt/' hardware-configuration.nix
  sudo sed -i 's/INSTALL_ROOT/\/mnt/' hosts/core.nix
  sudo sed -i 's/INSTALL_ROOT/\/mnt/' hosts/laptop.nix
  sudo sed -i 's/INSTALL_ROOT/\/mnt/' users/ironman/default.nix
  sudo sed -i 's/INSTALL_ROOT/\/mnt/' users/niceastman/default.nix
  sudo sed -i 's/INSTALL_ROOT/\/mnt/' users/royell/default.nix
  sudo sed -i 's/HOST_NAME/'"$hostname"'/' hardware-configuration.nix

  sudo mkdir -p /mnt/tmpstore/{work,store,tmp}
  sudo export TMP=/mnt/tmpstore/tmp
  sudo export TMPDIR=/mnt/tmpstore/tmp
  sudo mount -t overlay overlay -olowerdir=/nix/store,upperdir=/mnt/tmpstore/store,workdir=/mnt/tmpstore/work /nix/store

  sudo nixos-install
fi
