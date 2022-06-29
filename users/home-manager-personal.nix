{ pkgs, config, ... }:
{
  gtk = {
    enable = true;
    theme = {
      name = "Arc-Dark";
      package = pkgs.arc-theme;
    };
    iconTheme = {
      name = "Tela-dark";
      package = pkgs.tela-icon-theme;
    };
  };

  home = {
    file = {
      ".config/albert".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/albert";
      ".config/autostart/albert.desktop".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/startup/albert.desktop";
      ".config/autostart/variety.desktop".source = "${config.home.homeDirectory}/dotfiles/config/startup/variety.desktop";
      ".config/xfce4/panel".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/xfce4/panel";
      ".config/xfce4/xfconf".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/xfce4/xfconf";
      ".ssh/known_hosts".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/secrets/home/global/ssh/known_hosts";
      ".ssh/known_hosts.old".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/secrets/home/global/ssh/known_hosts.old";
      "personal-gpg/install.sh" = {
        executable = true;
        text = ''
#!/usr/bin/env bash

if gpg -K --keyid-format LONG | grep -iq 9F30DA1A16D74EA7 ; then
  exit 0
fi
gpg --receive-keys 185B6FE0AC2034D0EB2F0ADD11B0F08E0A4D904B 2>&1 > /dev/null
echo -e "5\ny\n" | gpg --command-fd 0 --expert --edit-key 11B0F08E0A4D904B trust;
echo "If you don't have your GPG Card, the next phase will error out."
echo "If that happens, run gpg --card-status once your have your card connected."
read -sp "Please insert your GPG Card and press a key to continue..."
gpg --card-status 2>&1 > /dev/null

echo "Finished!"
          '';
      };
      "personal-gpg/changekey.sh" = {
        executable = true;
        text = ''
#!/usr/bin/env bash
echo "Insert the new key to authenticate."
read -sp "Press 'Enter' to continue."
gpg-connect-agent "scd serialno" "learn --force" /bye
echo "Finished"
        '';
      };
      "wallpapers.7z.001".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/walls/wallpapers.7z.001";
      "wallpapers.7z.002".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/walls/wallpapers.7z.002";
      "wallpapers.7z.003".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/walls/wallpapers.7z.003";
      "wallpapers.7z.004".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/walls/wallpapers.7z.004";
      "wallpapers.7z.005".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/walls/wallpapers.7z.005";
      "wallpapers.7z.006".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/walls/wallpapers.7z.006";
    };
  };

  programs = {
    git = {
      enable = true;
      extraConfig = {
        core.editor = "code --wait";
        pull.rebase = false;
      };
      lfs.enable = true;
      signing = {
        key = "9F30DA1A16D74EA7";
        signByDefault = true;
      };
      userEmail = "29488820+ironman820@users.noreply.github.com";
      userName = "Nicholas Eastman";
    };
    home-manager.enable = true;
    zsh = {
      initExtra = ''
        export EDITOR="code --wait"
      '';
      shellAliases = {
        cat = "bat";
        htop = "glances --percpu";
        l = "exa -lah";
        la = "exa -lah";
        ll = "exa -lah";
        ls = "exa -a";
        lsa = "exa -lah";
        vim = "code --wait";
      };
    };
  };
}
