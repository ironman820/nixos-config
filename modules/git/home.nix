{config, ...}:
{
    programs.git = {
        extraConfig = {
            pull.rebase = false;
        };
        signing = {
            key = "9F30DA1A16D74EA7";
            signByDefault = true;
        };
        userEmail = "29488820+ironman820@users.noreply.github.com";
        userName = "Nicholas Eastman";
    };
}