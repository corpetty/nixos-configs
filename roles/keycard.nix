{ pkgs, ...}:

{
  services.pcscd.enable = true;
  environment.systemPackages = with pkgs; [
    ccid opensc pcsctools
  ];
}
