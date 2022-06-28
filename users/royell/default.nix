{pkgs, ...}:

{
  home-manager.users.royell = {
    home = {
      homeDirectory = "/home/royell";
      # packages = with pkgs; [
      # ];
      username = "royell";
    };
    imports = [
      INSTALL_ROOT/etc/nixos/users/home-manager-core.nix
    ];
    programs = {
      home-manager.enable = true;
      zsh.shellAliases = {
        l = "ls -lah";
        la = "ls -lah";
        ll = "ls -lah";
        ls = "ls -a";
        lsa = "ls -lah";
      };
    };
  };

  users.users.royell = {
    isNormalUser = true;
    hashedPassword = "$6$SX8GpVRXT5qcxUe/$cJxPVZVVz8nZ8NhUeK42h6SEG25BsYPCcjXKU6yOnjhDut2eMy9tGzCBOJLj42vELT194gXUeLdJdFYLM25FL1";
    extraGroups = [
      "autologin"
      "dialout"
      "networkmanager"
      "pipewire"
      "royell"
      "wheel"
      "wireshark"
    ];
    shell = pkgs.zsh;
  };
}
