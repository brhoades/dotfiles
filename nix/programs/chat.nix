{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      weechat = super.weechat.override {
        configure = { availablePlugins, ... }: {
          scripts = with super.weechatScripts; [ wee-slack multiline ];
        };
      };

      # wrappers below force ozone with applications' electron
      slack = super.slack.overrideAttrs (old:
        with pkgs; {
          installPhase = old.installPhase + ''
            rm $out/bin/slack

            makeWrapper $out/lib/slack/slack $out/bin/slack \
              --prefix XDG_DATA_DIRS : $GSETTINGS_SCHEMAS_PATH \
              --prefix PATH : ${lib.makeBinPath [ pkgs.xdg-utils ]} \
              --add-flags "--ozone-platform=wayland --enable-features=UseOzonePlatform,WebRTCPipeWireCapturer"
          '';
        });

      # signal-desktop = super.signal-desktop.overrideAttrs (old:
      #   with pkgs; {
      #     installPhase = old.installPhase + ''
      #       rm $out/bin/signal-desktop
      # 
      #            makeWrapper $out/lib/Signal/signal-desktop $out/bin/signal-desktop \
      #             --prefix XDG_DATA_DIRS : $GSETTINGS_SCHEMAS_PATH \
      #            --prefix PATH : ${lib.makeBinPath [ pkgs.xdg-utils ]} \
      #           --add-flags "--ozone-platform=wayland --enable-features=UseOzonePlatform,WebRTCPipeWireCapturer"
      #      '';
      #   });
    })
  ];

  home.packages = let
  in with pkgs; [
    signal-desktop
    discord
    slack
    # weechat
    aspellDicts.en
    aspellDicts.es
  ];
}
