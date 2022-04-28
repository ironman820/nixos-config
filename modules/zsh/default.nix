{config, ...}:
{
    programs.zsh = {
        enable = true;
        ohMyZsh = {
            enable = true;
        };
        shellAliases = {
            cat = "bat";
            df = "df -h";
            ducks = "du -chs * | sort -rh | head -11";
            l = "exa -lah";
            la = "exa -lah";
            ll = "exa -lah";
            ls = "exa -a";
            lsa = "exa -lah";
            md = "mkdir -p";
            rd = "rmdir";
            htop = "glances --percpu";
        };
        shellInit = ''
            eval "$(starship init zsh)"
        '';
    };
}