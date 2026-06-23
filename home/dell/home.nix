{ config, pkgs, inputs, ... }:

{
  imports = [
    ../common/default.nix
    # ./dotfiles.nix   # xdg.configFile for niri
  ];

  services.mako.enable = true;

  #programs.waybar = {
  #  enable = true;
  #  systemd.enable = true;
  #};

  programs.fuzzel.enable = true;

  home.username = "mngt";
  home.homeDirectory = "/home/mngt";
  home.stateVersion = "26.05";

  xdg.enable = true;
}
