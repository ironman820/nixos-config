self: super:
{
    vscode-fhs = super.vscode-fhs.overrideAttrs (old: {
        sha256 = "0000000000000000000000000000000000000000000000000000";
        version = "1.69.1";
    });
}