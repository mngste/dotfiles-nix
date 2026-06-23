{ config, pkgs, inputs, ... }:

{
  imports = [
    ./dotfiles.nix   # xdg.configFile for alacritty/niri/...
    ./env.nix
    ./fonts.nix
    ./git.nix
    ./nb.nix
    ./noctalia.nix
    ./packages.nix   # home.packages
    ./starship.nix
    ./zsh.nix        # config zsh
  ];

  home.username = "mngt";
  home.homeDirectory = "/home/mngt";
  home.stateVersion = "26.05";

  xdg.enable = true;
}
