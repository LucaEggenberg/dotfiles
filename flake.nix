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
                cp ${dotfile-dir}/waybar/colors.css $out/colors.css
                cp ${dotfile-dir}/waybar/config.jsonc $out/config.jsonc
                cp ${dotfile-dir}/waybar/style.css $out/style.css
                cp ${dotfile-dir}/waybar/nix/logo.jsonc $out/logo.jsonc
            '';

            dotFiles = pkgs.runCommand "dotfiles" { } ''
                mkdir -p $out
                cp -r ${dotfile-dir} $out
                find $out -type f -name "*.sh" -exec chmod +x {} +
            '';
        in {
            home.file = {
                ".config/btop".source = "${dotFiles}/btop";
                ".config/hypr".source = "${dotFiles}/hypr";
                ".config/kitty".source = "${dotFiles}/kitty";
                ".config/mako".source = "${dotFiles}/mako";
                ".config/wlogout".source = "${dotFiles}/wlogout";
                ".config/wofi".source = "${dotFiles}/wofi";
                ".config/waybar".source = waybarDir;
            };
        };
    };
}