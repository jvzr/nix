{
  description = "flake for yourHostNameGoesHere";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.niri-src.url = "github:YaLTeR/niri";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, niri }: {
    nixosConfigurations = {
      fwk = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./gnome.nix
          ./packages.nix
          nixos-hardware.nixosModules.framework-13-7040-amd
          niri.nixosModules.niri
          ./niri.nix
        ];
      };
    };
  };
}
