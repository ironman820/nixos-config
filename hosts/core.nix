{ config, pkgs, ... }:

let
  qt5Packages = with pkgs.libsForQt5; [
    ark
    qtstyleplugin-kvantum
    skanlite
  ];

  sysPackages = with pkgs; [
    adoptopenjdk-icedtea-web
    agenix.agenix
    albert
    # audiorelay
    bat # cat replacement
    bind
    birdtray
    # busybox
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
    gnome.simple-scan
    google-chrome
    googleearth-pro
    htop
    kubectl
    kubernetes-helm-wrapped
    libreoffice
    libykclient
    # lightlocker
    lutris
    meld
    microsoft-edge
    nfs-utils
    nix-index
    nixos-icons
    nmap
    nodejs
    p7zip
    pavucontrol
    poetry
    pulseaudio # used for pactl, not enabled
    putty
    pv
    restic
    ripgrep
    sqlitebrowser
    starship
    synology-drive-client
    thunderbird
    tree
    ventoy-bin
    vim
    virt-viewer
    wget
    yubioath-desktop
    yubico-piv-tool
    yubikey-manager-qt
    yubikey-personalization-gui
    yubikey-touch-detector
  ];

  unstablePackages = with pkgs.unstable; [
        vscode
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
    INSTALL_ROOT/etc/nixos/hardware-configuration.nix
    <home-manager/nixos>
    INSTALL_ROOT/etc/nixos/modules/scanners/sane-extra-config.nix
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
    # plymouth.enable = true;
  };

  environment = {
    shells = [ pkgs.zsh ];
    systemPackages = qt5Packages ++ sysPackages ++ unstablePackages;
  };

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      corefonts
      nerdfonts
      open-sans
    ];
  };

  hardware = {
    pulseaudio.enable = false;
    sane = {
      enable = true;
      extraBackends = with pkgs; [
        hplipWithPlugin
        sane-airscan
      ];
    };
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
    firewall.enable = false;
    networkmanager.enable = true;
    useDHCP = false;
  };

  programs = {
    dconf.enable = true;
    git = {
      enable = true;
      lfs.enable = true;
      config = {
        pull.rebase = true;
      };
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = "qt";
    };
    java.enable = true;
    mtr.enable = true;
    vim.defaultEditor = true;
    wireshark.enable = true;
    zsh = {
      enable = true;
      enableGlobalCompInit = false;
      setOptions = [
        "autocd"
        "HIST_IGNORE_DUPS"
        "SHARE_HISTORY"
        "HIST_FCNTL_LOCK"
      ];
      shellAliases = {
        df = "df -h";
        ducks = "du -chs * | sort -rh | head -11";
        gpg = "gpg2";
        grep = "rg";
        l = "ls -lah";
        la = "ls -lah";
        ll = "ls -lah";
        ls = "ls -a";
        lsa = "ls -lah";
        md = "mkdir -p";
        pv = "pv -pte";
        rd = "rmdir";
      };
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
    avahi = {
      enable = true;
      nssmdns = true;
    };
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
        gutenprint
        hplip
      ];
      enable = true;
    };
    saned.enable = true;
    xserver = {
      enable = true;
      displayManager = {
        sddm = {
          enable = true;
        };
      };
      desktopManager.plasma5.enable = true;
      layout = "us";
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
