{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name  = "mngste";
        email = "mangouste@mosaurus.com";
      };
      core.editor = "nvim";
      init.defaultBranch = "main";
    };
  };
}
