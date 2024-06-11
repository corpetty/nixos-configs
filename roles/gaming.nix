{ pkgs, ... }:

{
  # Enable Gaming
  programs.steam.enable = true;
  programes.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        softrealtime = "auto";
        renice = 10;
      };
    };
  };
  environment.systemPackages = with pkgs; [
    lutris
    corefonts
    vulkan-tools
    wineWowPackages.stableFull
    wineTricks
  ];

}
