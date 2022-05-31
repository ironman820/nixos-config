{config, ...}:
{
    programs.git.extraConfig = {
        commit.gpgsign = true;
        user = {
            name = "Nicholas Eastman";
            email = "29488820+ironman820@users.noreply.github.com";
            signingkey = "9F30DA1A16D74EA7";
        };
    };
}