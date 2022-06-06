# What is this?

This is my collection of dot files which I use to build my Linux systems and control how they are configured.

For more information on NixOS the Linux distribution I use and also nix the packaging tool and language that most of this repository is written in go to [NixOS Web site](https://nixos.org/).

## Warnings

Do not apply these settings on your own system, they are incomplete. I have put them up here for inspiration on creating your own setup.

## Branches

* master -- Basic info, readme and install script
* system -- System wide configuration meant to be deployed in the `/etc/nixos` directory for installation and configuration.
* user -- Home manager configurations for deplyment in user's home directory.

## Folder structure

```text
|-[secrets] -- Contains user secrets. You will need to replace these with your own and update the git crypt settings (see below)
|-[system] -- Contains the system level configuration
|-[users] -- Contains the user configuration files
|-install.sh -- Installation script to help with deployment.
|-shell.nix - Creates a nix shell with required tools to install.
```

## HowTo

These dot files can be installed onto a system by 1 of two ways:

### Already running nixos system

If you have setup a nixos system with a configuration.nix file its possible to switch over to this nix config with the following commands:

```shell
nix-shell
nixos-rebuild switch --flake .#
```

The above assuse your computer name matches one of the configurations in the flake.

### Via install media

You can also install this via the install media in the nix-install repo by doing the following:

* Boot off the install media.
* Create the partition scheme and mount it to /mnt
* ***NEED TO UPDATE WITH TEMP FOLDER SETTINGS***
* Run `nixos-install --flake github:ironman820/nixos-config`

## License

The files and scripts in this repository are licensed under the MIT License, which is a very permissive license allowing you to use, modify, copy, distribute, sell, give away, etc. the software. In other words, do what you want with it. The only requirement with the MIT License is that the license and copyright notice must be provided with the software.
