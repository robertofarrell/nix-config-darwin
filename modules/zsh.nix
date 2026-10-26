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

      alias psb='run-pi-bedrock-container --profile ea-dev --region ap-southeast-2'

      # Download a YouTube URL as M4A for Apple Music
      # Usage: ytm <url>
      ytm() {
        if [[ -z "$1" ]]; then
          echo "Usage: ytm <url>"
          return 1
        fi
        yt-dlp \
          --extract-audio \
          --audio-format m4a \
          --audio-quality 0 \
          --embed-thumbnail \
          --embed-metadata \
          --no-playlist \
          --output "%(title)s.%(ext)s" \
          "$1"
      }

      # Path additions
      export PATH="$HOME/.local/bin:$PATH"
      export PATH="/opt/homebrew/bin:$PATH"
      export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

      # 1Password SSH agent
      export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
      # 1Password Plugins
      source /Users/rob/.config/op/plugins.sh

      # GitHub token from 1Password
      # export GH_TOKEN="$(OP_ACCOUNT=easy-agile.1password.com op-fast read "op://Employee/GitHub - Personal Access Token/credential" 2>/dev/null)"
      export GITHUB_TOKEN=$GH_TOKEN

      # For some reason the task scheduler uses this variable instead of GITHUB_TOKEN, so we need to set it too.
      export NODE_AUTH_TOKEN=$GH_TOKEN

      # Anthropic token from 1Password
      # export ANTHROPIC_API_KEY="$(OP_ACCOUNT=easy-agile.1password.com op-fast read "op://Private/Anthropic API Key/credential" 2>/dev/null)"

      # Atlassian API token from 1Password
      export ATLASSIAN_USER_EMAIL="rob@easyagile.com"
      # export ATLASSIAN_API_TOKEN="$(OP_ACCOUNT=easy-agile.1password.com op-fast read "op://Private/Atlassian API Token/credential" 2>/dev/null)"

      # Remap the Atlassian tokens for Forge Auth
      export FORGE_EMAIL="$ATLASSIAN_USER_EMAIL"
      export FORGE_API_TOKEN="$ATLASSIAN_API_TOKEN"

      # iTerm2 shell integration (script installed via iTerm2 > Install Shell Integration)
      test -e "$HOME/.iterm2_shell_integration.zsh" && source "$HOME/.iterm2_shell_integration.zsh"

      # Claude Sandbox helper function.
      # Delegates to run-sandbox.sh, which mounts $PWD at /workspace and execs
      # the container with argv0 "claude" — Herdr identifies a pane's agent from
      # the foreground process's argv0, and a bare `container run` presents
      # "container", so the pane would never be recognised as a Claude agent.
      #   csb        -> Claude Code in the sandbox
      #   csb bash   -> a shell in the sandbox
      csb() {
        "$HOME/Code/ea/ai-sandbox/claude-sandbox/run-sandbox.sh" "$@"
      }

      cdsb() {
        sbx run claude
      }

      # The Snowflake CLI reads the private key passphrase from PRIVATE_KEY_PASSPHRASE, and errors
      # rather than prompting when it is missing. task-scheduler's direnv exports it, but only under
      # packages/scheduler, so read it per invocation to cover the rest of the filesystem. Passing it
      # on the command keeps the secret out of the ambient environment, unlike the exports above, and
      # an unavailable 1Password falls through so browser-auth connections still work.
      snow() {
        if [[ -z "$PRIVATE_KEY_PASSPHRASE" ]]; then
          local passphrase
          passphrase="$(OP_ACCOUNT=easy-agile.1password.com op-fast read "op://Private/Snowflake/SSH Passphrase" 2>/dev/null)"
          if [[ -n "$passphrase" ]]; then
            PRIVATE_KEY_PASSPHRASE="$passphrase" command snow "$@"
            return
          fi
        fi
        command snow "$@"
      }

      # Activate Mise
      # eval "$(/Users/rob/.local/bin/mise activate zsh)"
    '';
  };
}
