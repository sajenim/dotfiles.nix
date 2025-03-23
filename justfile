default:
    @just --list

build *ARGS:
  nixos-rebuild build --flake .#{{ARGS}}

switch *ARGS:
  sudo nixos-rebuild switch --flake .#{{ARGS}}

deploy *ARGS:
  nixos-rebuild switch --flake .#{{ARGS}} --target-host {{ARGS}} --use-remote-sudo

