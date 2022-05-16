{ pkgs, stdenv, dpkg, glibc, gcc-unwrapped, ... }:
let
    pname = "glocom";
    version = "5.3.1";
in
stdenv.mkDerivation {
    name = "glocom-5.3.1";

    src = pkgs.fetchurl {
        url = "https://downloads.bicomsystems.com/desktop/${pname}/public/${version}/${pname}/gloCOM-${version}.deb";
        sha256 = "sha256-zE0lKn2wsG3HQQQgDKr24Q8/r8umO7DD1Q3TNjl62UU=";
    };

    nativeBuildInputs = with pkgs; [
        # autoPatchelfHook
        # libsForQt5.qt5.wrapQtAppsHook
        makeWrapper
        dpkg
    ];

    buildInputs = with pkgs; [
        alsa-lib
        libsForQt5.qt5.qtbase
        gst_all_1.gst-plugins-base
        gnome2.GConf
        libGL
        libsForQt5.qt3d
        libsForQt5.qt5.qtgamepad
        libsForQt5.qt5.qtmultimedia
        libsForQt5.qt5.qtxmlpatterns
        mysql57
        onlyoffice-bin
        postgresql
        xorg.libXcursor
        xorg.libXdamage
        xorg.libXrandr
        xorg.libXrender
        xorg.libXScrnSaver
        xorg.libXtst
        nss
        x11basic
    ] ++
    [
        glibc
        gcc-unwrapped
    ];

    # autoPatchelfIgnoreMissingDeps = true;
    dontWrapQtApps = true;

    unpackPhase = "true";

    installPhase = ''
        mkdir -p $out
        dpkg -x $src $out
        makeWrapper ${pkgs.steam-run}/bin/steam-run $out/bin/gloCOM --add-flags $out/opt/gloCOM/bin/gloCOM
        # mv $out/opt/gloCOM/* $out/
        # rm -rf $out/opt
        # rm $out/bin/glocom
    '';
}