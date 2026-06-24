{ config, pkgs, inputs, desktop, ... }:

{
  imports = [
    ../common/default.nix
    ./dotfiles.nix   # xdg.configFile for alacritty/niri/...
    ./nb.nix
  ] ++ (if desktop == "niri" then [ inputs.noctalia.homeModules.default ] else []);

  programs.noctalia = {
    enable = desktop == "niri";
    systemd.enable = desktop == "niri";
  };

  services.mako.enable = desktop == "niri";

  #programs.waybar = {
  #  enable = true;
  #  systemd.enable = true;
  #};

  programs.fuzzel.enable = desktop == "niri";

  home.username = "mngt";
  home.homeDirectory = "/home/mngt";
  home.stateVersion = "26.05";

  xdg.enable = true;
}
