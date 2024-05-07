{ ... }:

{
  # Drop packets by default.
  networking.firewall = {
    enable = true;
    extraCommands = ''
      iptables -A INPUT -p tcp --dport 7860 -s 192.168.0.0/24 -j ACCEPT
      iptables -A INPUT -p tcp --dport 7860 -s 127.0.0.0/8 -j ACCEPT
      iptables -A INPUT -p tcp --dport 8188 -s 127.0.0.0/8 -j ACCEPT
      iptables -A INPUT -p tcp --dport 8188 -s 192.168.0.0/24 -j ACCEPT
      iptables -P INPUT DROP
      iptables -P FORWARD DROP
    '';
    allowedTCPPorts = [ 7860 8188 22 ];
  };

  # Increase SSH security.
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  # Enable GnuPG agent for keys.
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    enableBrowserSocket = true;
    pinentryFlavor = "gnome3";
  };

  # Use PAM with SSH auth.
  security.pam.enableSSHAgentAuth = true;
}
