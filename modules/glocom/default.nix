{ pkgs, ... }:
let
    glocom-deb = pkgs.callPackage ./derivation.nix {};
    glocom = pkgs.writeShellScriptBin "glocom" ''
        #!/bin/env sh

        APP_NAME="gloCOM"

        export QT_XKB_CONFIG_ROOT="${pkgs.xkeyboard_config}/share/X11/xkb"
        export QT_PLUGIN_PATH="${glocom-deb}/opt/gloCOM/lib/plugins"
        export LD_LIBRARY_PATH="${glocom-deb}/opt/gloCOM/lib"

        #check if input arguments contain 'glocom://'
        flag1=`echo $@|awk '{print match($0,"glocom://")}'`;
        flag2=`echo $@|awk '{print match($0,"tel://")}'`;
        flag3=`echo $@|awk '{print match($0,"sip://")}'`;
        flag4=`echo $@|awk '{print match($0,"callto://")}'`;

        if [ $flag1 -gt 0 ];then
                #remove spaces from input arguiments
                number=`echo "$@" | sed 's/ //g'`
                ${glocom-deb}/bin/$APP_NAME $number
                        exit 1
        elif [ $flag2 -gt 0 ];then
                #remove spaces from input arguiments
                number=`echo "$@" | sed 's/ //g' | sed 's/tel/glocom/'`
                ${glocom-deb}/bin/$APP_NAME $number
                        exit 1
        elif [ $flag3 -gt 0 ];then
                #remove spaces from input arguiments
                number=`echo "$@" | sed 's/ //g' | sed 's/sip/glocom/'`
                ${glocom-deb}/bin/$APP_NAME $number
                        exit 1
        elif [ $flag4 -gt 0 ];then
                #remove spaces from input arguiments
                number=`echo "$@" | sed 's/ //g' | sed 's/callto/glocom/'`
                ${glocom-deb}/bin/$APP_NAME $number
                        exit 1
        else
                ${glocom-deb}/bin/$APP_NAME $1
                        exit $?
        fi
    '';
    glocomDesktop = pkgs.makeDesktopItem {
        name = "gloCOM";
        type = "Application";
        desktopName = "gloCOM";
        comment = "Global Communications Tool for PBXware";
        exec = "${glocom}/bin/glocom %u";
        icon = "${glocom-deb}/usr/share/gloCOM/logo.png";
        categories = "Application;Network;";
    };
in {
    environment.systemPackages = [
        glocom
        glocomDesktop
    ];
}

    
