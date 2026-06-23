{ pkgs, ... }:

{
  services.displayManager.gdm.enable = true;
  services.desktopManager.plasma6.enable = true;

  programs.dconf.enable = true;
  security.polkit.enable = true;
}
