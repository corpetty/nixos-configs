{ pkgs, ... }:

{

  # Give extra permissions with Nix
  nix.settings.trust-users = [ "petty" ];

  users.groups.petty = {
    gid = 1000;
    name = "petty";
  };
  
  # Define a user account. Don't forget to set a password with `passwd`.
  users.users.petty = {
    uid = 1000;
    createHome = true;
    isNormalUser = true;
    description = "petty";
    extraGroups = [ 
      "networkmanager" "input" "wheel" "video" "audio" "tss" 
      "dialout" "disk" "adm" "tty" "systemd-journal" "docker"
    ];
    shell = pkgs.fish;
    packages = with pkgs; [
      spotify
      discord
      brave
      obsidian
    ];
  };

  # allow of sudo without password
  security.sudo.wheelNeedsPassword = false;
  

  # Change runtime directory size
  services.logind.extraConfig = "RuntimeDirectorySize=8G";
}
