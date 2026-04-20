{ ... }:

{
  imports = [
    ./ghostty.nix
    ./neovim.nix
    ./starship.nix
    ./tmux.nix
    ./zed.nix
    ./zsh.nix
  ];

  # Required by home-manager
  home.stateVersion = "25.05";
}
