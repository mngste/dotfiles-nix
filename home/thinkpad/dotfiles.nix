{ config, pkgs, inputs, ... }:

{
  # --- ~/.config from dotfiles -----------------------------------

  # Niri
  xdg.configFile."niri/animation.kdl".source = ./files/niri/animation.kdl;
  xdg.configFile."niri/autostart.kdl".source = ./files/niri/autostart.kdl;
  xdg.configFile."niri/bind.kdl".source = ./files/niri/bind.kdl;
  xdg.configFile."niri/config.kdl".source = ./files/niri/config.kdl;
  xdg.configFile."niri/input.kdl".source = ./files/niri/input.kdl;
  xdg.configFile."niri/layout.kdl".source = ./files/niri/layout.kdl;
  xdg.configFile."niri/misc.kdl".source = ./files/niri/misc.kdl;
  xdg.configFile."niri/output.kdl".source = ./files/niri/output.kdl;
  xdg.configFile."niri/window-rule.kdl".source = ./files/niri/window-rule.kdl;
}
