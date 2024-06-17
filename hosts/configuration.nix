# non-host-specific system configuration
{ config, pkgs, lib, ... }:

{
  imports = [
    # a custom service to hibernate after sleeping for a set period
    # disabled because of issues actually getting the hibernation to happen
    # ../custom/suspend-then-hibernate.nix
    ../roles/bootloader.nix
    ../roles/users.nix
    ../roles/security.nix
    ../roles/terminal-utils.nix
    ../roles/gaming.nix
    ../roles/nix-settings.nix
    ../roles/fonts.nix
  ];

  # create groups
  users.groups = {
    i2c = { };
  };

  #
  # Core System Components
  #

  # Enable networking
  networking.networkmanager = {
    enable = true;
  };

  # enable dhcp
  networking.useDHCP = lib.mkDefault true;

  # enable wireguard for vpn, and allow it through the firewall
  networking.wireguard.enable = true;
  networking.firewall.checkReversePath = "loose";

  # enable non-priviledged mounting of disks through udisks
  services.udisks2.enable = true;

  # make via work with udev for qmk keyboards
  services.udev.packages = with pkgs; [
    via
    vial
  ];

  # enable polkit for privilege escalation
  security.polkit.enable = true;

  # Enable sound

  # allow realtime permissions for pipewire
  security.rtkit.enable = true; 

  # configure pipewire for a balance of low latency and no artifacts
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    extraConfig.pipewire."92-low-latency" = {
      context.properties = {
        default.clock.rate = 48000;
        default.clock.quantum = 32;
        default.clock.min-quantum = 32;
        default.clock.max-quantum = 32;
      };
    };
    extraConfig.pipewire-pulse."92-low-latency" = {
      context.modules = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
            pulse.min.req = "32/48000";
            pulse.default.req = "32/48000";
            pulse.max.req = "32/48000";
            pulse.min.quantum = "32/48000";
            pulse.max.quantum = "32/48000";
          };
        }
      ];
      stream.properties = {
        node.latency = "32/48000";
        resample.quality = 1;
      };
    };
  };
  # Add in Noisetorch for background noise control
  programs.noisetorch.enable = true;

  # enable virtualization via virtd and qemu
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # enable ssh key management agent
  programs.ssh = {
    startAgent = true;
    agentTimeout = "2h";
    extraConfig = ''
      AddKeysToAgent yes
    '';

  };

  # enable firmware and uefi updates
  services.fwupd.enable = true;

  # fix issue with ssh-add not knowing where the ssh-agent socket is
  environment.variables = {
    SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent";
  };

<<<<<<< HEAD

  # enable portals for screensharing etc
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-gtk 
    ];

    config = {
      common.default = [ "wlr" "gtk" ];
    };
  };

=======
>>>>>>> 23941928b837f7c24ad8ba5851eb6d718fc9394d
  #
  # localization and language
  #

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  #
  # system packages
  #

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    libvirt-glib
    fzf
    polkit
    kdePackages.polkit-kde-agent-1
  ];

  fonts.packages = with pkgs; [
    dejavu_fonts
    noto-fonts
    nerdfonts
  ];

  # software that I prefer to install at a system level rather than in home-manager
  programs.dconf.enable = true;

  # programs.corectrl = {
  #   enable = true;
  #   gpuOverclock = {
  #     enable = true;
  #     ppfeaturemask = "0xffffffff";
  #   };
  # };
  
  programs.fish.enable = true;

  # Allow running of appimages
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };
  
}
