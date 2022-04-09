{ config, lib, pkgs, user, ... }:

{
    home = {
        file.".config/wall".source = config.lib.file.mkOutOfStoreSymlink ../themes/wall;
    };
}