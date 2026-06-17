{ config, pkgs, inputs, ... }:

let
  dot = inputs.dotfiles;
in {
  home.username = "mngt";
  home.homeDirectory = "/home/mngt";
  home.stateVersion = "26.05";

  xdg.enable = true;

  # --- shell / prompt -------------------------------------------------------
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
  
    dotDir = ".config/zsh";

    # ===== Env =====
    sessionVariables = {
      EDITOR = "nvim";
      GITUSER = "mngste";
      TERM = "screen-256color";
      XDG_CONFIG_HOME = "$HOME/.config";
      PATH = "$HOME/.local/bin:$PATH";
    };
  
    # ===== History =====
    history = {
      path = "${config.xdg.dataHome}/zsh/history";
      size = 100000;
      save = 100000;
      append = true;
      share = true;
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      findNoDups = true;
    };
  
    # ===== Aliases =====
    shellAliases = {
      today = "date +%Y-%m-%d";
      md = "mkdir";
  
      "ssh-eval" = "eval \"$(ssh-agent -s)\"";
      spc = "ssh-eval && pass-cli login";
      spcl = "pass-cli ssh-agent load";
  
      nconf = "cd $HOME/.config/nvim/";
  
      # ls / eza
      ls = "eza --icons";
      ll = "eza -lh --icons --git";
      la = "eza -lah --icons --git";
      tree = "eza --tree --icons";
  
      dot = "cd $DOTFILES";
      count = "find . -type f | wc -l";
      v = "nvim";
      fv = "nvim $(fzfb)";
  
      # tmux
      tns = "tmux new -s $(echo $(pwd) | xargs basename)";
  
      # fzf helper
      fzfb = "fzf --preview \"bat --color always --style numbers,changes {}\"";
  
      # cat / bat
      cat = "bat --paging never --theme DarkNeon --style plain,changes";
  
      # docker
      d     = "docker";
      dipru = "docker image prune -a";
      dps   = "docker ps";
      dvls  = "docker volume ls";
      dcu   = "docker compose up -d";
      dcd   = "docker compose down";
  
      # git
      g   = "git";
      ga  = "git add";
      gaa = "git add -A";
      gs  = "git status --short";
      gst = "git status";
      gc  = "git commit -m";
      gca = "git commit --amend";
      gb  = "git branch";
      gco = "git checkout";
      gp  = "git push origin $(git rev-parse --abbrev-ref HEAD)";
      gmg = "git merge";
      gpf = "git push --force";
      lg  = "lazygit";
  
      sc = "source $HOME/.zshrc";
      ec = "$EDITOR $HOME/.zshrc";
    };
  
    # ===== Extra code (fonctions, options, fzf, bindings, etc.) =====
    initExtra = ''
      # Options de shell
      setopt AUTOCD
      setopt NOBEEP
      setopt NUMERIC_GLOB_SORT
  
      # ---- Fonction yazi (y) ----
      y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        command yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d '' cwd < "$tmp"
        [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
        command rm -f -- "$tmp"
      }
  
      # ---- Init zoxide + starship ----
      eval "$(zoxide init zsh)"
      eval "$(starship init zsh)"
  
      # ---- Completion (zstyle) ----
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
  
      # ---- eza utilise les complétions de ls ----
      compdef eza=ls
  
      # ---- fzf: key-bindings & completion depuis le paquet Nix ----
      if [ -f ${pkgs.fzf}/share/fzf/key-bindings.zsh ]; then
        source ${pkgs.fzf}/share/fzf/key-bindings.zsh
        source ${pkgs.fzf}/share/fzf/completion.zsh
      fi
  
      # ---- FZF env ----
      export FZF_DEFAULT_COMMAND='fd --type f --hidden --strip-cwd-prefix'
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      export FZF_DEFAULT_OPTS='
        --height=60%
        --layout=reverse
        --border=rounded
        --prompt="  "
        --pointer="  "
        --preview-window=right:65%:wrap:border-left
      '
      export _FZF_PREVIEW_CMD='bat --color=always --style=plain,numbers --line-range=:500 {}'
      export FZF_CTRL_T_OPTS="--preview '$_FZF_PREVIEW_CMD'"
  
      # Ctrl+F : file picker sans fichiers cachés
      _fzf_file_no_hidden() {
        local cmd result
        cmd="${FZF_DEFAULT_COMMAND/--hidden /}"
        result=$(eval "${cmd:-find . -type f}" | fzf --preview "$_FZF_PREVIEW_CMD") \
          && LBUFFER+="$result"
        zle reset-prompt
      }
      zle -N _fzf_file_no_hidden
  
      # ---- Bindings ----
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down
      bindkey -M vicmd 'k' history-substring-search-up
      bindkey -M vicmd 'j' history-substring-search-down
      bindkey '^F' _fzf_file_no_hidden
      bindkey '^\\' autosuggest-toggle
      bindkey '^[[1;5C' forward-word
      bindkey '^[[1;5D' backward-word
  
      # ---- Fonctions git ----
      gcap() {
        git commit -a -m "$1"
        git push
      }
  
      gmerge() {
        branch=$(git rev-parse --abbrev-ref HEAD) && \
        echo "merging" "$branch" "to" "$1"
        git checkout "$1" && \
        git merge "$branch"
      }
  
      # ---- mdcd ----
      mdcd() {
        mkdir -p -- "$1" && cd -P -- "$1"
      }
    '';
  };

  programs.starship = {
    enable = true;
  };

  # --- ~/.config from dotfiles -----------------------------------
  # Alacritty
  # xdg.configFile."alacritty/alacritty.toml".source = "${dot}/dot_config/alacritty/alacritty.toml";
  # xdg.configFile."alacritty/catppuccin-mocha.toml".source = "${dot}/dot_config/alacritty/catppuccin-mocha.toml";

  # Niri
  xdg.configFile."niri/animation.kdl".source = "${dot}/dot_config/niri/animation.kdl";
  xdg.configFile."niri/autostart.kdl".source = "${dot}/dot_config/niri/autostart.kdl";
  xdg.configFile."niri/backup.kdl".source = "${dot}/dot_config/niri/backup.kdl";
  xdg.configFile."niri/bind.kdl".source = "${dot}/dot_config/niri/bind.kdl";
  xdg.configFile."niri/config.kdl".source = "${dot}/dot_config/niri/config.kdl";
  xdg.configFile."niri/input.kdl".source = "${dot}/dot_config/niri/input.kdl";
  xdg.configFile."niri/layout.kdl".source = "${dot}/dot_config/niri/layout.kdl";
  xdg.configFile."niri/misc.kdl".source = "${dot}/dot_config/niri/misc.kdl";
  xdg.configFile."niri/noctalia.kdl".source = "${dot}/dot_config/niri/noctalia.kdl";
  xdg.configFile."niri/output.kdl".source = "${dot}/dot_config/niri/output.kdl";
  xdg.configFile."niri/window-rule.kdl".source = "${dot}/dot_config/niri/window-rule.kdl";

  # Fastfetch
  xdg.configFile."fastfetch/config.jsonc".source = "${dot}/dot_config/fastfetch/config.jsonc";
  xdg.configFile."fastfetch/logo.txt".source = "${dot}/dot_config/fastfetch/logo.txt";

  # Fuzzel
  xdg.configFile."fuzzel/fuzzel.ini".source = "${dot}/dot_config/fuzzel/fuzzel.ini";

  # Mako
  xdg.configFile."mako/config".source = "${dot}/dot_config/mako/config";

  # Rofi
  # xdg.configFile."rofi/config.rasi".source = "${dot}/dot_config/rofi/config.rasi";
  # xdg.configFile."rofi/tokyo.rasi".source = "${dot}/dot_config/rofi/tokyo.rasi";

  # Starship
  xdg.configFile."starship/starship.toml".source = "${dot}/dot_config/starship/starship.toml";

  # Waybar
  xdg.configFile."waybar/config.jsonc".source = "${dot}/dot_config/waybar/config.jsonc";
  xdg.configFile."waybar/style.css".source = "${dot}/dot_config/waybar/style.css";

  # Yazi
  xdg.configFile."yazi/theme.toml".source = "${dot}/dot_config/yazi/theme.toml";
  xdg.configFile."yazi/yazi.toml".source = "${dot}/dot_config/yazi/yazi.toml";

  # Neovim
  xdg.configFile."nvim".source = "${dot}/dot_config/nvim";

  # --- user pkgs ---------------------------------------------------------
  home.packages = with pkgs; [
    fastfetch
    fuzzel
    mako
    alacritty
    ghostty
    neovim
    yazi
    starship
    waybar
    zoxide
    eza
    bat
    fd
    ripgrep
    fzf
    lazygit
    docker
  ];
}
