{pkgs, ...}:

{
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "royell";
  };

  users.users.royell = {
    isNormalUser = true;
    hashedPassword = "Password!";
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
