#!/bin/sh
chmod 644 ~/src/toughnix/configuration.nix
chmod 644 ~/src/toughnix/home.nix
chmod 644 ~/src/toughnix/vars.nix
chmod 644 ~/src/toughnix/flake.lock
chmod 644 ~/src/toughnix/flake.nix

doas chmod 644 /etc/nixos/configuration.nix
doas chmod 644 /etc/nixos/home.nix
doas chmod 644 /etc/nixos/vars.nix
doas chmod 644 /etc/nixos/flake.lock
doas chmod 644 /etc/nixos/flake.nix

emacs --eval '(nerd-icons-install-fonts)'
emacs --eval '(all-the-icons-install-fonts)'
