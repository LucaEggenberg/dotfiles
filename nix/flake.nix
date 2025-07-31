{
    description = "flake for managing my dotfiles with home-manager";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };

    outputs = { self, nixpkgs, ... }: {
        homeManagerModules.dotfiles = { pkgs, ... }:
        let
            dotfile-dir = "../.stow-targets/.config";
        in {
            home.file = {
                ".config/btop".source = "${dotfile-dir}/btop";
                ".config/hypr".source = "${dotfile-dir}/hypr";
                ".config/kitty".source = "${dotfile-dir}/kitty";
                ".config/mako".source = "${dotfile-dir}/mako";
                ".config/waybar".source = "${dotfile-dir}/waybar";
                ".config/wlogout".source = "${dotfile-dir}/wlogout";
                ".config/wofi".source = "${dotfile-dir}/wofi";
            };
        };
    };
}