
{pkgs, ...}:

{
  home-manager.users.ironman = {
    home = {
      homeDirectory = "/home/ironman";
      packages = with pkgs; [
        albert
        bat # cat replacement
        birdtray
        exa # ls replacement
        gimp
        glances # preferred htop replacement
        synology-drive-client
        thunderbird
        unstable.vscode
        variety
        ventoy-bin
      ];
      stateVersion = "22.05";
      username = "ironman";
    };
    imports = [
      INSTALL_ROOT/etc/nixos/users/core.nix
    ];
    programs = {
      home-manager.enable = true;
      zsh = {
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
