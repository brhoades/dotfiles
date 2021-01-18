{ config, pkgs, ... }:

let
  bnixpkgs = import (pkgs.fetchFromGitHub {
    owner = "brhoades";
    repo = "nixpkgs";
    rev = "brhoades/emacs-28-pgtk";
    sha256 = "0s1zf23vvm14f4vvfhc9dgy5dkbgylxg26gflq4l5mpxqh3p7hgz";
  }) {};
  # nix-linter breaks so frequently. Locking it down to a December version which used a hnix
  # that didn't give me ulcers.
  hnixPkgs = import (pkgs.fetchFromGitHub {
    owner = "brhoades";
    repo = "nixpkgs";
    rev = "frozen/nix-linter";
    sha256 = "1g0siknkxrf7a16fngcf61c9v02rh7p2bslmi80zi6s73qjnmcsw";
  }) {};
in {
  home.file = {
    ".emacs.d/init.el".source = ../../dotemacs.d/init.el;
    ".emacs.d/config".source = ../../dotemacs.d/config;
    ".emacs.d/.cache/lsp/rust/rust-analyzer".source = "${pkgs.rust-analyzer}/bin/rust-analyzer";
  };

  # XXX: nix-linter still broken >:(
  nixpkgs.config.packageOverrides = _pkgs: {
    hnix = hnixPkgs.haskellPackages.hnix;
    nix-linter = hnixPkgs.nix-linter;
  };

  home.packages = with pkgs; [
    # nix-linter
  ];

  # emacs needs .emacs.d/{undo,tmp,tansient,elpa,workspace}
  # It should make all except for undo and workspace itself?
  ## XXX: enable after upgrade to 20.09+
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

  programs.emacs = {
    enable = true;
    package = bnixpkgs.emacs28-pgtk;

    # use-package takes care of any extra packages
    # only defined in .el files.
    extraPackages = with pkgs; (epkgs: with epkgs; [
      use-package

      tide web-mode rjsx-mode
      typescript-mode
      less-css-mode
      add-node-modules-path
      nodejs  # for tide and to run node_modules

      js2-mode vue-mode elm-mode purescript-mode

      flycheck

      lsp-ui lsp-mode yasnippet hydra
      company company-lsp

      lsp-java scala-mode

      nix-mode

      dap-mode

      org org-noter org-roam
      pkgs.sqlite # org-roam requirement

      pdf-tools

      notmuch

      xclip

      python-mode

      go-mode company-go go-projectile

      projectile
      helm helm-rg helm-smex helm-projectile
      flx-ido

      magit git-link
      evil evil-magit evil-smartparens # evil-collection  includes evil-mode too now?
      monokai-theme

      undo-fu undo-fu-session

      bind-key diminish
      exec-path-from-shell
      direnv

      json-mode dockerfile-mode markdown-mode yaml-mode
      # journalctl-mode

      racer flycheck-rust rustic

      rbenv enh-ruby-mode projectile-rails robe

      solarized-theme

      # if go
      go # godef gocode gotags gotools golint delve
      # errcheck go-tools unconvert

      # if nix
      # nix-linter

      # projectile-{ag,rg}
      ag ripgrep

      # magit
      git
    ]);
  };
}
