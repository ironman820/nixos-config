{pkgs, ...}:

{
    users.users.royell = {
        isNormalUser = true;
        initialPassword = "Password!";
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