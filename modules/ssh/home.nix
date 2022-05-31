{config, ...}:
{
    home.file.".ssh/known_hosts".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/secrets/home/global/ssh/known_hosts";
    home.file.".ssh/known_hosts.old".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/secrets/home/global/ssh/known_hosts.old";
}