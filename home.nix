{ config, pkgs, ... }:

let
    dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
    configs = {
        qtile = "qtile";
        nvim = "nvim";
        alacritty = "alacritty";
        rofi = "rofi";
    };
in

{
    home.username = "soul";
    home.homeDirectory = "/home/soul";
    programs.git.enable = true;
    home.stateVersion = "26.05";
    programs.bash = {
        enable = true;
        shellAliases = {
            btw = "echo I use nixos, btw";
        };
    };

    xdg.configFile = builtins.mapAttrs (name: subpath: {
        source = create_symlink "${dotfiles}/${subpath}/";
        recursive = true;
    })
    configs;

    home.packages = with pkgs; [
        neovim
        ripgrep
        nil
        nixpkgs-fmt
        nodejs
        gcc
        rofi
        fastfetch
        qutebrowser
    ];
}