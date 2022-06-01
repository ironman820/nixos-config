{ config, lib, pkgs, upkgs, agenix, ... }:

{
  # pkgs.overlays = [ inputs.nur.overlay ];
  imports =
    [
        (import (builtins.fetchTarball {
            url = "https://github.com/jmackie/nixos-networkmanager-profiles/archive/master.tar.gz";
            sha256 = "0x18qkwxfzmhbn6cn2da0xn27mxnmiw56qwx3kjvy9ljcar5czvh";
        }))
    ] ++ [
      ../modules/git
      ../modules/zsh
      ../modules/agenix.nix
    ];

  boot = {
    consoleLogLevel = 3;
  };

  environment.systemPackages = with pkgs; [
      bat # cat replacement
      exa # ls replacement
      glances # preferred htop replacement
      htop
      nfs-utils
      # nix-index
      p7zip
      restic
      ripgrep
      starship
      tldr
      tree
      vim
      wget
    ];

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
    # registry.nixpkgs.flake = inputs.nixpkgs;
  };

  nixpkgs.config.allowUnfree = true;

  networking = {
    firewall.enable = false;
    networkmanager.enable = true;
    useDHCP = false;
  };

  programs = {
    dconf.enable = true;
    java.enable = true;
    mtr.enable = true;
    # vim.defaultEditor = true;
  };

  security = {
    sudo.wheelNeedsPassword = false;
  };

  services = {
    haveged.enable = true;
    openssh.enable = true;
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
  system.stateVersion = "21.11"; # Did you read the comment?

}

