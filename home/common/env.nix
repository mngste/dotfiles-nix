{ config, pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
    GITUSER = "mngste";
    XDG_CONFIG_HOME = "$HOME/.config";
    PATH = "$HOME/.local/bin:$PATH";
  };
}
