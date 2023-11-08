{ config, pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  imports =
    [
      ./hardware-configuration.nix
    ];


  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
    nixenc = {
      device = "/dev/disk/by-uuid/f89c7c1c-929b-45a2-9836-ff4eb66793cb";
      preLVM = true;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    dconf
    git
    nixpkgs-fmt
    ripgrep
  ];

  services.fwupd = {
    enable = true;
    extraRemotes = [
      "lvfs-testing"
    ];
  };

  services.flatpak.enable = true;

  users.users.jvzr = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = (import ./packages.nix pkgs);
  };

  # programs.fish.enable = true;

  networking = {
    hostName = "fwk";

    wireless.iwd = {
      enable = true;

      settings = {
        General = {
          EnableNetworkingConfiguration = true;
          UseDefaultInterface = true;
          AddressRandomization = "network";
          RoamRetryInterval = 15;
        };
      };
    };

    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;
  services.tailscale.enable = true;

  services.syncthing = {
    enable = true;
    user = "jvzr";
    dataDir = "/home/jvzr/Sync";
    configDir = "/home/jvzr/.config/syncthing";
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };
    
  system.stateVersion = "23.05"; # Did you read the comment?
}
