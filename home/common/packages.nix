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
    vim
    neovim
    tree-sitter

    # dev / ops
    docker
    syncthing

    # others
    obs-studio
    gimp
    libsecret
    chromium
  ];
}
