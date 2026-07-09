{ ... }:
{
  security.sudo.enable = true;

  security.sudo.extraRules = [
    {
      users = [ "mngt" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/nixos-rebuild";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
