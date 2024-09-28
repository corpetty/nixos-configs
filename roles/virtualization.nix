{ pkgs, ... }:

{
  # Enable Containerd
  # virtualisation.containerd.enable = true;

  # Enable Docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    enableNvidia = true;
    rootless = {
      enable = true;
    };
  };
  users.extraGroups.docker.members = [ "xnm" ];

  # Enable Podman
  # virtualisation = {
    # podman = {
      # enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      # dockerCompat = true;
      # enableNvidia = true;

      # Required for containers under podman-compose to be able to talk to each other.
      # defaultNetwork.settings.dns_enabled = true;
    # };
  # };

  # Enable Nvidia containers
  hardware.nvidia-container-toolkit.enable = true;

  environment.systemPackages = with pkgs; [
    # nerdctl

    # firecracker
    # firectl
    # flintlock

    distrobox
    qemu

    podman-compose
    podman-tui

    docker-compose

    # lazydocker
    # docker-credential-helpers
  ];
}
