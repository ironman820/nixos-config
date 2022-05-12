{config, ...}:
{
    home.file.".config/variety".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/variety";
}