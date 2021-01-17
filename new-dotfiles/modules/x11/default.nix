{ pkgs, config, inputs, ... }:
{
  imports = [
    ./base.nix
    ./firefox.nix
    ./polybar.nix
    ./scripts.nix
  ];

  services.xserver = {
    # Display Manager
    displayManager.gdm.enable = true;

    # AwesomeWM
    windowManager.awesome.enable = true;
  };

  # AwesomeWM config
  home.xdg.configFile."awesome".source = ./awesome-config;

  # Hack font
  fonts = {
    fonts = with pkgs; [ hack-font ];
    fontconfig.defaultFonts = {
      monospace = [ "Hack" ];
    };
  };
  home.xresources.properties."*.font" = "Hack:pixelsize=13:antialias=true:autohint=true";

  # Compositor for styling
  services.picom = {
    enable = true;
    backend = "glx";
    experimentalBackends = true;

    fade = true;
    fadeDelta = 5;
    inactiveOpacity = 0.8;
    shadow = true;

    settings = {
      blur = {
        method = "gaussian";
        size = 10;
        deviation = 2.0;
      };
    };
  };

  # Add background image
  environment.pathsToLink = [ "/share/backgrounds" ];
  environment.systemPackages = [
    pkgs.nixos-artwork.wallpapers.dracula
  ];
}
