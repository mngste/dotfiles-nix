{ config, pkgs, inputs, ... }:

let
  dot = inputs.dotfiles;
in {

  # --- ~/.config from dotfiles -----------------------------------
  # Alacritty
  # xdg.configFile."alacritty/alacritty.toml".source = "${dot}/dot_config/alacritty/alacritty.toml";
  # xdg.configFile."alacritty/catppuccin-mocha.toml".source = "${dot}/dot_config/alacritty/catppuccin-mocha.toml";

  # Niri
  xdg.configFile."niri/animation.kdl".source = "${dot}/dot_config/niri/animation.kdl";
  xdg.configFile."niri/autostart.kdl".source = "${dot}/dot_config/niri/autostart.kdl";
  xdg.configFile."niri/backup.kdl".source = "${dot}/dot_config/niri/backup.kdl";
  xdg.configFile."niri/bind.kdl".source = "${dot}/dot_config/niri/bind.kdl";
  xdg.configFile."niri/config.kdl".source = "${dot}/dot_config/niri/config.kdl";
  xdg.configFile."niri/input.kdl".source = "${dot}/dot_config/niri/input.kdl";
  xdg.configFile."niri/layout.kdl".source = "${dot}/dot_config/niri/layout.kdl";
  xdg.configFile."niri/misc.kdl".source = "${dot}/dot_config/niri/misc.kdl";
  xdg.configFile."niri/noctalia.kdl".source = "${dot}/dot_config/niri/noctalia.kdl";
  xdg.configFile."niri/output.kdl".source = "${dot}/dot_config/niri/output.kdl";
  xdg.configFile."niri/window-rule.kdl".source = "${dot}/dot_config/niri/window-rule.kdl";

  # Fastfetch
  xdg.configFile."fastfetch/config.jsonc".source = "${dot}/dot_config/fastfetch/config.jsonc";
  xdg.configFile."fastfetch/logo.txt".source = "${dot}/dot_config/fastfetch/logo.txt";

  # Fuzzel
  xdg.configFile."fuzzel/fuzzel.ini".source = "${dot}/dot_config/fuzzel/fuzzel.ini";

  # Mako
  xdg.configFile."mako/config".source = "${dot}/dot_config/mako/config";

  # Rofi
  # xdg.configFile."rofi/config.rasi".source = "${dot}/dot_config/rofi/config.rasi";
  # xdg.configFile."rofi/tokyo.rasi".source = "${dot}/dot_config/rofi/tokyo.rasi";

  # Starship
  xdg.configFile."starship/starship.toml".source = "${dot}/dot_config/starship/starship.toml";

  # Waybar
  xdg.configFile."waybar/config.jsonc".source = "${dot}/dot_config/waybar/config.jsonc";
  xdg.configFile."waybar/style.css".source = "${dot}/dot_config/waybar/style.css";

  # Yazi
  xdg.configFile."yazi/theme.toml".source = "${dot}/dot_config/yazi/theme.toml";
  xdg.configFile."yazi/yazi.toml".source = "${dot}/dot_config/yazi/yazi.toml";

  # Neovim
  xdg.configFile."nvim".source = "${dot}/dot_config/nvim";
}
