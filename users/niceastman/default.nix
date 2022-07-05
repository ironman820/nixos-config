
{ pkgs, ...}:

{
  home-manager.users.niceastman = { config, ... }: {
    home = {
      file = {
        ".ssh/id_rsa".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/secrets/keys/niceastman/ssh/id_rsa";
        ".ssh/id_rsa.pub".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/niceastman/ssh/id_rsa.pub";
      };
      homeDirectory = "/home/niceastman";
      username = "niceastman";
    };

    imports = [
      INSTALL_ROOT/etc/nixos/users/home-manager-core.nix
      INSTALL_ROOT/etc/nixos/users/home-manager-personal.nix
    ];

  };

  users.users.niceastman = {
    description = "Nicholas Eastman";
    isNormalUser = true;
    hashedPassword = "$6$PY0A75x0UUOjhBJN$UsGQGfBQMee.N.eenQTJLISYT5rTJpbDBI0GTdLx60L11R8c9m4x56mM2dmL2qSz4vvzGxN63Clk5NGVtKn9J0";
    extraGroups = [
      "autologin"
      "dialout"
      "lp"
      "networkmanager"
      "pipewire"
      "scanner"
      "niceastman"
      "wheel"
      "wireshark"
    ];
    shell = pkgs.zsh;
  };
}
