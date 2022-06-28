
{ pkgs, ...}:

{
  home-manager.users.niceastman = { config, ... }: {
    home = {
      homeDirectory = "/home/niceastman";
      username = "niceastman";
    };

    imports = [
      INSTALL_ROOT/etc/nixos/users/home-manager-core.nix
      INSTALL_ROOT/etc/nixos/users/home-manager-personal.nix
    ];

  };

  users.users.niceastman = {
    isNormalUser = true;
    hashedPassword = "$6$PY0A75x0UUOjhBJN$UsGQGfBQMee.N.eenQTJLISYT5rTJpbDBI0GTdLx60L11R8c9m4x56mM2dmL2qSz4vvzGxN63Clk5NGVtKn9J0";
    extraGroups = [
      "autologin"
      "dialout"
      "networkmanager"
      "pipewire"
      "niceastman"
      "wheel"
      "wireshark"
    ];
    shell = pkgs.zsh;
  };
}
