{ pkgs, ... }:

  ###################################################################################
  #
  #  macOS's System configuration
  #
  #  All the configuration options are documented here:
  #    https://daiderd.com/nix-darwin/manual/index.html#sec-options
  #
  ###################################################################################
{
  system = {
    stateVersion = 6;

    #activationScripts.postUserActivation.text = ''
        # Following line should allow us to avoid a logout/login cycle
        #/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    #'';

    defaults = {
      menuExtraClock.Show24Hour = true;  # show 24 hour clock

      # other macOS's defaults configuration.
      # ......

      # customize dock
      dock = {
        autohide = true;
        show-recents = false;  # disable recent apps
      };

      NSGlobalDomain = {
	# Always show the scrollbars
	AppleShowScrollBars = "Always";

	# Jump to the spot that's clicked in the scroll bar
	AppleScrollerPagingBehavior = true;

        InitialKeyRepeat = 15;  # normal minimum is 15 (225 ms), maximum is 120 (1800 ms)
        KeyRepeat = 3;  # normal minimum is 2 (30 ms), maximum is 120 (1800 ms)

        ApplePressAndHoldEnabled = false;  # disable press and hold so VIM works better

        "com.apple.sound.beep.feedback" = 0;  # disable beep sound when pressing volume up/down key

        # Add a context menu item for showing the Web Inspector in web views
        #
        # WebKitDeveloperExtras = true;
      };

      finder = {
        AppleShowAllExtensions = true;  # show all file extensions

        QuitMenuItem = true;  # enable quit menu item
        ShowPathbar = true;  # show path bar
        ShowStatusBar = true;  # show status bar
      };

      # Customize settings that not supported by nix-darwin directly
      # see the source code of this project to get more undocumented options:
      #    https://github.com/rgcr/m-cli
      #
      # All custom entries can be found by running `defaults read` command.
      # or `defaults read xxx` to read a specific domain.
      CustomUserPreferences = {
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };

        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = true;
          ShowHardDrivesOnDesktop = true;
          ShowMountedServersOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          _FXSortFoldersFirst = true;
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";

          # Show list view in Finder
          FXPreferredViewStyle = "Nlsv";
        };
      };
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;
}
