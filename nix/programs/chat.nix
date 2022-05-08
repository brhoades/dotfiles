{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      weechat = super.weechat.override {
        configure = { availablePlugins, ... }: {
          scripts = with super.weechatScripts; [ wee-slack multiline ];
        };
      };
    })
  ];

  home.packages = let
  in with pkgs; [
    signal-desktop
    discord
    slack
    weechat
    aspellDicts.en
    aspellDicts.es
  ];
}
