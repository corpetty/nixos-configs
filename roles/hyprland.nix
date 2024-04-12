{ pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    # https://www.reddit.com/r/hyprland/comments/17j12jz/finally_got_xwayland_on_nvidia_working_perfectly/
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";

    # AppImage not seeing fonts, might be causing other issues too
    XDG_CONFIG_HOME = "$HOME/etc";
  };

  environment.systemPackages = with pkgs; [
    alacritty

    starship
    helix
  ]
}
