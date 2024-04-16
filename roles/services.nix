{ pkgs, ... }:

{
  
  # Enable Services
  services.geoclue2.enable = true;
  programs.direnv.enable = true;
  programs.fish.enable = true;
  services.mpd.enable = true;
  programs.thunar.enable = true;
  services.tumbler.enable = true; 

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
    ffmpeg_6-full
    # wl-screenrec
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
    wpaperd
    # swww
    gifsicle
  ];
}
