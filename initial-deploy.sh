#!/bin/sh

# Install git first, and you'd probably want vim to make changes.
# You'll also need an ssh key to my server. You can change the
# sources if you don't have access to my server.
sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.old
sudo ln $HOME/src/toughnix/flake.nix /etc/nixos/
sudo ln $HOME/src/toughnix/flake.lock /etc/nixos/
sudo ln $HOME/src/toughnix/configuration.nix /etc/nixos/
sudo ln $HOME/src/toughnix/home.nix /etc/nixos/
sudo cp $HOME/src/toughnix/vars.nix /etc/nixos/
