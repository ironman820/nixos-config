{pkgs, ...}:

{
    programs.git.config.safe.directory = [
        "/home/royell/.dotfiles"
    ];

    services.xserver.displayManager.autoLogin = {
        enable = true;
        user = "royell";
    };

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