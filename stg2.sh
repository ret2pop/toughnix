cd /etc/nixos
sudo nix --extra-experimental-features nix-command --extra-experimental-features flakes flake update
sudo nixos-rebuild switch --flake .#continuity-dell
# home manager weirdness
doas nixos-rebuild switch
