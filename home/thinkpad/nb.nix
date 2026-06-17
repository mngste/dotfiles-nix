{ config, pkgs, lib, ... }:

{

  home.activation.installNb = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.local/bin"

    ${pkgs.curl}/bin/curl -L \
      https://raw.github.com/xwmx/nb/master/nb \
      -o "$HOME/.local/bin/nb"

    chmod +x "$HOME/.local/bin/nb"

    "$HOME/.local/bin/nb" completions install --download || true
  '';
}
