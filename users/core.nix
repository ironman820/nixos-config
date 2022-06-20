{ ... }:
{
    programs.zsh = {
      autocd = true;
      enable = true;
      enableSyntaxHighlighting = true;
      initExtra = ''
        eval "$(starship init zsh)"
      '';
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
        ];
      };
      shellAliases = {
        df = "df -h";
        ducks = "du -chs * | sort -rh | head -11";
        gpg = "gpg2";
        grep = "rg";
        md = "mkdir -p";
        rd = "rmdir";
      };
    };
}