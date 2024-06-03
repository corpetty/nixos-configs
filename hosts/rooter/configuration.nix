# cattywampus system configuration

{ config, pkgs, lib, hyprland, ... }:

{
  imports =
    [ 
      # include general system configurations
      ../configuration.nix
      # include hardware specific configurations
      ./hardware-configuration.nix  
      # ../../roles/display-manager.nix
      ../../roles/hyprland.nix
      ../../roles/services.nix
    ];

  # NixOS recommends using this on AMD platforms
  services.power-profiles-daemon.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
    pname = "distro-grub-themes";
    version = "3.1";
    src = pkgs.fetchFromGitHub {
      owner = "AdisonCavani";
      repo = "distro-grub-themes";
      rev = "v3.1";
      hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
    };
    installPhase = "cp -r customize/nixos $out";
  };

  # kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  # hostname
  networking.hostName = "rooter"; # Define your hostname.

  # enable gaming software
  programs.steam.enable = true;
  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        softrealtime = "auto";
        renice = 10;
      };
    };
  };

  # enable network streaming of audio (export and import)
  hardware.pulseaudio.zeroconf.discovery.enable = true;
  hardware.pulseaudio.zeroconf.publish.enable = true;

  


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
