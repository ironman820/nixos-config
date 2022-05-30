{config, pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
        yubioath-desktop
        yubico-piv-tool
        yubikey-manager-qt
        yubikey-personalization-gui
        yubikey-touch-detector
    ];

    services.pcscd.enable = true;
}