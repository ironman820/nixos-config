{pkgs, ...}:

{
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "royell";
  };

  home-manager.users.royell = {
    home = {
      homeDirectory = "/home/royell";
      packages = with pkgs; [
        albert
        bat # cat replacement
        birdtray
        exa # ls replacement
        flameshot
        gimp
        glances # preferred htop replacement
        synology-drive-client
        thunderbird
        unstable.vscode
        variety
        ventoy-bin
        virt-viewer
      ];
      stateVersion = "22.05";
      username = "royell";
    };
    programs = {
      home-manager.enable = true;
    };
    xsession = {
      enable = true;
      windowManager.command = "_";
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
