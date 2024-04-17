{ pkgs, hyprland, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = false;
    package = hyprland.packages.${pkgs.system}.default;
  };

  environment.systemPackages = with pkgs; [
    alacritty

    starship
    helix
  ];
}
