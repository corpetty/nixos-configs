{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.grub.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };

  # Resume
  systemd.sleep.extraConfig = "HibernateMode=reboot";

  # Sensors
  boot.kernelModules = [ "nct6775" "coretemp" "i2c-1" ];
  boot.kernelPackages = pkgs.linuxPackages_6_1;

  networking = {
    hostName = "bean";
    domain = "enderverse";
    # useDHCP = true;
    networkmanager.enable = true;
  };


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";
  # Avoid difference when dual-booting Windows.
  time.hardwareClockInLocalTime = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  

  # Video
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.production;
    nvidiaSettings = true;
    modesetting.enable = true;
    forceFullCompositionPipeline = true;

  #  prime = {
  #    sync.enable = true;

  #    intelBusId = "PCI:0:2:0";
  #    nvidiaBusId = "PCI:0:1:1";
  #  };
  };

  # Power Management
  powerManagement.cpuFreqGovernor = "performance";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "20.09";

  systemd.coredump.enable = true;

  nixpkgs.config.permittedInsecurePackages = [
    "electron-24.8.6"
    "electron-25.9.0"
  ];

  # allow video into loopback for OBS
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

  # enable virtualization
  virtualisation.libvirtd.enable = true;
}
