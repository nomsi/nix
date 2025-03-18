{
  config,
  pkgs,
  inputs,
  ...
}:
{
  # Imports
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    inputs.nvchad4nix.homeManagerModule
  ];
  
  # Home dir
  home.username = "emi";
  home.homeDirectory = "/home/emi";
  
  # Home pkgs
  # @TODO: Organize this into files instead
  home.packages = with pkgs; [
    ckb-next
    winetricks
    protontricks
    libreoffice
    qbittorrent
    vlc
    nerdfonts
    protonup-qt
    lutris
    bottles
    discord
    vscode
    looking-glass-client
    bitwarden
    dosbox-x
    readarr
    thunderbird
    vrc-get
    blender
    krita
    davinci-resolve
    gimp
    #xivlauncher - Doesn't launch, use flatpak for now.
    
    # Audio stuff
    mixxx
    yabridge
    lmms
    ardour

    # Gnome Extensions
    gnomeExtensions.gsconnect
    gnomeExtensions.dash-to-dock
    gnomeExtensions.user-themes
    gnomeExtensions.weather-oclock
    gnomeExtensions.spotify-controls
    gnomeExtensions.bing-wallpaper-changer
    gnomeExtensions.blur-my-shell
  ];

  # Dconf
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        # `gnome-extensions list` for a list
        enabled-extensions = [
          "gsconnect@andyholmes.github.io"
          "blur-my-shell@aunetx"
          "weatheroclock@CleoMenezesJr.github.io"
          "BingWallpaper@ineffable-gmail.com"
          "dash-to-dock@micxgx.gmail.com"
          "spotify-controls@Sonath21"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
        ];
      };
      "org/gnome/desktop/interface".show-battery-percentage = true;
    };
  };
  
  # Git
  programs.git = {
    enable = true;
    userName = "Emi Jade";
    userEmail = "me@emi.lgbt";
  };
  
  # nvchad (neovim)
  programs.nvchad = {
    enable = true;
    extraPackages = with pkgs; [
      nodePackages.bash-language-server
      docker-compose-language-service
      dockerfile-language-server-nodejs
      nixd
      rust-analyzer
      coc-clangd
      arduino-language-server
      astro-language-server
      cmake-language-server
      fortran-language-server
      haskell-language-server
      jdt-language-server
      lua-language-server
      (python3.withPackages (
        ps: with ps; [
          python-lsp-server
          flake8
        ]
      ))
    ];
    hm-activation = true;
    backup = true;
  };
  
  # Spicetify (Spotify)
  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
    {
      enable = true;
      theme = spicePkgs.themes.burntSienna;
      enabledExtensions = with spicePkgs.extensions; [
        adblockify
        shuffle
        bookmark
        wikify
        featureShuffle
        songStats
        starRatings
      ];
    };
    
  # Home settings
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}

