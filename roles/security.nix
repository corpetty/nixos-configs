{ pkgs, lib, ... }:

{
  security.pam.services.swaylock = {};

  environment.systemPackages = with pkgs; [
    pass-wayland
    passExtensions.pass-otp
    passExtensions.pass-tomb
    passExtensions.pass-update
    passExtensions.pass.import
    tomb
  ];
}
