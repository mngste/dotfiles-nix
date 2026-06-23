{ pkgs, lib, ... }:

{
  services.displayManager.gdm.enable = true;

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.dconf.enable = true;
}
