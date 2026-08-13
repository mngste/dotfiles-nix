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
  
  services.udiskie = {
    enable = true;
    settings = {
        # workaround for
        # https://github.com/nix-community/home-manager/issues/632
        program_options = {
            # replace with your favorite file manager
                #file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
        };
    };
};

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
