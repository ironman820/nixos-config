{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
    name = "nixosbuildshell";
    buildInputs = with pkgs; [
        (callPackage <agenix/pkgs/agenix.nix> {})
        file
        git
        git-crypt
        gnupg
        hello
        figlet
        nixFlakes
        pinentry-curses
    ];
    shellHook = ''
        export GPG_TTY=$(tty)
        unset DISPLAY
        echo "pinentry-program $(which pinentry)\nallow-loopback-pinentry" | sudo tee /root/.gnupg/gpg-agent.conf > /dev/null 2>&1
        sudo gpg-connect-agent reloadagent /bye
        # hello | figlet

        # echo "This is a config installation repo. Get started by running install.sh"
    '';
}
