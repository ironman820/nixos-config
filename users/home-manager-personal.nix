{ pkgs, config, ... }:
{
  home = {
    file = {
      ".config/albert".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/albert";
      ".config/kitty/kitty.conf".text = ''
font_family FiraCode Nerd Font Mono
bold_font Fira Code Bold Nerd Font Complete Mono
italic_font Fira Code Light Nerd Font Complete Mono
bold_italic_font Fira Code Medium Nerd Font Complete Mono
      '';
      ".gnupg/scdaemon.conf".text = ''
disable-ccid
      '';
      ".ssh/config".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/secrets/home/global/ssh/config";
      "personal-gpg/install.sh" = {
        executable = true;
        text = ''
#!/usr/bin/env bash

if gpg -K --keyid-format LONG | grep -iq 9F30DA1A16D74EA7 ; then
  exit 0
fi
gpg --receive-keys 185B6FE0AC2034D0EB2F0ADD11B0F08E0A4D904B 2>&1 > /dev/null
echo -e "5\ny\n" | gpg --command-fd 0 --expert --edit-key 11B0F08E0A4D904B trust;
echo "If you don't have your GPG Card, the next phase will error out."
echo "If that happens, run gpg --card-status once your have your card connected."
read -sp "Please insert your GPG Card and press a key to continue..."
gpg --card-status 2>&1 > /dev/null

echo "Finished!"
          '';
      };
      "personal-gpg/changekey.sh" = {
        executable = true;
        text = ''
#!/usr/bin/env bash
echo "Insert the new key to authenticate."
read -sp "Press 'Enter' to continue."
gpg-connect-agent "scd serialno" "learn --force" /bye
echo "Finished"
        '';
      };
      "wallpapers.7z.001".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/walls/wallpapers.7z.001";
      "wallpapers.7z.002".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/walls/wallpapers.7z.002";
      "wallpapers.7z.003".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/walls/wallpapers.7z.003";
      "wallpapers.7z.004".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/walls/wallpapers.7z.004";
      "wallpapers.7z.005".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/walls/wallpapers.7z.005";
      "wallpapers.7z.006".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/walls/wallpapers.7z.006";
    };
  };

  programs = {
    git = {
      enable = true;
      extraConfig = {
        core.editor = "code --wait";
        pull.rebase = false;
      };
      lfs.enable = true;
      signing = {
        key = "9F30DA1A16D74EA7";
        signByDefault = true;
      };
      userEmail = "29488820+ironman820@users.noreply.github.com";
      userName = "Nicholas Eastman";
    };
    home-manager.enable = true;
    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        adpyke.codesnap
        antfu.icons-carbon
        bbenoist.nix
        bierner.markdown-emoji
        bradlc.vscode-tailwindcss
        davidanson.vscode-markdownlint
        dbaeumer.vscode-eslint
        eamodio.gitlens
        esbenp.prettier-vscode
        formulahendry.auto-close-tag
        formulahendry.auto-rename-tag
        formulahendry.code-runner
        mhutchie.git-graph
        mikestead.dotenv
        ms-azuretools.vscode-docker
        ms-python.vscode-pylance
        ms-vscode-remote.remote-ssh
        oderwat.indent-rainbow
        pkief.material-icon-theme
        redhat.vscode-yaml
        streetsidesoftware.code-spell-checker
        usernamehw.errorlens
        vscodevim.vim
        wholroyd.jinja
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "better-comments";
          publisher = "aaron-bond";
          version = "3.0.0";
          sha256 = "17b7m50z0fbifs8azgn6ygcmgwclssilw9j8nb178szd6zrjz2vf";
        }
        {
          name = "arepl";
          publisher = "almenon";
          version = "2.0.3";
          sha256 = "1d3iwcw5ac7nd3m2cxj4v86v1scxkg3zdxyiyrmmmpr2jnlav295";
        }
        {
          name = "preview-pdf";
          publisher = "analytic-signal";
          version = "1.0.0";
          sha256 = "0zdqick3d5xa7nxkmwdh1z174ggsp1prn3f601d0y4lg4j1kvilv";
        }
        {
          name = "vscode-django";
          publisher = "batisteo";
          version = "1.10.0";
          sha256 = "03kr0y7qgsbvp0kcxqlnhqai85g9pdxxys6f36ijvrj6m3f88dmx";
        }
        {
          name = "vscode-intelephense-client";
          publisher = "bmewburn";
          version = "1.8.2";
          sha256 = "1sla3pl3jfdawjmscwf2ml42xhwjaa9ywdgdpl6v99p10w6rvx9s";
        }
        {
          name = "routeros-syntax";
          publisher = "cperezabo";
          version = "1.0.0";
          sha256 = "1n6pqdwqfxf2vcy73z0a2wszh8pfxsm59m3h5v7jvg2wflc64cj7";
        }
        {
          name = "python-environment-manager";
          publisher = "donjayamanne";
          version = "1.0.4";
          sha256 = "16lnkzw96j30lk7i39r1dkdcimmc3kcqq4ri8c77562ay765pfhk";
        }
        {
          name = "python-extension-pack";
          publisher = "donjayamanne";
          version = "1.7.0";
          sha256 = "1rvhhmbl8dn1klni3hj57fbybnsli88hip6jfncd9k0mfgmb00vv";
        }
        {
          name = "vscode-pandoc";
          publisher = "DougFinke";
          version = "0.0.8";
          sha256 = "05hj9fga3l3pjip3axck8fcg77y762kwcv1va6pr72r02km25zap";
        }
        {
          name = "EditorConfig";
          publisher = "EditorConfig";
          version = "0.16.4";
          sha256 = "0fa4h9hk1xq6j3zfxvf483sbb4bd17fjl5cdm3rll7z9kaigdqwg";
        }
        {
          name = "vscode-firefox-debug";
          publisher = "firefox-devtools";
          version = "2.9.7";
          sha256 = "0pbgq783ylmiik4s0dzza50bckhw8j4jyalc4s0jm4dns3n8pch2";
        }
        {
          name = "vscode-insertdatestring";
          publisher = "jsynowiec";
          version = "2.3.1";
          sha256 = "1cm29jggxax3d7i8s3jqs4z9ikh7n85blm8hrha0qz7r55wvc4ia";
        }
        {
          name = "ts-debug";
          publisher = "kakumei";
          version = "0.0.6";
          sha256 = "04j3b8avdvph9j8c3ysv1v8sn5jq8g1k1zc8r1x9mb6v22v182rj";
        }
        {
          name = "vscode-sshfs";
          publisher = "Kelvin";
          version = "1.25.0";
          sha256 = "0v52xrm2p7b4382r7w5cy2r4m8bp2zbz8hz3sy3kgcjlkrjfjn3k";
        }
        {
          name = "vsc-python-indent";
          publisher = "KevinRose";
          version = "1.17.0";
          sha256 = "14vf5p7pn2zgi4lhp6vkndclcxlw3lfdz0immi05gjyx20gp69i1";
        }
        {
          name = "dokuwiki";
          publisher = "kirozen";
          version = "1.4.0";
          sha256 = "1cf3m6x5pn967xr56sasxglkx1rqybpx1mc3kilmc92qlxfzyaw1";
        }
        {
          name = "vscode-markdown-notes";
          publisher = "kortina";
          version = "0.0.24";
          sha256 = "0x433slvgnqislcrhdq9zy6fmznk0mqkqq4yjs4mbzrq1l40z4dg";
        }
        {
          name = "MagicPython";
          publisher = "magicstack";
          version = "1.1.0";
          sha256 = "08zwzjw2j2ilisasryd73x63ypmfv7pcap66fcpmkmnyb7jgs6nv";
        }
        {
          name = "black-formatter";
          publisher = "ms-python";
          version = "2022.3.11861005";
          sha256 = "1qagxchq1mldwmn740fdj012b541n9x924rds9qg0w8qdsjn1p9j";
        }
        {
          name = "isort";
          publisher = "ms-python";
          version = "2022.3.11861002";
          sha256 = "08brq5jcs5hyvqc4mhi9in7gxm3z3xyxx3dzc0v3y3dg8zv1b1cs";
        }
        {
          name = "python";
          publisher = "ms-python";
          version = "2022.11.11952128";
          sha256 = "18pa40ahl27ibh7aji8byk6mi2vhjbb96w7djh8hnsc6032d5j5h";
        }
        {
          name = "jupyter-keymap";
          publisher = "ms-toolsai";
          version = "1.0.0";
          sha256 = "0wkwllghadil9hk6zamh9brhgn539yhz6dlr97bzf9szyd36dzv8";
        }
        {
          name = "remote-containers";
          publisher = "ms-vscode-remote";
          version = "0.242.0";
          sha256 = "0zricxw1fyh4j8xb8wxgk6q1f8llji5460c486vdpk129p8dmcbh";
        }
        {
          name = "remote-ssh-edit";
          publisher = "ms-vscode-remote";
          version = "0.80.0";
          sha256 = "0zgrd2909xpr3416cji0ha3yl6gl2ry2f38bvx4lsjfmgik0ic6s";
        }
        {
          name = "remote-wsl";
          publisher = "ms-vscode-remote";
          version = "0.66.3";
          sha256 = "0lslahxz5c6qxlv7xrq6da1x8ry297c4hgx0cb3iln6brj93j20a";
        }
        {
          name = "vscode-typescript-next";
          publisher = "ms-vscode";
          version = "4.8.20220714";
          sha256 = "0xcwyzfl9474a2f17zr24a3fjx3m7iyjhc0hwwwf02kncm7cz5vz";
        }
        {
          name = "sqltools";
          publisher = "mtxr";
          version = "0.23.0";
          sha256 = "0gkm1m7jss25y2p2h6acm8awbchyrsqfhmbg70jaafr1dfxkzfir";
        }
        {
          name = "sqltools-driver-sqlite";
          publisher = "mtxr";
          version = "0.2.0";
          sha256 = "0icwc6a6krqsanx60xar2j5760khljy1wsvdwxcbfc4xjp4l8dhw";
        }
        {
          name = "autodocstring";
          publisher = "njpwerner";
          version = "0.6.1";
          sha256 = "11vsvr3pggr6xn7hnljins286x6f5am48lx4x8knyg8r7dp1r39l";
        }
        {
          name = "advanced-new-file";
          publisher = "patbenatar";
          version = "1.2.2";
          sha256 = "09a6yldbaz9d7gn9ywkqd96l3pkc0y30b6b02nv2qigli6aihm6g";
        }
        {
          name = "ansible";
          publisher = "redhat";
          version = "0.10.0";
          sha256 = "0fhhyvzn6vcyhlmb5w5vnis3qyn96h8id7fjcp3pv3j3yg9fnw3i";
        }
        {
          name = "vscode-text-tables";
          publisher = "RomanPeshkov";
          version = "0.1.5";
          sha256 = "152c7k4zkrba51q2l8mlj6468280955s2wzjyhyh7qrn1y8gqj65";
        }
        {
          name = "markdown-preview-enhanced";
          publisher = "shd101wyy";
          version = "0.6.3";
          sha256 = "0zn7yk9psmaxk2krbrrfjfgcpmgr15ldf9fn5sc7j7kb1r2q89bl";
        }
        {
          name = "vscode-djaneiro";
          publisher = "thebarkman";
          version = "1.4.2";
          sha256 = "04k9w4gsx3m7kd7mscnywb1ywv4bvzczcxsnb5r1zv5bdmvdfamz";
        }
        {
          name = "vscodeintellicode";
          publisher = "VisualStudioExptTeam";
          version = "1.2.22";
          sha256 = "1svgrdx5p0j81k9lyn8y77rsg9c1l2i7ywwml9wrr54cbl0ynl1a";
        }
        {
          name = "vscode-conventional-commits";
          publisher = "vivaxy";
          version = "1.24.1";
          sha256 = "0sxi955yiivy4dz8f2g96gz24dp52rcxyx19awf2asqib9wgqxfy";
        }
        {
          name = "php-debug";
          publisher = "xdebug";
          version = "1.27.0";
          sha256 = "10grbzxxzhl6nbh967qjsm3zny1m39xa33d9dwrn1r8p22wrffdc";
        }
        {
          name = "markdown-pdf";
          publisher = "yzane";
          version = "1.4.4";
          sha256 = "00cjwjwzsv3wx2qy0faqxryirr2hp60yhkrlzsk0avmvb0bm9paf";
        }
      ];
    };
    zsh = {
      initExtra = ''
        export EDITOR="code --wait"
      '';
      shellAliases = {
        cat = "bat";
        htop = "glances --percpu";
        l = "exa -lah";
        la = "exa -lah";
        ll = "exa -lah";
        ls = "exa -a";
        lsa = "exa -lah";
        vim = "code --wait";
      };
    };
  };
}
