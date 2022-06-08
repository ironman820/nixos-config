{pkgs, ...}:

{
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "royell";
  };

  home-manager.users.royell = {
    home.username = "royell";
    home.homeDirectory = "/home/royell";
    home.stateVersion = "22.05";
    programs.home-manager.enable = true;
  };

  users.users.royell = {
    isNormalUser = true;
    hashedPassword = "$6$SX8GpVRXT5qcxUe/$cJxPVZVVz8nZ8NhUeK42h6SEG25BsYPCcjXKU6yOnjhDut2eMy9tGzCBOJLj42vELT194gXUeLdJdFYLM25FL1";
    extraGroups = [
      "royell"
      "networkmanager"
      "pipewire"
      "wheel"
      "autologin"
    ];
    shell = pkgs.zsh;
  };
}
