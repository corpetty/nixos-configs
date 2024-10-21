{ pkgs, config, libs, ... }:

{
  # OpenGL
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
    
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Chrome/Firefox)
      vaapiVdpau
      libvdpau-va-gl
      mesa
      nvidia-vaapi-driver
      nv-codec-headers-12
    ];
  };

  ## Nvidia
  boot.extraModulePackages = [ pkgs.linuxKernel.packages.linux_zen.nvidia_x11_vulkan_beta ];
  hardware.nvidia = {
    package = pkgs.linuxKernel.packages.linux_zen.nvidia_x11_vulkan_beta;

    ## Modesetting is required
    modesetting.enable = true;

    # Enable Nvidia settings menu,
    # accessible via `nvidia-settings`
    nvidiaSettings = true;

    # may help with some screen tearing, turning off for base testing
    # forceFullCompositionPipeline = true;
    
    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = false;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
  
  # From a post about getting vulkan to work, off for now
  # environment.systemPackages = with pkgs; [
  #   nvidia-docker
  #   # Vulkan
  #   gfxreconstruct
  #   glslang
  #   spirv-cross
  #   spirv-headers
  #   spirv-tools
  #   vulkan-extension-layer
  #   vulkan-headers
  #   vulkan-loader
  #   vulkan-tools
  #   vulkan-tools-lunarg
  #   vulkan-utility-libraries
  #   vulkan-validation-layers
  #   vkdisplayinfo
  #   vkd3d
  #   vkd3d-proton
  #   vk-bootstrap
  # ];

  # I'm not sure why this is here
  services.dbus.enable = true;

  # for Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # Enable prime for graphics offloading
  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    # sync.enable = true;
    
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:0:1:0";
  };

  
}
