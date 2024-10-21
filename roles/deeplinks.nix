{ config, pkgs, ... }:

let
  elementDesktopItem = pkgs.makeDesktopItem {
    name = "element-desktop";
    exec = "${pkgs.element-desktop}/bin/element-desktop %u";
    icon = "element";
    desktopName = "Element";
    genericName = "Matrix Client";
    comment = "A feature-rich client for Matrix.org";
    categories = [ "Network" "InstantMessaging" "Chat" ];
    mimeTypes = [ 
      "x-scheme-handler/element"
      "x-scheme-handler/riot"
      "x-scheme-handler/matrix"
    ];
  };
in
{
  
  # Ensure xdg-utils is installed
  environment.systemPackages = with pkgs; [ 
    xdg-utils 
    element-desktop
    elementDesktopItem
  ];

  # Set up URL handling for Element
  system.activationScripts.elementUrlHandler = ''
    # Set Element as the default handler for multiple URL schemes
    ${pkgs.xdg-utils}/bin/xdg-mime default element-desktop.desktop x-scheme-handler/element
    ${pkgs.xdg-utils}/bin/xdg-mime default element-desktop.desktop x-scheme-handler/riot
    ${pkgs.xdg-utils}/bin/xdg-mime default element-desktop.desktop x-scheme-handler/matrix
    
    # Use xdg-settings to reinforce the association
    ${pkgs.xdg-utils}/bin/xdg-settings set default-url-scheme-handler element element-desktop.desktop
    ${pkgs.xdg-utils}/bin/xdg-settings set default-url-scheme-handler riot element-desktop.desktop
    ${pkgs.xdg-utils}/bin/xdg-settings set default-url-scheme-handler matrix element-desktop.desktop
    
    # Update desktop database
    ${pkgs.desktop-file-utils}/bin/update-desktop-database ~/.local/share/applications
    ${pkgs.desktop-file-utils}/bin/update-desktop-database /usr/local/share/applications
    ${pkgs.desktop-file-utils}/bin/update-desktop-database /usr/share/applications
  '';

  # Optional: Add a script to manually trigger URL handling setup
  # environment.systemPackages = with pkgs; [
    # (writeScriptBin "setup-element-url-handler" ''
     # !${stdenv.shell}
      # ${config.system.activationScripts.elementUrlHandler.text}
      # echo "Element URL handler setup completed."
    # '')
  # ];
}
