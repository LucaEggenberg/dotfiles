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
                ".config/btop".source = "${dotfile-dir}/.config/btop";
                ".config/hypr".source = "${dotfile-dir}/.config/hypr";
                ".config/kitty".source = "${dotfile-dir}/.config/kitty";
                ".config/mako".source = "${dotfile-dir}/.config/mako";
                ".config/waybar".source = "${dotfile-dir}/.config/waybar";
                ".config/wlogout".source = "${dotfile-dir}/.config/wlogout";
                ".config/wofi".source = "${dotfile-dir}/.config/wofi";
            };
        };
    };
}