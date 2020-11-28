{ config, pkgs, ... }:

{
  home.file = {
    ".emacs.d/init.el".source = ../../dotemacs.d/init.el;
    ".emacs.d/config".source = ../../dotemacs.d/config;
  };

  # emacs needs .emacs.d/{undo,tmp,tansient,elpa,workspace}
  # It should make all except for undo and workspace itself?
  systemd.user.tmpfiles.rules = let
    emacsdir = (config.home.homeDirectory + "/.emacs.d");
  in [
    "d ${emacsdir + "/undo"} - - - - -"
    "d ${emacsdir + "/tmp"} - - - - -"
    "d ${emacsdir + "/workspace"} - - - - -"
    "d ${emacsdir + "/elpa"} - - - - -"
    "d ${emacsdir + "/auto-save-list"} - - - - -"
    "d ${emacsdir + "/straight"} - - - - -"
    "d ${emacsdir + "/transient"} - - - - -"
  ];

  # fonts.fontconfig.enable = true;

  programs.emacs = {
    enable = true;

    # use-package takes care of any extra packages
    # only defined in .el files.
    extraPackages = with pkgs; with pkgs.emacsPackages; (_epkgs: [
      use-package

      tide web-mode rjsx-mode
      typescript-mode
      less-css-mode
      add-node-modules-path

      js2-mode vue-mode elm-mode purescript-mode

      flycheck

      lsp-ui lsp-mode yasnippet hydra
      company company-lsp

      lsp-java scala-mode

      nix-mode

      dap-mode

      org org-noter
      pdf-tools

      notmuch

      xclip

      python-mode

      go-mode company-go go-projectile

      projectile
      helm helm-rg helm-smex helm-projectile
      flx-ido

      magit
      evil evil-collection evil-magit evil-smartparens
      monokai-theme

      bind-key diminish
      exec-path-from-shell
      direnv

      json-mode dockerfile-mode markdown-mode yaml-mode
      journalctl-mode

      racer flycheck-rust rustic

      rbenv enh-ruby-mode projectile-rails robe

      solarized-theme

      # if go
      go # godef gocode gotags gotools golint delve
      # errcheck go-tools unconvert

      # if nix
      # This is erroring on unstable due to ghc compilation issues.
      nix-linter

      # projectile-{ag,rg}
      ag ripgrep

      # magit
      git
    ]);
  };

  nixpkgs.config.packageOverrides = pkgs: {
    # XXX: bugged in unstable
    nix-linter = (import <nixos-20.03> { }).nix-linter;

    # emacs = with pkgs; pkgs.emacs.overrideAttrs (oldAttrs: rec {
      # configureFlags = oldAttrs.configureFlags;
    # });
  };
}
