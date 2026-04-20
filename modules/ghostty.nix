{ ... }:

#############################################################
#
#  Ghostty terminal configuration
#  (installed via homebrew; config managed via xdg.configFile)
#
#############################################################

{
  xdg.configFile."ghostty/config.ghostty".text = ''
    font-family = JetBrainsMono Nerd Font
    macos-option-as-alt = true
  '';
}
