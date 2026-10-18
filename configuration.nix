{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "vessel"; 

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Zurich";

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.qtile.enable = true;
    xkb.layout = "us";
    xkb.variant = "intl";
  };
  console.useXkbConfig = true;

  # basically just the login screen
  services.displayManager.ly.enable = true;
  
  # user setup
  users.users.soul = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    alacritty
  ];

  programs.nix-ld.enable = true;

  services.openssh.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes"];

  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          rightalt = "layer(meta)";
        };
      };
    };
  };

  system.stateVersion = "26.05";

}

