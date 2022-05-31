{ config, agenix, ... }:

{
    home = {
        file = {
            "personal-gpg/11B0F08E0A4D904B.master.ace".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/secrets/home/global/gpg/11B0F08E0A4D904B.master.ace";
            "personal-gpg/11B0F08E0A4D904B.subkeys.ace".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/secrets/home/global/gpg/11B0F08E0A4D904B.subkeys.ace";
        };
    };
}