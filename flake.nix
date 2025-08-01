{
    description = "flake for managing my dotfiles with home-manager";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };

    outputs = { self, nixpkgs, ... }: {
        homeModules.dotfiles = { pkgs, ... }:
        let
            dotfile-dir = builtins.path { path = "${self}/.stow-targets/.config"; };

            waybarDir = pkgs.runCommand "waybar-config" { } ''
                mkdir -p $out
                cp -r ${dotfile-dir}/waybar/* $out
                cp ${dotfile-dir}/waybar/nix/logo.jsonc $out/logo.jsonc
            '';
        in {
            home.file = {
                ".config/btop".source = "${dotfile-dir}/btop";
                ".config/hypr".source = "${dotfile-dir}/hypr";
                ".config/kitty".source = "${dotfile-dir}/kitty";
                ".config/mako".source = "${dotfile-dir}/mako";
                ".config/wlogout".source = "${dotfile-dir}/wlogout";
                ".config/wofi".source = "${dotfile-dir}/wofi";
                ".config/waybar".source = waybarDir;
            };
        };
    };
}