{ ... }:

#############################################################
#
#  Zed editor configuration
#
#############################################################

{
  programs.zed-editor = {
    enable = true;

    userSettings = {
      buffer_font_size = 13;
      vim_mode = true;
    };
  };
}
