{
    description = "flake for managing my dotfiles with home-manager";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };

    outputs = { self, nixpkgs, ... }: {
        homeManagerModules.dotfiles = { pkgs, ... }:
        let
            dotfile-dir = "${self}/.stow-targets";
        in {
            home.file = {
                ".config" = {
                    source = "${dotfile-dir}/.config";
                    recursive = true;
                };
            };
        };
    };
}