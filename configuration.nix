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

  boot = {
    kernelParams = [
      "quiet"
    ];
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        efiSupport = true;
        device = "nodev";
        theme = pkgs.nixos-grub2-theme;
      };
      timeout = 2;
    };
    plymouth = {
      enable = true;
      theme = "nixos-bgrt";
      themePackages = [
        pkgs.nixos-bgrt-plymouth
      ];
    };
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  environment = {
    gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-photos
    ];

    systemPackages = (with pkgs; [
      distrobox
      git
      gnome-extension-manager
      gnome.gnome-tweaks
      ntfs3g
      podman-compose
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
      wallpaper-switcher
      weather-oclock
    ]);
  };

  hardware.pulseaudio.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    firewall.enable = false;
    networkmanager.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    mtr.enable = true;
  };

  services = {
    flatpak.enable = true;
    openssh.enable = true;
    pcscd.enable = true;
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

  sound.enable = true;

  system.copySystemConfiguration = true;

  time.timeZone = "America/Chicago";

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.package = pkgs.qemu_kvm;
    };
    podman.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

