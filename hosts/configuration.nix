# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# { config, lib, pkgs, inputs, agenix, ... }:
{ config, lib, pkgs, inputs, ... }:

{
  # pkgs.overlays = [ inputs.nur.overlay ];
  imports =
    [
      ../modules/desktop
      ../modules/zsh
      # ../modules/agenix.nix
    ];

  environment = {
    systemPackages = with pkgs; [
      adoptopenjdk-icedtea-web
      bat
      exa
      firefox
      flameshot
      font-manager
      galculator
      gimp
      git-crypt
      glances
      gnome.file-roller
      google-chrome
      libsForQt5.okular
      libsForQt5.qtstyleplugin-kvantum
      libreoffice
      # microsoft-edge
      nfs-utils
      # nur.repos.xe.microsoft-edge-dev
      pavucontrol
      pulseaudio # used for pactl, not enabled
      putty
      restic
      starship
      synology-drive
      tldr
      ulauncher
      variety
      wget
      vscode
    ];
  };

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      corefonts
      nerdfonts
      open-sans
    ];
  };

  # Flake Ready!
  nix = {
    autoOptimiseStore = true;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
      randomizedDelaySec = "1mins";
    };
    package = pkgs.nixFlakes;
    registry.nixpkgs.flake = inputs.nixpkgs;
  };

  nixpkgs.config.allowUnfree = true;

  boot = {
    consoleLogLevel = 3;
  };

  networking = {
    firewall.enable = false;
    networkmanager.enable = true;
    useDHCP = false;
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  programs = {
    dconf.enable = true;
    git = {
      config = {
        core.editor = "code --wait";
        pull.rebase = false;
        user = {
          name = "Nicholas Eastman";
          email = "29488820+ironman820@users.noreply.github.com";
        };
      };
      enable = true;
    };
    java.enable = true;
    mtr.enable = true;
    vim.defaultEditor = true;
  };
  
  security = {
    rtkit.enable = true; # Needed for pipewire
    sudo.wheelNeedsPassword = false;
  };

  services = {
    gnome.gnome-keyring.enable = true;
    haveged.enable = true;
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    # restic.backups = {

    # };
  }; 

  sound.mediaKeys.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

