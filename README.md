# NixOS & Home-Manager Configuration

![nixos-logo](assets/nixos-official-logo.png)

My [NixOS](https://nixos.org/) and [Home-Manager](https://github.com/nix-community/home-manager) config files.
Based upon [Misterio77's starter configs](https://github.com/Misterio77/nix-starter-configs).

My other configs:
* [neovim](https://github.com/sajenim/neovim-jsm)
* [xmonad](https://github.com/sajenim/xmonad-jsm)

Alternatively [jade](https://github.com/sajenim/jade) provides the plumbing for a desktop environment like experience.  
To be used as a simple home-manager import.

> This repo is often neglected and doesn't necesarrily follow best practices.  
> I recommend only using this repo for inspiration and instead use this
> [boilerplate](https://github.com/Misterio77/nix-starter-configs/tree/main/standard)

## Structure

    .
    ├── flake.lock                          # Pinned dependencies.
    ├── flake.nix                           # Entrypoint for hosts and home configurations.
    ├── nixpkgs.nix                         # A nixpkgs instance.
    ├── shell.nix                           # Shell for bootstrapping.
    ├── assets                              # Various assets.
    ├── config                              # Legacy configuration files.
    ├── home-manager                        # Home Manager configurations.
    │   ├── user.nix                        # User configuration.
    │   ├── programs                        # Program configurations.
    │   └── services                        # Service configurations.
    ├── modules                             # Modules I haven't upstreamed yet.
    │   ├── home-manager                    # Reuseable Home Manager modules.
    │   └── nixos                           # Reuseable NixOS modules.
    ├── nixos                               # NixOS configurations.
    │   └── hostname                        # Directory per host.
    │       ├── configuration.nix           # Server configuration.
    │       └── hardware-configuration.nix  # Generated hardware configuration.
    ├── overlays                            # Patches and version overides.
    └── pkgs                                # Custom packages.

## Installation

    # Clone the configuration files and link them into the NixOS directory
    git clone https://github.com/sajenim/dotfiles.nix.git
    ln -s ~/dotfiles.nix/ /etc/nixos

    # We must be in the repo to access the flake
    cd /etc/nixos

    # Apply the system configuration
    sudo nixos-rebuild switch --flake .#hostname

    # Apply the user configuration
    home-manager switch --flake .#user@hostname

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
* [javacafe01/dotnix](https://github.com/javacafe01/dotnix)
