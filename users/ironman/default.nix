
{pkgs, ...}:

{
  home-manager.users.ironman = { config, ... }: {
    home = {
      file = {
        ".ssh/id_rsa".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/secrets/keys/ironman/ssh/id_rsa";
        ".ssh/id_rsa.pub".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/ironman/ssh/id_rsa.pub";
      };
      homeDirectory = "/home/ironman";
      username = "ironman";
    };

    imports = [
      INSTALL_ROOT/etc/nixos/users/home-manager-core.nix
      INSTALL_ROOT/etc/nixos/users/home-manager-personal.nix
    ];
  };

  users.users.ironman = {
    isNormalUser = true;
    hashedPassword = "$6$PY0A75x0UUOjhBJN$UsGQGfBQMee.N.eenQTJLISYT5rTJpbDBI0GTdLx60L11R8c9m4x56mM2dmL2qSz4vvzGxN63Clk5NGVtKn9J0";
    extraGroups = [
      "autologin"
      "dialout"
      "networkmanager"
      "pipewire"
      "ironman"
      "wheel"
      "wireshark"
    ];
    shell = pkgs.zsh;
  };
}
