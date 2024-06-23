{ pkgs, ... }:

{
  # Fonts
  fonts = {
    fontconfig = {
      cache32Bit = true;
      allowBitmaps = true;
      useEmbeddedBitmaps = true;
      defaultFonts = {
        monospace = [ "JetBrains Mono" ];
      };
    };
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      jetbrains-mono
      nerd-font-patcher
      inconsolata
      terminus_font
      corefonts
      fira-code
      dejavu_fonts
      ubuntu_font_family
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };
}
