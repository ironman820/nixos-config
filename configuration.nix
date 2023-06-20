# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./users.nix
    ];

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader = {
    efi.canTouchEfiVariables = true;
    # grub = {
    #   efiSupport = true;
    #   enable = true;
    #   gfxpayloadEfi = "keep";
    # };
    systemd-boot.enable = true;
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-photos
  ];

  networking.hostName = "ironman-laptop"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  services = {
    flatpak.enable = true;
    printing.enable = true;
    xserver = {
      desktopManager.gnome.enable = true;
      displayManager = {
        defaultSession = "gnome";
        gdm.enable = true;
      };
      enable = true;
      layout = "us";
      libinput = {
        enable = true;
        touchpad.tapping = true;
      };
    };
  };

  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = (with pkgs; [
    distrobox
    git
    gnome-extension-manager
    gnome.gnome-tweaks
    # podman
    podman-compose
    qt6.full
    vim
    wget
  ]) ++ (with pkgs.gnomeExtensions; [
    appindicator
    caffeine
    compact-top-bar
    lock-keys
    no-overview
    pano
    power-profile-switcher
    tactile
    tray-icons-reloaded
    wallpaper-switcher
    weather-oclock
  ]);

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs = {
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    mtr.enable = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  nixpkgs.config.allowUnfree = true;

  virtualisation.podman.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

