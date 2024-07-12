# cattywampus system configuration

{ config, pkgs, lib, hyprland, ... }:

{
  imports =
    [ 
      # include general system configurations
      ../configuration.nix
      # include hardware specific configurations
      ./hardware-configuration.nix  
      ../../roles/nvidia.nix
      ../../roles/display-manager.nix
      ../../roles/keycard.nix
      ../../roles/obs.nix
      ../../roles/virtualization.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  # hostname
  networking.hostName = "bean"; # Define your hostname.

  # enable network streaming of audio (export and import)
  # hardware.pulseaudio.zeroconf.discovery.enable = true;
  # hardware.pulseaudio.zeroconf.publish.enable = true;

  # If using hyprland with nvidia
  environment.sessionVariables = {
      WLR_RENDERER_ALLOW_SOFTWARE = "1";

      GBM_BACKEND = "nvidia-drm";
      LIBVA_DRIVER_NAME = "nvidia"; # hardware acceleration
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";

      CLUTTER_BACKEND = "wayland";

      # GDK_BACKEND="wayland,x11";
      # QT_QPA_PLATFORM = "wayland;xcb";
      # SDL_VIDEODRIVER = "wayland";
      # OZONE_PLATFORM = "wayland";
      # NIXOS_OZONE_WL = "1";
      # MOZ_ENABLE_WAYLAND = "1";
      # MOZ_DISABLE_RDD_SANDBOX = "1";
      # QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      # XDG_CURRENT_DESKTOP = "Hyprland";
      # XDG_SESSION_DESKTOP = "Hyprland";
      # XDG_SESSION_TYPE = "wayland";
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}
