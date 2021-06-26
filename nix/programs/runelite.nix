{ pkgs, ... }: {
  # Home Manager setup
  home.sessionVariables = {
    # java apps in TWM don't reize right without this
    _JAVA_AWT_WM_NONREPARENTING = 1;
  };

  home.packages = with pkgs; [ runelite ];

  nixpkgs.config.packageOverrides = _pkgs:
    {
      # runelite = (import /home/aaron/lib/nixpkgs { }).runelite;
    };
}
