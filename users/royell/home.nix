{ config, ... }:

{
    home = {
        file = {
            ".ssh/id_rsa.pub".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/royell/ssh/id_rsa.pub";
            ".ssh/id_rsa" = {
                source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/secrets/home/royell/ssh/id_rsa";
                mode = "0400";
            };
        };
        homeDirectory = "/home/royell";
        username = "royell";
    };
}
