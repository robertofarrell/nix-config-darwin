{ ... }:

#############################################################
#
#  Tmux configuration
#
#############################################################

{
  programs.tmux = {
    enable = true;

    extraConfig = ''
      # General
      set -g default-terminal "screen-256color"
      set -ga terminal-overrides ",xterm-256color:Tc"
      set -g history-limit 10000
      set -g mouse on
      set -g base-index 1
      setw -g pane-base-index 1
      set -g renumber-windows on

      # Prefix: Ctrl-a
      unbind C-b
      set -g prefix C-a
      bind C-a send-prefix

      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded"

      # Split panes using | and -
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      # New window in current path
      bind c new-window -c "#{pane_current_path}"

      # Vim-style pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Pane resizing
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # Status bar
      set -g status-position top
      set -g status-interval 5
      set -g status-left-length 40
      set -g status-right-length 80
      set -g status-left "#[fg=green]#S #[fg=default]"
      set -g status-right "#[fg=yellow]%H:%M #[fg=cyan]%d-%b-%Y"

      # Vi mode for copy
      setw -g mode-keys vi
      bind Enter copy-mode
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send -X copy-pipe-and-cancel "pbcopy"
    '';
  };
}
