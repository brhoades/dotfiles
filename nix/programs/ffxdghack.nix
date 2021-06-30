{ config, pkgs, lib, ... }:
with pkgs;
with lib;
let
  ffxdghack = rustPlatform.buildRustPackage rec {
    pname = "ffxdghack";
    version = "0.1.0";
    name = "${pname}-${version}";

    nativeBuildInputs = [ libudev pkgconfig ];
    buildInputs = nativeBuildInputs;

    src = fetchFromGitHub {
      owner = "brhoades";
      repo = pname;
      rev = version;
      sha256 = "1qn6nzlx5w4kf1122sgy0y193z3cn0d460hi8p96iqpgmf6irrfx";
    };

    cargoSha256 = "1a8nk2dydycpnplqh33wk7rlhz8xnqa0nnylgn5z0fpzpc6c9x93";

    meta = {
      description = "override firefox profiles based on the url of the link";
      homepage = "https://github.com/brhoades/ffxdghack";
      license = licenses.mit;
    };
  };
in {
  options.brodes.xdgHack = with pkgs.lib; {
    enable = mkEnableOption "enable xdghack for firefox";

    configFile = mkOption { type = types.path; };
  };

  config = let
    cfg = config.brodes.xdgHack;
    # https://www.guyrutenberg.com/2020/03/21/xdg-open-fails-when-using-firefox-under-wayland/
    wrapper = writeShellScriptBin "wrapper" ''
      export MOZ_DBUS_REMOTE=1
      export MOZ_ENABLE_WAYLAND=1
      exec ${ffxdghack}/bin/ffxdghack "$@"
    '';
  in lib.mkIf cfg.enable {
    xdg.dataFile."applications/ffirefox.desktop".text = ''
      [Desktop Entry]
      Categories=Network;WebBrowser;
      Comment=
      Exec=${wrapper}/bin/wrapper ${cfg.configFile} %U
      GenericName=Web Browser
      Icon=firefox
      MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp
      Name=Firefox (Wayland Custom)
      Terminal=false
      Type=Application
    '';

    xdg = {
      enable = true;
      mimeApps = let
        ff = "ffirefox.desktop";
        assocs = inp: {
          "text/html" = inp;
          "x-scheme-handler/http" = inp;
          "x-scheme-handler/https" = inp;
          "x-scheme-handler/about" = inp;
          "x-scheme-handler/unknown" = inp;
        };
      in {
        enable = true;
        associations.added = assocs ff;
        defaultApplications = assocs [ ff ];
      };
    };
  };
}
