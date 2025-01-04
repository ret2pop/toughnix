#!/bin/sh

# Install git first, and you'd probably want vim to make changes.
# You'll also need an ssh key to my server. You can change the
# sources if you don't have access to my server.
sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.old
sudo ln $HOME/src/hyprnixmacs/flake.nix /etc/nixos/
sudo ln $HOME/src/hyprnixmacs/flake.lock /etc/nixos/
sudo ln $HOME/src/hyprnixmacs/configuration.nix /etc/nixos/
sudo ln $HOME/src/hyprnixmacs/home.nix /etc/nixos/

mkdir -p ~/org
git clone git@nullring.xyz:/var/git/ret2pop-website ~/org/website
# git clone https://git.nullring.xyz/ret2pop-website.git ~/org/website
mkdir -p ~/src
git clone git@nullring.xyz:/var/git/publish-org-roam-ui ~/src
# git clone https://git.nullring.xyz/publish-org-roam-ui.git ~/org/website

cd /etc/nixos
sudo nix --extra-experimental-features nix-command --extra-experimental-features flakes flake update
read -p "press enter to continue with installing after making changes with vim:"
sudo nixos-rebuild switch

echo "Installlation done! Rebooting..."
sleep 3
reboot
