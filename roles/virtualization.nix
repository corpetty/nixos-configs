{ pkgs, ... }:

{
  # Enable Containerd
  # virtualisation.containerd.enable = true;

  # Enable Docker
  # environment.sessionVariables = {
    # DOCKER_HOST="unix:///var/run/docker.sock";
  # };
  
  virtualisation.docker = {
    enable = true;
    # enableNvidia = true;
    # enableOnBoot = true;
    # rootless = {
      # enable = true;
      # setSocketVariable = true;
      # daemon.settings = {
        # default-runtime = "nvidia";
        # runtime.nvidia.path = "$pkgs.nvidia-docker}/bin/nvidia-container-runtime";
      # };
    # };
  };
  users.extraGroups.docker.members = [ "petty" ];

  # Enable Podman
  virtualisation = {
    podman = {
      enable = true;

  #     # Create a `docker` alias for podman, to use it as a drop-in replacement
  #     # dockerCompat = true;

  #     # Required for containers under podman-compose to be able to talk to each other.
  #     defaultNetwork.settings.dns_enabled = true;
    };
  };

    environment.systemPackages = with pkgs; [
    # nerdctl

    # firecracker
    # firectl
    # flintlock

    distrobox
    qemu

    # podman-compose
    # podman-tui

    docker-compose

    lazydocker
    # docker-credential-helpers
  ];
}
