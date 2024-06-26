#!/usr/bin/env bash

echo "Generating The Hardware Configuration"
sudo nixos-generate-config --show-hardware-config >hardware.nix

echo "-----"

echo "Now Going To Build IceTank, 🤞"
NIX_CONFIG="experimental-features = nix-command flakes"
sudo nixos-rebuild switch --flake .#icetank --option substituters "https://mirror.sjtu.edu.cn/nix-channels/store"
