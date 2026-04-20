{ ... }:

#############################################################
#
#  Starship prompt configuration
#
#############################################################

{
  programs.starship = {
    enable = true;

    settings = {
      # Top-level format: what appears on the prompt line
      format = "$directory$git_branch$git_status$cmd_duration$fill$nix_shell$nodejs$python$rust$golang$java$character";

      # Right-side prompt (above the cursor line)
      right_format = "";

      add_newline = true;

      directory = {
        truncation_length = 4;
        truncate_to_repo = true;
        style = "bold blue";
      };

      git_branch = {
        format = "[ $symbol$branch(:$remote_branch)](bold purple) ";
        symbol = " ";
      };

      git_status = {
        format = "([$all_status$ahead_behind]($style) )";
        style = "bold red";
        conflicted = "⚡";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        untracked = "?";
        stashed = "$";
        modified = "!";
        staged = "+";
        renamed = "»";
        deleted = "✘";
      };

      cmd_duration = {
        min_time = 2000;
        format = "[ $duration]($style) ";
        style = "yellow";
      };

      fill = {
        symbol = " ";
      };

      nix_shell = {
        format = "[ nix]($style) ";
        style = "bold cyan";
        impure_msg = "";
        pure_msg = "";
      };

      nodejs = {
        format = "[ $version]($style) ";
        style = "bold green";
      };

      python = {
        format = "[ $version]($style) ";
        style = "bold yellow";
      };

      rust = {
        format = "[ $version]($style) ";
        style = "bold red";
      };

      golang = {
        format = "[ $version]($style) ";
        style = "bold cyan";
      };

      java = {
        format = "[ $version]($style) ";
        style = "bold red";
      };

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
    };
  };
}
