{ pkgs, ... }:

{
  # Enable Theme
  environment.variables.GTK_THEME = "Gruvbox-Dark";
  environment.variables.XCURSOR_THEME = "Grubvox-Dark";
  environment.variables.XCURSOR_SIZE = "20";
  environment.variables.HYPRCURSOR_THEME = "Gruvbox-Dark";
  environment.variables.HYPRCURSOR_SIZE = "20";
  console = {
    earlySetup = true;
    colors = [
      "24273a"
      "ed8796"
      "a6da95"
      "eed49f"
      "8aadf4"
      "f5bde6"
      "8bd5ca"
      "cad3f5"
      "5b6078"
      "ed8796"
      "a6da95"
      "eed49f"
      "8aadf4"
      "f5bde6"
      "8bd5ca"
      "a5adcb"
    ];
  };

  # Override packages
  nixpkgs.config.packageOverrides = pkgs: { colloid-icon-theme = pkgs.colloid-icon-theme.override { colorVariants = [ "teal" ]; };
    # NOTE: When Discord needs upgrading, comment out the OpenASAR and run once, then uncomment it back
    discord = pkgs.discord.override {
      withOpenASAR = true;
      withTTS = true;
    };
  };

  environment.systemPackages = with pkgs; [
    numix-icon-theme-circle
    colloid-icon-theme
    gruvbox-dark-gtk
    libsForQt5.qt5ct
  ];

  qt = {
    enable = true;
    # platformTheme = "qt5ct";
    platformTheme = "gtk2";
    style = "gtk2";
  };
  
}
