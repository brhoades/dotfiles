{ pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs:
    {
      # XXX: discord update breaks everything.
      # discord = import ../../../nixpkgs/pkgs/applications/networking/instant-messengers/discord { inherit pkgs; };
      discord = (import <nixos-unstable-small> {}).discord;
    };

    nixpkgs.overlays = [ 
      (self: super: {
        weechat = super.weechat.override {
          configure = { availablePlugins, ... }: {
            scripts = with super.weechatScripts; [
              wee-slack
              multiline
            ];
          };
        };
      })
    ];

    home.packages = let
    in with pkgs; [
      signal-desktop
      discord
      slack
      weechat aspellDicts.en aspellDicts.es
    ];
}
