{ pkgs, hyprland, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    package = hyprland.packages.${pkgs.system}.hyprland;
  };

  environment.systemPackages = with pkgs; [
    alacritty

    starship
    helix
  ];
}
