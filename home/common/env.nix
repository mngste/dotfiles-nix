{ config, pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
    GITUSER = "mngste";
    PATH = "$HOME/.local/bin:$PATH";
  };
}
