{ pkgs,  ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    # package = hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  # Attempted fix for QT not seetting plugin path
  environment.variables.QT_QPA_PLATFORM_PLUGIN_PATH = "${pkgs.qt5.qtbase.bin}/lib/qt-${pkgs.qt5.qtbase.version}/plugins";

  environment.systemPackages = with pkgs; [
    hyprland
    pyprland
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    hyprpaper

    # terminal choice
    alacritty

    # screenshots
    grim
    slurp
    swappy

    # editors
    starship
    helix

    # clipboard
    wl-clipboard
    wofi
    cliphist
  ];

  # Allow swaylock to unlock with password
  security.pam.services.swaylock = {};
}
