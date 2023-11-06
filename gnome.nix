{ pkgs, ... }: {
  services = {
    xserver = {
      enable = true;

      displayManager.gdm.enable = true;

      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverrides = ''
          [org.gnome.mutter]
          experimental-features=['scale-monitor-framebuffer']
        '';
        # extraGSettingsOverridePackages = [ pkgs.gnome.muttter ];
      };

      excludePackages = [ pkgs.xterm ];
    };

    gnome = {
      gnome-browser-connector.enable = false;
      gnome-initial-setup.enable = false;
      gnome-online-accounts.enable = false;
    };

    udev.packages = [ pkgs.gnome.gnome-settings-daemon ];
  };

  systemd.services."display-manager".after = [ "network-online.target" "systemd-resolved.service" ];

  programs.dconf.enable = true;

  environment = {
    systemPackages = with pkgs; [
      gnome.gnome-tweaks
      gnome.gnome-settings-daemon
      gnomeExtensions.appindicator
      gnomeExtensions.auto-activities
      # gnomeExtensions.battery-time
      gnomeExtensions.battery-time-2
      gnomeExtensions.just-perfection
      gnomeExtensions.night-theme-switcher
      gnomeExtensions.paperwm
      gnomeExtensions.tailscale-qs
      vimix-icon-theme
    ];

    gnome.excludePackages = with pkgs; [
      # gnome.evince # document viewer
      gnome-photos
      gnome-tour
      gnome.atomix # puzzle game
      gnome.cheese # webcam tool
      gnome.epiphany # web browser
      gnome.file-roller # archive manager
      gnome.geary # email reader
      gnome.gedit # text editor
      gnome.gnome-calendar
      gnome.gnome-characters
      gnome.gnome-characters
      gnome.gnome-clocks
      gnome.gnome-contacts
      gnome.gnome-font-viewer
      gnome.gnome-maps
      gnome.gnome-music
      gnome.hitori # sudoku game
      gnome.iagno # go game
      gnome.seahorse # password manager
      gnome.simple-scan # document scanner
      gnome.tali # poker game
      gnome.totem # video player
      gnome.gnome-weather
      gnome.yelp
      orca
    ];
  };
}
