{ config, pkgs, lib, ... }:
with pkgs; with lib; let
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

    cargoSha256 = "0v6ifniay96y3sip5djd8fidd37g46xfkc8xk0qdbfq7w1yr56n2";

    meta = {
      description = "override firefox profiles based on the url of the link";
      homepage = https://github.com/brhoades/ffxdghack;
      license = licenses.mit;
    };
  };
in {
  options.brodes.xdgHack = with pkgs.lib; {
    enable = mkEnableOption "enable xdghack for firefox";

    configFile = mkOption {
      type = types.path;
    };
  };

  config = let
    cfg = config.brodes.xdgHack;
  in lib.mkIf cfg.enable {
    xdg.dataFile."applications/ffirefox.desktop".text = ''
[Desktop Entry]
Categories=Network;WebBrowser;
Comment=
Exec=${ffxdghack}/bin/ffxdghack ${cfg.configFile} %U
GenericName=Web Browser
Icon=firefox
MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp
Name=Firefox (Wayland Custom)
Terminal=false
Type=Application
'';

    xdg = {
      enable = true;
      mimeApps = {
        enable = false;
        associations.added = let
          ff = "ffirefox.desktop"; # this upsets the firefox greatly
        in {
          "text/html" = ff;
          "x-scheme-handler/http" = ff;
          "x-scheme-handler/https" = ff;
          "x-scheme-handler/about" = ff;
          "x-scheme-handler/unknown" = ff;
        };
      };
    };
  };
}
