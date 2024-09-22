{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "amdgpu" "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [ "amdgpu.abmlevel=1" ];

    fileSystems."/" =
    { device = "/dev/disk/by-uuid/10b052d3-1883-4050-892a-55e0c58331f9";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/D6D8-EB5C";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/8567aed7-a9e8-406b-98e2-9cb8f38037cd"; }
    ];

  # enable fingerprint reader
  services.fprintd.enable = true;

  # enable Power Profiles Daemon for improved battery life
  services.power-profiles-daemon.enable = true;

  # platform and cpu options
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # enable non-root access to keyboard firmware
  hardware.keyboard.qmk.enable = true;

  # enable bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  # configure lid and power button behavior
  services.logind = {
    powerKey = "hibernate";
    powerKeyLongPress = "poweroff";
    lidSwitch = "suspend";
    lidSwitchExternalPower = "suspend";
  };

  # have to let the system use my gpu even though it isn't technically
  # reproduceable due to gpu driver shennanigans
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
      mangohud
      gamescope
      amdvlk
    ];
    extraPackages32 = with pkgs; [
      mangohud
      gamescope
    ];
  };
  hardware.steam-hardware.enable = true;
}
