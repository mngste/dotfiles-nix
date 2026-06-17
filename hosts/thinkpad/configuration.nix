{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "thinkpad";

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "fr_FR.UTF-8";
  };

  # principal user
  users.users.mngt = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.zsh;
  };

  # nix flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # network / audio / etc.
  networking.networkmanager.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.printing.enable = true;

  # gui wayland with niri
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  programs.niri.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    fastfetch
    btop
    neovim
    yazi
    starship

    alacritty
    ghostty
    fuzzel
    mako
  ];

  programs.zsh.enable = true;

  system.stateVersion = "26.05";
}
