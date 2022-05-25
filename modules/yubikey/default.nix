{config, pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
        yubioath-desktop
        yubico-piv-tool
        yubikey-manager-qt
        yubikey-personalization-gui
    ];
}