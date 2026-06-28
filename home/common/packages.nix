{ pkgs, ... }:

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
  ];

  let
  protonDrive = pkgs.fetchurl {
    url = "https://proton.me/download/drive/cli/0.4.6/linux-x64/proton-drive";
    sha256 = "d187409932742e6fdc6aae2995998f4c89ea51999283395bc8d0bdc5343a79d31bf5a485d5af9adf3b7909fc92f2d2ef0b133edc4939d5faf1d096eb744425bb";
  };
  in {
    home.packages = [
      pkgs.libsecret
      (pkgs.writeShellScriptBin "proton-drive" ''
        exec ${protonDrive} "$@"
      '')
    ];
  };
}


