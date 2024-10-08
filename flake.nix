{
  description = "NixOS configuration for my personal hosts.";

  inputs = {
    # nixpkgs.url = "nixpkgs/nixos-23.05";
    # nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    unstable.url = "nixpkgs/nixos-unstable";
    hardware.url = "github:NixOS/nixos-hardware/master";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    # hyprland = {
      # url = "github:hyprwm/hyprland?submodules=1";
      # inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, unstable, hardware, hyprpanel }:
    let
      overlay = final: prev: {
        unstable = import unstable { inherit (prev) system; config.allowUnfree = true; };
      };
      # Overlays-module makes "pkgs.unstable" available in configuration.nix
      overlayModule = ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay hyprpanel.overlay ]; });
      # To generate host configurations for all hosts.
      hostnames = builtins.attrNames (builtins.readDir ./hosts);
      # Some hosts are ARM64
      systemForHost = hostname:
        if builtins.elem hostname ["host1" "host2"] then "aarch64-linux"
        else "x86_64-linux";
    in {
      nixosConfigurations = builtins.listToAttrs (builtins.map (host: {
        name = host;
        value = nixpkgs.lib.nixosSystem {
          system = systemForHost host;
          specialArgs = {
            # inherit hyprland;
            channels = { inherit nixpkgs unstable hardware; }; 
          };
          modules = [ overlayModule ./hosts/${host}/configuration.nix ];
        };
      }) hostnames);
    };
}
