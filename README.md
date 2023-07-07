# NixOS & Home-Manager Configuration

![nixos-logo](assets/nixos-official-logo.png)

My [NixOS](https://nixos.org/) and [Home-Manager](https://github.com/nix-community/home-manager) config files.
Based upon [Misterio77's starter configs](https://github.com/Misterio77/nix-starter-configs).

> This repo is often neglected and doesn't necesarrily follow best practices.  
> I recommend only using this repo for inspiration and instead use this
> [boilerplate](https://github.com/Misterio77/nix-starter-configs/tree/main/standard)

## Installation

    # Clone the configuration files
    git clone https://github.com/sajenim/dotfiles.nix.git

    # We must be in the repo to access the flake
    cd ~/dotfiles.nix

    # Apply the system configuration
    sudo nixos-rebuild switch --flake .#hostname

    # Apply the user configuration
    home-manager switch --flake .#user@hostname

## Applications
Main programs that create my desktop experience.

* neovim
* wezterm
* xmonad
* xmobar

## Self hosted services
Services are hosted on a Raspberry Pi 4 Model B with podman containers.  
Volume backups are performed with BorgBackup.

**Networking:**
* pihole
* traefik

**Media stack:**
* plex
* sonarr
* radarr
* prowlarr
* recyclarr

**Miscellaneous:**
* homepage
* qbittorrent
* minecraft

## FAQ
* **What is nix?**  
Nix is a tool that takes a unique approach to package management and system configuration.
* **Nix benefits**  
Nix is reproducible, declarative and reliable.
* **Why flakes?**  
Flakes allow you to specify your code's dependencies (e.g. remote Git repositories) in a declarative way,
simply by listing them inside a flake.nix file.

## Credit
### Boilerplate
* [Misterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)
### Other Configs
* [fortuneteller2k/nix-config](https://github.com/fortuneteller2k/nix-config)
* [javacafe01/nix-config](https://github.com/javacafe01/nix-config)
