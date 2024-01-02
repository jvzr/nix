{
  description = "flake for yourHostNameGoesHere";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware }: {
    nixosConfigurations = {
      fwk = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./gnome.nix
          # ./packages.nix
          nixos-hardware.nixosModules.framework-13-7040-amd
        ];
      };
    };
  };
}
