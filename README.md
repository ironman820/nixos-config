# What is this?

This is my collection of dot files which I use to build my Linux systems and control how they are configured.

For more information on NixOS the Linux distribution I use and also nix the packaging tool and language that most of this repository is written in go to [NixOS Web site](https://nixos.org/).

![screenshot](./screenshot.png)

## Warnings

Do not apply these settings on your own system, they are incomplete. I have put them up here for inspiration on creating your own setup.

## Folder structure

```text
|-[system] -- Contains the system level configuration
|-[users] -- Contains the user configuration files
|-flake.nix - Contains the main nix flake.
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

- Boot off the install media.
- Create the partition scheme and mount it to /mnt
- ***NEED TO UPDATE WITH TEMP FOLDER SETTINGS***
- Run `nixos-install --flake github:ironman820/nixos-config`

## sys tool

[Wil Taylor](https://github.com/wiltaylor) created a helper script that is located in systems/scripts.nix file in this repo. It handles a number of different maintenance functions for me (saves me having to remember a heap of commands):

```text
Usage:
sys command

Commands:
clean - GC and hard link nix store
update - Updates dotfiles flake.
update-index - Updates the index of commands in nixpkgs. Used for exec
find - Find a nix package (searches all overlays)
find-doc - Finds documentation on a config item
find-cmd - Finds the package a command is in
apply - Applies current system configuration in dotfiles.
exec - executes a command from any nix pkg without permanently installing it.
vm {config} - Builds one of the machine configs and runs it in a vm.
```

## License

The files and scripts in this repository are licensed under the MIT License, which is a very permissive license allowing you to use, modify, copy, distribute, sell, give away, etc. the software. In other words, do what you want with it. The only requirement with the MIT License is that the license and copyright notice must be provided with the software.
