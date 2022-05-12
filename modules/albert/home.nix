{config, ...}:
{
    home.file.".config/albert".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/albert";
}