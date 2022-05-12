{config, pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
        git-crypt
        git-filter-repo
    ];
    programs.git = {
      config = {
        core.editor = "code --wait";
        pull.rebase = false;
        user = {
          name = "Nicholas Eastman";
          email = "29488820+ironman820@users.noreply.github.com";
        };
      };
      enable = true;
    };
}