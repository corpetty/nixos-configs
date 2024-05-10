{ pkgs, config, ... }:

{
  # allow video into loopback for OBS
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

  users.users.petty.packages = with pkgs; [
    obs-studio
  ];
}
