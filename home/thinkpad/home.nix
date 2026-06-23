{ config, pkgs, inputs, ... }:

{
  imports = [
    ./packages.nix   # home.packages
    ./env.nix
    ./zsh.nix        # config zsh
    ./dotfiles.nix   # xdg.configFile for alacritty/niri/...
    ./noctalia.nix
    ./fonts.nix
    ./nb.nix
    ./git.nix
  ];

  home.username = "mngt";
  home.homeDirectory = "/home/mngt";
  home.stateVersion = "26.05";

  xdg.enable = true;
}
