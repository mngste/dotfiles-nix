{ pkgs, ... }:

let
  protonDrive = pkgs.fetchurl {
    url = "https://proton.me/download/drive/cli/0.4.6/linux-x64/proton-drive";
    sha256 = pkgs.lib.fakeSha256;
  };
in
{
  home.packages = with pkgs; [
    # shell / navigation
    zoxide
    starship
    eza
    bat
    fd
    ripgrep
    fzf
    lazygit
    yazi

    # term / WM / tools
    alacritty
    ghostty
    fastfetch
    fuzzel
    mako
    neovim

    # dev / ops
    docker

    # others
    obs-studio
    firefox
    proton-pass-cli
    libsecret
    (writeShellScriptBin "proton-drive" ''
      exec ${protonDrive} "$@"
    '')
  ];
}
