{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName = "mngste";
    userEmail = "mangouste@mosaurus.com";

    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
    };
  };
}
