{ config, pkgs, inputs, ... }:

{
  imports = [
    ../common/default.nix
    ./dotfiles.nix   # xdg.configFile for alacritty/niri/...
    ./nb.nix
  ];

  home.username = "mngt";
  home.homeDirectory = "/home/mngt";
  home.stateVersion = "26.05";

  xdg.enable = true;
}
