{ config, pkgs, ... }:

{
  programs.noctalia = {
      systemd.enable = true;  # active le service systemd user
  };
}
