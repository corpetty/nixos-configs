{ pkgs, ... }:

{
  # Systemd services setup
  systemd.packages = pkgs; [
    auto-cpufreq
  ];

  # Enable services
  services = {
    geoclue2.enable = true;
    upower.enable = true;
    dbus = {
      enable = true;
      packages = with pkgs; [
        xfce.xfconf
        gnome2.Gconf
      ];
    };
    mpd.enable = true;
    tumbler.enable = true;
    fwupd.enable = true;
    auto-cpufreq.enable = true;
  };

  programs = {
    direnv.enable = true;
    fish.enable = true;
    dconf.enable = true;
    thunar.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  environment.systemPackages = with pkgs; [
    dbus
    at-spi2-atk
    qt6.qtwayland
    psi-notify
    poweralertd
    swaylock-effects
    swayidle
    playerctl
    psmisc
    grim
    slurp
    imagemagick
    swappy
    ffmeg_6-full
    wf-recorder
    wl-clipboard
    cliphist
    clipboard-jh
    xdg-utils
    wtype
    wlrctl
    hyprpicker
    pyprland
    waybar
    rofi-wayland
    dunst
    avizo
    wlogout
    wpapderd
    gifsicle
  ];
}
