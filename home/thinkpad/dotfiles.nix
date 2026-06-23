{ config, pkgs, inputs, ... }:

{
  # --- ~/.config from dotfiles -----------------------------------
  # Alacritty
  # xdg.configFile."alacritty/alacritty.toml".source = ./files/alacritty/alacritty.toml;
  # xdg.configFile."alacritty/catppuccin-mocha.toml".source = ./files/alacritty/catppuccin-mocha.toml;

  # Niri
  xdg.configFile."niri/animation.kdl".source = ./files/niri/animation.kdl;
  xdg.configFile."niri/autostart.kdl".source = ./files/niri/autostart.kdl;
  xdg.configFile."niri/backup.kdl".source = ./files/niri/backup.kdl;
  xdg.configFile."niri/bind.kdl".source = ./files/niri/bind.kdl;
  xdg.configFile."niri/config.kdl".source = ./files/niri/config.kdl;
  xdg.configFile."niri/input.kdl".source = ./files/niri/input.kdl;
  xdg.configFile."niri/layout.kdl".source = ./files/niri/layout.kdl;
  xdg.configFile."niri/misc.kdl".source = ./files/niri/misc.kdl;
  xdg.configFile."niri/noctalia.kdl".source = ./files/niri/noctalia.kdl;
  xdg.configFile."niri/output.kdl".source = ./files/niri/output.kdl;
  xdg.configFile."niri/window-rule.kdl".source = ./files/niri/window-rule.kdl;

  # Fastfetch
  xdg.configFile."fastfetch/config.jsonc".source = ./files/fastfetch/config.jsonc;
  xdg.configFile."fastfetch/logo.txt".source = ./files/fastfetch/logo.txt;

  # Fuzzel
  xdg.configFile."fuzzel/fuzzel.ini".source = ./files/fuzzel/fuzzel.ini;

  # Mako
  xdg.configFile."mako/config".source = ./files/mako/config;

  # Rofi
  # xdg.configFile."rofi/config.rasi".source = ./files/rofi/config.rasi;
  # xdg.configFile."rofi/tokyo.rasi".source = ./files/rofi/tokyo.rasi;

  # Starship
  xdg.configFile."starship/starship.toml".source = ./files/starship/starship.toml;

  # Waybar
  xdg.configFile."waybar/config.jsonc".source = ./files/waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source = ./files/waybar/style.css;

  # Yazi
  xdg.configFile."yazi/theme.toml".source = ./files/yazi/theme.toml;
  xdg.configFile."yazi/yazi.toml".source = ./files/yazi/yazi.toml;

  # Neovim
  xdg.configFile."nvim".source = ./files/nvim;
}
