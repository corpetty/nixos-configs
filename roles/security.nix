{ pkgs, ... }:

{
  # Drop packets by default.
  networking.firewall = {
    enable = true;
    # 6333,11434,5432,5678 are all for local LLM docker-compose
    extraCommands = ''
      iptables -A INPUT -p tcp --dport 7860 -s 192.168.0.0/24 -j ACCEPT
      iptables -A INPUT -p tcp --dport 7860 -s 127.0.0.0/8 -j ACCEPT
      iptables -A INPUT -p tcp --dport 8188 -s 127.0.0.0/8 -j ACCEPT
      iptables -A INPUT -p tcp --dport 8188 -s 192.168.0.0/24 -j ACCEPT
      iptables -A INPUT -p tcp --dport 6333 -s 127.0.0.0/8 -j ACCEPT
      iptables -A INPUT -p tcp --dport 11434 -s localhost -j ACCEPT
      iptables -A INPUT -p tcp --dport 5432 -s 127.0.0.0/8 -j ACCEPT
      iptables -A INPUT -p tcp --dport 5678 -s 127.0.0.0/8 -j ACCEPT
      iptables -A INPUT -p tcp --dport 8081 -s 127.0.0.0/8 -j ACCEPT
      iptables -A INPUT -p tcp --dport 8090 -s 0.0.0.0/8 -j ACCEPT
      iptables -A INPUT -p tcp --dport 8070 -s 0.0.0.0/8 -j ACCEPT
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
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  # Use PAM with SSH auth.
  security.pam.sshAgentAuth.enable = true;
  
}
