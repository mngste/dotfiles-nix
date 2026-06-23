{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
  
    dotDir = "${config.xdg.configHome}/zsh";
  
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

    };
  
    # ===== Extra code (fonctions, options, fzf, bindings, etc.) =====
    initContent = ''
      # Options de shell
      setopt AUTOCD
      setopt NOBEEP
      setopt NUMERIC_GLOB_SORT
  
      # ---- Fonction yazi (y) ----
      y() {
        local tmp cwd
        tmp="$(mktemp -t yazi-cwd.XXXXXX)"
        command yazi "$@" --cwd-file="$tmp"
        cwd="$(command cat -- "$tmp" 2>/dev/null)"
        if [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && [ -d "$cwd" ]; then
          builtin cd -- "$cwd"
        fi
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
        local result
        result="$(fd --type f --hidden --strip-cwd-prefix | fzf --preview "$_FZF_PREVIEW_CMD")" \
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
}
