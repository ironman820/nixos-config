{ config, lib, pkgs, user, ... }:

{
    home.file.".ssh/id_rsa".source = config.lib.file.mkOutOfStoreSymlink ../../secrets/home/work-laptop/ssh/id_rsa;
    home.file.".ssh/id_rsa.pub".source = config.lib.file.mkOutOfStoreSymlink ../../secrets/home/work-laptop/ssh/id_rsa.pub;
}