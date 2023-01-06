{ pkgs, ... }:
{
  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;
  # Installs a version of nix, that dosen't need "experimental-features = nix-command flakes" in /etc/nix/nix.conf
  # FIXME not working services.nix-daemon.package = pkgs.nixFlakes;
  
  # if you use zsh (the default on new macOS installations),
  # you'll need to enable this so nix-darwin creates a zshrc sourcing needed environment changes
  programs.zsh.enable = true;
  # bash is enabled by default

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.mat = { pkgs, ... }: {

    home.stateVersion = "22.05";

    programs.tmux = { # tmux configuration, for example
      enable = true;
      keyMode = "vi";
      clock24 = true;
      historyLimit = 10000;
      plugins = with pkgs.tmuxPlugins; [
        vim-tmux-navigator
        gruvbox
      ];
      extraConfig = ''
        new-session -s main
        bind-key -n C-a send-prefix
      '';
    };
  };

  # The homebrew module lets you install software from brew.sh declaratively
  # The module just runs a system installed brew inside the activation script (meaning you’ll have to install homebrew beforehand)
  # https://daiderd.com/nix-darwin/manual/index.html#opt-homebrew.enable
  homebrew = {
    enable = true;
    onActivation = {
      # updates homebrew packages on activation,
      # can make darwin-rebuild much slower (otherwise i'd forget to do it ever though)
      autoUpdate = true;
      upgrade = true;  # upgrade outdated formulae and apps
      cleanup = "none";  # keep brews managed outside
    };

    # https://daiderd.com/nix-darwin/manual/index.html#opt-homebrew.taps
    taps = [
      "aws/tap"
      "clok/sm"
      "cyberark/tools"           # summon
      "danielgtaylor/restish"
      "earthly/earthly"
      "gjbae1212/gossm"
      "hashicorp/tap"
      "instrumenta/instrumenta"  # conftest 
      "warrensbox/tap"           # tfswitch
    ];

    brews = [
      # testing taps
      "restish"
      "danielgtaylor/restish/restish"
    ];


    casks = [
      "1password"
      "app-cleaner"
      "aws-vault"
      "blender"
      "bunqcommunity-bunq"
      "buttercup"
      "calibre"
      "discord"
      "drawio"
      "font-fira-code"
      "font-fira-mono"
      "font-fira-mono-for-powerline"
      "font-fira-sans"
      "garmin-basecamp"
      "garmin-express"
      "garmin-virb-edit"
      "google-chrome"
      "google-drive"
      "icanhazshortcut"
      "inkscape"
      "keybase"
      "kindle"
      "notion"
      "raycast"
      "signal"
      "superslicer"
      "xbar"
      "xnviewp"
      "zoom"
    ];
  };
}