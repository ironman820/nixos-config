{ config, pkgs, ... }:

let
  qt5Packages = with pkgs.libsForQt5; [
    okular
    qtstyleplugin-kvantum
  ];

  sysPackages = with pkgs; [
    adoptopenjdk-icedtea-web
    agenix.agenix
    albert
    # audiorelay
    b43FirmwareCutter
    bat # cat replacement
    birdtray
    # cups-pdf
    ddrescue
    ddrescueview
    exa # ls replacement
    firefox
    flameshot
    font-manager
    galculator
    gimp
    git-crypt
    git-filter-repo
    glances # preferred htop replacement
    gnome.file-roller
    google-chrome
    htop
    libreoffice
    lightlocker
    microsoft-edge
    nfs-utils
    nix-index
    nixos-icons
    nmap
    p7zip
    pavucontrol
    pulseaudio # used for pactl, not enabled
    putty
    restic
    ripgrep
    sqlitebrowser
    starship
    synology-drive-client
    thunderbird
    tldr
    tree
    unstable.vscode
    variety
    ventoy-bin
    vim
    virt-viewer
    yubioath-desktop
    yubico-piv-tool
    yubikey-manager-qt
    yubikey-personalization-gui
    yubikey-touch-detector
    wget
  ];

  unstablePackages = with pkgs.unstable; [
  ];

  xfcePackages = with pkgs.xfce; [
    xfce4-pulseaudio-plugin
    xfce4-whiskermenu-plugin
  ];

in

{
  # pkgs.overlays = [ inputs.nur.overlay ];
  imports = [
    (import (builtins.fetchTarball {
      url = "https://github.com/jmackie/nixos-networkmanager-profiles/archive/master.tar.gz";
      sha256 = "0x18qkwxfzmhbn6cn2da0xn27mxnmiw56qwx3kjvy9ljcar5czvh";
    }))
    <agenix/modules/age.nix>
    ./hardware-configuration.nix
    <home-manager/nixos>
    # ./modules/glocom
    INSTALL_ROOT/etc/nixos/secrets/wireless
    INSTALL_ROOT/etc/nixos/secrets/vpn
    INSTALL_ROOT/etc/nixos/users/royell
  ];

  boot = {
    cleanTmpDir = true;
    consoleLogLevel = 3;
    loader = {
      efi.canTouchEfiVariables = true;
      # generationsDir.enable = true;
      systemd-boot = {
        configurationLimit = 10;
        enable = true;
      };
      timeout = 2;
    };
    plymouth.enable = true;
  };

  environment = {
    etc = {
      "ssh/ssh_host_ed25519_key" = {
        mode = "0400";
        source = "INSTALL_ROOT/etc/nixos/secrets/keys/work-laptop/ssh_host_ed25519_key";
      };
      "ssh/ssh_host_ed25519_key.pub" = {
        mode = "0444";
        source = "INSTALL_ROOT/etc/nixos/secrets/keys/work-laptop/ssh_host_ed25519_key.pub";
      };
      "ssh/ssh_host_rsa_key" = {
        mode = "0400";
        source = "INSTALL_ROOT/etc/nixos/secrets/keys/work-laptop/ssh_host_rsa_key";
      };
      "ssh/ssh_host_rsa_key.pub" = {
        mode = "0444";
        source = "INSTALL_ROOT/etc/nixos/secrets/keys/work-laptop/ssh_host_rsa_key.pub";
      };
    };
    shells = [ pkgs.zsh ];
    systemPackages = qt5Packages ++ sysPackages ++ unstablePackages ++ xfcePackages;
  };

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      corefonts
      nerdfonts
      open-sans
    ];
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  # Flake Ready!
  nix = {
    autoOptimiseStore = true;
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 30d";
      randomizedDelaySec = "1mins";
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      agenix = import <agenix> {};
      unstable = import <nixos-unstable> {
        config = config.nixpkgs.config;
      };
    };
  };

  networking = {
    enableB43Firmware = true;
    firewall.enable = false;
    hostName = "e105-laptop";
    networkmanager.enable = true;
    useDHCP = false;
  };

  programs = {
    dconf.enable = true;
    git = {
      enable = true;
      lfs.enable = true;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = "gtk2";
    };
    java.enable = true;
    mtr.enable = true;
    vim.defaultEditor = true;
    wireshark.enable = true;
    zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
        ];
      };
      shellAliases = {
        cat = "bat";
        df = "df -h";
        ducks = "du -chs * | sort -rh | head -11";
        gpg = "gpg2";
        grep = "rg";
        htop = "glances --percpu";
        l = "exa -lah";
        la = "exa -lah";
        ll = "exa -lah";
        ls = "exa -a";
        lsa = "exa -lah";
        md = "mkdir -p";
        rd = "rmdir";
        vim = "code --wait";
      };
      shellInit = ''
        eval "$(starship init zsh)"
      '';
      syntaxHighlighting.enable = true;
    };
  };

  security = {
    rtkit.enable = true; # needed for pipewire
    sudo.wheelNeedsPassword = false;
    # pam.yubico.enable = true;
  };

  services = {
    auto-cpufreq.enable = true;
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    haveged.enable = true;
    openssh.enable = true;
    pcscd.enable = true; # smart card library for Yubikey access
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    printing = {
      drivers = with pkgs; [
          hplipWithPlugin
      ];
      enable = true;
    };
    xserver = {
    };
    xserver = {
      enable = true;
      # Setup LightDM Greeter
      displayManager.lightdm = {
        enable = true;
        greeters.gtk = {
          theme = {
            name = "Arc-Dark";
            package = pkgs.arc-theme;
          };
          iconTheme = {
            name = "Tela-dark";
            package = pkgs.tela-icon-theme;
          };
        };
      };
      # Enable the XFCE Desktop Environment.
      desktopManager.xfce.enable = true;
      layout = "us";
      libinput = {
        enable = true;
        touchpad.scrollMethod = "twofinger";
      };
    };
    yubikey-agent.enable = true;
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
