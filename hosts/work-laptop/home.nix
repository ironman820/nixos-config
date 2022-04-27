{ config, lib, pkgs, user, ... }:

{
    home.file.".ssh" = {
        source = config.lib.file.mkOutOfStoreSymlink ../../secrets/work-laptop-ssh;
        recursive = true;
    };
}