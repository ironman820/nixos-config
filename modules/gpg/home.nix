{ config, agenix, ... }:

{
    home = {
        file = {
            "personal-gpg/11B0F08E0A4D904B.public.asc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/gpg/keys/11B0F08E0A4D904B.public.asc";
            # "personal-gpg/11B0F08E0A4D904B.stubs.asc".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/secrets/home/global/gpg/11B0F08E0A4D904B.stubs.asc";
            "personal-gpg/install.sh".text = ''
#!/bin/env sh

gpg -K --keyid-format=long | grep 9F30DA1A16D74EA7 > /dev/null
if [ $? != 0]
then
    gpg --import 11B0F08E0A4D904B.public.asc
    echo -e "5\ny\n" |  gpg --command-fd 0 --expert --edit-key 11B0F08E0A4D904B trust;
    echo "If you don't have your GPG Card, the next phase will error out."
    echo "If that happens, run gpg --card-status once your have your card connected."
    read -sp "Please insert your GPG Card and press a key to continue..."
    gpg --card-status

    echo "Finished!"
fi
            '';
        };
    };
}