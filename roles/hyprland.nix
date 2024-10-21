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

  # Attempted fix for QT not setting plugin path
  environment.variables.QT_QPA_PLATFORM_PLUGIN_PATH = "${pkgs.qt5.qtbase.bin}/lib/qt-${pkgs.qt5.qtbase.version}/plugins";

  environment.systemPackages = with pkgs; [
    hyprland
    pyprland
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

    # clipboard extras
    wofi
    cliphist
    # fix for hyprland 0.41.2 clipboard sharing between Xwayland and wayland 
    # (uses clipshare script in ~/.local/share/bin/ )
    xclip clipnotify
    libnotify

    hyprpanel
    # hyprpanel requirements
    libgtop
    bluez
    bluez-tools
    grimblast
    gpu-screen-recorder
    hyprpicker
    btop
    networkmanager
    matugen
    wl-clipboard
    swww
    dart-sass
    brightnessctl
    gnome-bluetooth
  ];

  # Allow swaylock to unlock with password
  security.pam.services.swaylock = {};
}
