{ config, lib, pkgs, ... }: {
  imports = [ ./ffxdghack.nix ];

  # Home Manager setup
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
  };

  programs.firefox = let
    overlayedPkgs = import <nixpkgs> { overlays = [(import ../overlays/firefox-overlay.nix)]; };
  in {
    enable = true;

    package = overlayedPkgs.latest.firefox-nightly-bin;

    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      tridactyl # XXX: use latest beta
      reddit-enhancement-suite
      darkreader
    ];

    profiles = let
      darkChrome = ''
        browser { background-color: #333 !important; }
      '';
      settings = {
        # https://www.reddit.com/r/firefox/comments/7ei43x/any_way_to_make_the_smooth_scrolling_act_the_same/dq5afi0/
        # Smooth scroll enhancements
        "general.smoothScroll.lines.durationMaxMS" = 125;
        "general.smoothScroll.lines.durationMinMS" = 125;
        "general.smoothScroll.mouseWheel.durationMaxMS" = 200;
        "general.smoothScroll.mouseWheel.durationMinMS" = 100;
        "general.smoothScroll.other.durationMaxMS" = 125;
        "general.smoothScroll.other.durationMinMS" = 125;
        "general.smoothScroll.pages.durationMaxMS" = 125;
        "general.smoothScroll.pages.durationMinMS" = 125;
        "mousewheel.system_scroll_override_on_root_content.horizontal.factor" =
          175;
        "mousewheel.system_scroll_override_on_root_content.vertical.factor" =
          175;
        "toolkit.scrollbox.horizontalScrollDistance" = 6;
        "toolkit.scrollbox.verticalScrollDistance" = 2;

        # Disable about:config warnings.
        "browser.aboutConfig.showWarning" = false;

        # Disable autoplay.
        "media.autoplay.default" = 5; # all
        "media.autoplay.allow-extension-background-pages" = false;
        "media.autoplay.block-event.enabled" = true;
        "media.autoplay.enabled.user-gestures-needed" = false;
        "media.autoplay.blocking_policy" = 2;

        # Location and notification requests.
        "geo.enabled" = false;
        "dom.webnotifications.enabled" = false;

        # No search suggestions in address bar.
        "browser.search.suggest.enabled" = false;

        # Dark mode everything.
        "browser.in-content.dark-mode" = true;
        "devtools.theme" = "dark";
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
      };
    in {
      personal = {
        inherit settings;
        isDefault = true;
        id = 0;
        userChrome = darkChrome;
      };

      work = {
        inherit settings;
        id = 1;
        userChrome = darkChrome;
      };
    };
  };

  home.file.".tridactylrc".text = with lib;
    let
      blacklistSites = [
        "mail.google.com"
        "md.hecke.rs"
        "app.datadoghq.com"
        "photos.google.com"
      ];
    in ''
      " Apparently a bit janky, but I like it.
      set smoothscroll true

      " Sites blacklisted against tridactyl due to poor compatiblity.
      ${concatMapStringsSep "\n" (url: "autocmd DocLoad ${url} mode ignore")
      blacklistSites}
    '';
}
