{ pkgs, ... }:
{
  security.sudo.enable = true;

  security.sudo.extraRules = [
    {
      users = [ "mngt" ];
      commands = [
        {
          command = "${pkgs.nixos-rebuild}/bin/nixos-rebuild";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
