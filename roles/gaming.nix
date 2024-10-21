{ pkgs, ... }:

{
  # Enable Gaming
  programs.steam = {
    enable = true;
  };
  # programs.gamemode = {
  #   enable = true;
  #   enableRenice = true;
  #   settings = {
  #     general = {
  #       softrealtime = "auto";
  #       renice = 10;
  #     };
  #   };
  # };
  environment.systemPackages = with pkgs; [
    lutris
    corefonts
    # vulkan-tools
    # wineWowPackages.waylandFull
    # winetricks
    # antimicrox
    # appimage-run
    # discord
    # cemu #GDK_BACKEND=x11 cemu #this makes sure it runs as x11 which solves problems in my case
    # dolphin-emu
    # dolphin-emu-primehack
    # dosbox
    # gamemode
    gamescope
    # glibc #unclear if needed
    # gtk3
    # heroic
    # libglvnd #unclear if needed
    # libva-utils
    # libvdpau-va-gl
    # lutris
    # mangohud
    # mesa
    # mesa-demos
    # nvidia-offload
    # nvtop
    protonup-qt #run proton afterwards in terminal to install latest version
    # protontricks
    steam
    steam-run
    steamtinkerlaunch #afterwards run: steamtinkerlaunch compat add
    # vaapiVdpau
    # vkbasalt
    wine
    wineWowPackages.stable
    winetricks
    # xdg-desktop-portal
    # xdg-desktop-portal-gtk
  ];

}
