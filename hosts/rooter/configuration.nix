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
    ];

  environment.systemPackages = with pkgs; [
    acpi
    brightnessctl
    cpupower-gui
    framework-tool
    powertop
  ];

  # NixOS recommends using this on AMD platforms
  services = {
    power-profiles-daemon.enable = true;

    fprintd.enable = true;

    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 5;
      percentageAction = 3;
      criticalPowerAction = "PowerOff";
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 2;
  boot.initrd.enable = true;
  boot.initrd.systemd.enable = true;
  boot.consoleLogLevel = 3;
  boot.plymouth = {
    enable = true;
    font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
    themePackages = [ pkgs.catppuccin-plymouth ];
    theme = "catppuccin-macchiato";
  };
  boot = {
    blacklistedKernelModules = ["k10temp"];
    kernelModules = [ "acpi_call" "cross_ec" "cross_ec_lpcs" "zenpower" ];
    kernelParams = [ "amd_pstate=active" "amdgpu.sd_display=0" ];
    extraModulePackages = with config.boot.kernelPackages;
      [
        acpi_call
        cpupower
        framework-laptop-kmod
        zenpower
      ]
      ++ [pkgs.cpupower-gui];
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

  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
    rocm-opencl-icd
    rocm-opencl-runtime
  ];
  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
