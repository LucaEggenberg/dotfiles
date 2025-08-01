{
    description = "flake for managing my dotfiles with home-manager";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };

    outputs = { self, nixpkgs, ... }: {
        homeModules.dotfiles = { pkgs, ... }:
        let
            dotfile-dir = builtins.path { path = "${self}/.stow-targets/.config"; };

            waybarConfig = builtins.readFile "${dotfile-dir}/waybar/config.jsonc";
            newWaybarConfig = pkgs.lib.replaceStrings [ "  " ] [ "  " ] waybarConfig;
        in {
            home.file = {
                ".config/btop".source = "${dotfile-dir}/btop";
                ".config/hypr".source = "${dotfile-dir}/hypr";
                ".config/kitty".source = "${dotfile-dir}/kitty";
                ".config/mako".source = "${dotfile-dir}/mako";
                ".config/wlogout".source = "${dotfile-dir}/wlogout";
                ".config/wofi".source = "${dotfile-dir}/wofi";
            };

            programs.waybar = {
                enable = true;

                settings = newWaybarConfig;

                style = builtins.readFile ("${dotfile-dir}/waybar/style.css");
                colors = builtins.readFile ("${dotfile-dir}/waybar/style.css");
            };
        };
    };
}