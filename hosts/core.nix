{ config, pkgs, ... }:

let
  qt5Packages = with pkgs.libsForQt5; [
    ark
    qtstyleplugin-kvantum
    sddm-kcm
  ];

  sysPackages = with pkgs; [
    adoptopenjdk-icedtea-web
    agenix.agenix
    # audiorelay
    bat # cat replacement
    bind
    birdtray
    bottles
    # cups-pdf
    ddrescue
    ddrescueview
    exa # ls replacement
    firefox
    flameshot
    font-manager
    galculator
    gimp
    git-crypt
    git-filter-repo
    glances # preferred htop replacement
    gnome.simple-scan
    google-chrome
    googleearth-pro
    haruna
    htop
    jre8
    kubectl
    kubernetes-helm-wrapped
    libreoffice
    libykclient
    meld
    microsoft-edge
    nfs-utils
    nix-index
    nixos-icons
    nmap
    nodejs
    p7zip
    pavucontrol
    poetry
    pulseaudio # used for pactl, not enabled
    putty
    pv
    python39Packages.ntlm-auth
    python3Full
    restic
    ripgrep
    sqlitebrowser
    starship
    synology-drive-client
    thunderbird
    tree
    unixODBC
    ventoy-bin
    vim
    virt-viewer
    vlc
    vscode-with-extensions
    wget
    yubioath-desktop
    yubico-piv-tool
    yubikey-manager-qt
    yubikey-personalization-gui
    yubikey-touch-detector
  ];

  unstablePackages = with pkgs.unstable; [
  ];

in

{
  # pkgs.overlays = [ inputs.nur.overlay ];
  imports = [
    (import (builtins.fetchTarball {
      url = "https://github.com/jmackie/nixos-networkmanager-profiles/archive/master.tar.gz";
      sha256 = "0x18qkwxfzmhbn6cn2da0xn27mxnmiw56qwx3kjvy9ljcar5czvh";
    }))
    <agenix/modules/age.nix>
    INSTALL_ROOT/etc/nixos/hardware-configuration.nix
    <home-manager/nixos>
    INSTALL_ROOT/etc/nixos/modules/scanners/sane-extra-config.nix
  ];

  boot = {
    cleanTmpDir = true;
    consoleLogLevel = 3;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        configurationLimit = 10;
        consoleMode = "auto";
        enable = true;
      };
      timeout = 2;
    };
    plymouth.enable = true;
  };

  environment = {
    shells = [ pkgs.zsh ];
    systemPackages = qt5Packages ++ sysPackages ++ unstablePackages;
  };

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      corefonts
      nerdfonts
      open-sans
    ];
  };

  hardware = {
    pulseaudio.enable = false;
    sane = {
      enable = true;
      extraBackends = with pkgs; [
        hplipWithPlugin
        sane-airscan
      ];
    };
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  # Flake Ready!
  nix = {
    autoOptimiseStore = true;
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
      randomizedDelaySec = "1mins";
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        agenix = import <agenix> {};
        unstable = import <nixos-unstable> {
          config = config.nixpkgs.config;
        };
        vscode = pkgs.callPackage INSTALL_ROOT/etc/nixos/modules/vscode/vscode.nix {};
        vscode-with-extensions = pkgs.callPackage INSTALL_ROOT/etc/nixos/modules/vscode/with-extensions.nix {
          vscodeExtensions = with pkgs.vscode-extensions; [
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
      };
      permittedInsecurePackages = [
        "googleearth-pro-7.3.4.8248"
      ];
    };
    # overlays = [
    #   (import INSTALL_ROOT/etc/nixos/overlays/vscode)
    # ];
  };

  networking = {
    firewall.enable = false;
    networkmanager.enable = true;
    useDHCP = false;
  };

  programs = {
    dconf.enable = true;
    git = {
      enable = true;
      lfs.enable = true;
      config = {
        pull.rebase = true;
      };
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = "qt";
    };
    java.enable = true;
    mtr.enable = true;
    vim.defaultEditor = true;
    wireshark.enable = true;
    zsh = {
      enable = true;
      enableGlobalCompInit = false;
      setOptions = [
        "autocd"
        "HIST_IGNORE_DUPS"
        "SHARE_HISTORY"
        "HIST_FCNTL_LOCK"
      ];
      shellAliases = {
        df = "df -h";
        ducks = "du -chs * | sort -rh | head -11";
        gpg = "gpg2";
        grep = "rg";
        l = "ls -lah";
        la = "ls -lah";
        ll = "ls -lah";
        ls = "ls -a";
        lsa = "ls -lah";
        md = "mkdir -p";
        pv = "pv -pte";
        rd = "rmdir";
      };
      syntaxHighlighting.enable = true;
    };
  };

  security = {
    rtkit.enable = true; # needed for pipewire
    sudo.wheelNeedsPassword = false;
    # pam.yubico.enable = true;
  };

  services = {
    auto-cpufreq.enable = true;
    avahi = {
      enable = true;
      nssmdns = true;
    };
    gnome.gnome-keyring.enable = true;
    haveged.enable = true;
    openssh.enable = true;
    pcscd.enable = true; # smart card library for Yubikey access
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    printing = {
      drivers = with pkgs; [
        gutenprint
        hplip
      ];
      enable = true;
    };
    saned.enable = true;
    xserver = {
      enable = true;
      displayManager = {
        sddm = {
          enable = true;
        };
      };
      desktopManager.plasma5.enable = true;
      layout = "us";
    };
    yubikey-agent.enable = true;
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = false;
    };
    spiceUSBRedirection.enable = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
