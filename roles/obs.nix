{ pkgs, config, ... }:

{
  # allow video into loopback for OBS
  boot.extraModulePackages = config.boot.kernelPackages; [ v4l2loopback ];

  users.users.petty.package = with pkgs; [
    obs-studio
  ];
}
