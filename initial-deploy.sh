#!/bin/sh

# Install git first, and you'd probably want vim to make changes.
# You'll also need an ssh key to my server. You can change the
# sources if you don't have access to my server.
sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.old
sudo ln $HOME/src/toughnix/flake.nix /etc/nixos/
sudo ln $HOME/src/toughnix/flake.lock /etc/nixos/
sudo ln $HOME/src/toughnix/configuration.nix /etc/nixos/
sudo ln $HOME/src/toughnix/home.nix /etc/nixos/

mkdir -p ~/org
git clone git@nullring.xyz:/var/git/ret2pop-website ~/org/website
# git clone https://git.nullring.xyz/ret2pop-website.git ~/org/website
mkdir -p ~/src
git clone git@nullring.xyz:/var/git/publish-org-roam-ui ~/src
# git clone https://git.nullring.xyz/publish-org-roam-ui.git ~/org/website

cd /etc/nixos
sudo nix --extra-experimental-features nix-command --extra-experimental-features flakes flake update
sudo nixos-rebuild switch --flake .#continuity-dell

echo "Installlation done! Rebooting..."
sleep 3
reboot
