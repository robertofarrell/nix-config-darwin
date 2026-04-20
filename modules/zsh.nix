{ username, ... }:

#############################################################
#
#  Zsh configuration
#
#############################################################

{
  programs.zsh = {
    enable = true;

    # Enable zsh completions for system packages
    enableCompletion = true;

    # Enable syntax highlighting (like fish)
    syntaxHighlighting.enable = true;

    # Shell-wide config appended to ~/.zshrc
    initContent = ''
      # History
      HISTSIZE=10000
      SAVEHIST=10000
      HISTFILE="$HOME/.zsh_history"
      setopt HIST_IGNORE_DUPS       # Don't record duplicate entries
      setopt HIST_IGNORE_SPACE      # Don't record entries starting with a space
      setopt SHARE_HISTORY          # Share history across sessions
      setopt EXTENDED_HISTORY       # Record timestamp with each command

      # Navigation
      setopt AUTO_CD                # cd by typing directory name alone
      setopt AUTO_PUSHD             # Push dirs onto stack automatically
      setopt PUSHD_IGNORE_DUPS      # Don't push duplicates

      # Completion
      setopt MENU_COMPLETE          # Auto-select first completion match
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # case-insensitive completion

      # Devbox autocompletions
      autoload -U compinit; compinit

      # direnv hook
      eval "$(direnv hook zsh)"

      # Aliases
      alias ll='ls -lAh'
      alias la='ls -A'
      alias ..='cd ..'
      alias ...='cd ../..'
      alias g='git'
      alias lg='lazygit'
      alias v='nvim'
      alias t='tmux'

      # Path additions
      export PATH="$HOME/.local/bin:$PATH"
      export PATH="/opt/homebrew/bin:$PATH"

      # 1Password SSH agent
      export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

      # GitHub token from 1Password
      export GH_TOKEN="$(OP_ACCOUNT=ofarrell.1password.com op-fast read "op://Private/GitHub - Personal Access Token/credential" 2>/dev/null)"
    '';
  };
}
