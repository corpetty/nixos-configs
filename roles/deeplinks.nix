{ config, pkgs, ... }:

{
  # Ensure xdg-utils is installed
  environment.systemPackages = [ pkgs.xdg-utils ];

  # Create desktop  enetry for applications
  environment.ect."xdg/applications/element.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Element
    Exec=/etc/profiles/per-user/petty/bin/element-desktop %f
    MimeType=x-scheme=handler/element;application/x-element;
  '';

  # Register the MIME types
  environment.etc."xdg/mime/packages/element-mime-types.xml".text = ''
    <?xml version="1.0"?>
    <mime-info xmlns='http://www.freedesktop.org/standards/shared-mime-info'>
      <mime-type type="x-scheme-handler/element">
        <comment>Element Desktop App</comment>
      </mime-type>
      <mime-type type="application/x-element">
        <comment>Element File</comment>
        <glob pattern="*.element"/>
      </mime-type>
    </mime-info>
  '';

  # Update MIME and desktop databases
  system.activationScripts.mime = ''
    ${pkgs.xdg-utils}/bin/xdg-mime default element.desktop x-scheme-handler/element
    ${pkgs.xdg-utils}/bin/xdg-mime default element.desktop application/x-element
    ${pkgs.xdg-utils}/bin/update-desktop-database
    ${pkgs.xdg-utils}/bin/update-mime-database /usr/share/mime
  '';
};
