{ pkgs, ... }:

let
  vivaldi-gpu = pkgs.symlinkJoin {
    name = "chromium";
    paths = [ pkgs.vivaldi ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/vivaldi \
        --add-flags "--enable-features=UseOzonePlatform,WebRTCPipeWireCapturer,VaapiVideoDecoder --ozone-platform=wayland --use-gl=egl --ignore-gpu-blocklist --enable-gpu-rasterization --enable-zero-copy"
    '';
  };

  slack-hidpi = pkgs.symlinkJoin {
    name = "slack";
    paths = [ pkgs.slack ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/slack --add-flags "--enable-features=UseOzonePlatform,WebRTCPipeWireCapturer,WaylandWindowDecorations --ozone-platform-hint=wayland --force-device-scale-factor=2.0"
    '';
  };
in
with pkgs; [
  # Fonts
  commit-mono

  # Apps
  _1password-gui
  bcompare
  btop
  firefox-wayland
  helix
  junction
  kitty
  kooha
  mpv
  musikcube
  slack-hidpi
  termscp
  vivaldi-ffmpeg-codecs
  vivaldi-gpu
  vscode
]
