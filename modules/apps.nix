{ pkgs, ...}: {

  ##########################################################################
  #
  #  Install all apps and packages here.
  #
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html
  #
  # TODO Fell free to modify this file to fit your needs.
  #
  ##########################################################################

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    devbox
    direnv
    dfu-programmer
    git
    htop
    lazygit
    m-cli
    musikcube
    neovim
    qmk
    zed-editor
  ];
  environment.variables.EDITOR = "nvim";

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      # Disabling this until I figure out how to install op-fast
      # cleanup = "zap";
    };

    taps = [
      # "homebrew/services"
      # "anomalyco/opencode"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      # "aria2"  # download tool
      "ffmpeg"
      "jiratui"
      "kanata"
      "kanata-tray"
      "node_exporter"
      "nmap"
      "opencode"
      "postgresql@18"
      "sslscan"
      "uv"
      "yt-dlp"
    ];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    casks = [
      "1password-cli"
      "claude-code"
      "ghostty"
      "karabiner-elements"
      "leader-key"
      "logi-options+"
      "mimestream"
      "notion"
      # Failed to install but required so installed manually
      # "cometkim/tap/op-fast"
      "qmk-toolbox"
      "raycast"
      "telegram"
      "ticktick"
      "utm"
      "whatsapp"
    ];
  };
}
