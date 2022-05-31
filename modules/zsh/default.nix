{config, ...}:
{
    programs.zsh = {
        enable = true;
        ohMyZsh = {
            enable = true;
            plugins = [
                "git"
            ];
            # theme = "robbyrussell";
        };
        shellAliases = {
            cat = "bat";
            df = "df -h";
            ducks = "du -chs * | sort -rh | head -11";
            gpg = "gpg2";
            htop = "glances --percpu";
            l = "exa -lah";
            la = "exa -lah";
            ll = "exa -lah";
            ls = "exa -a";
            lsa = "exa -lah";
            md = "mkdir -p";
            rd = "rmdir";
        };
        shellInit = ''
            export EDITOR="code --wait"
            eval "$(starship init zsh)"
        '';
        syntaxHighlighting.enable = true;
    };
}