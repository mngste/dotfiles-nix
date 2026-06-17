{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Shell / navigation
    zoxide
    starship
    eza
    bat
    fd
    ripgrep
    fzf
    lazygit
    yazi

    # Term / WM / outils
    alacritty
    ghostty
    fastfetch
    fuzzel
    mako
    neovim

    # Dev / ops
    docker
  ];
}
