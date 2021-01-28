{ config, pkgs, ... }:

{
  home.file = {
    ".emacs.d/init.el".source = ../../dotemacs.d/init.el;
    ".emacs.d/config".source = ../../dotemacs.d/config;
  };

  home.packages = with pkgs; [
      nix-linter
  ];

  # emacs needs .emacs.d/{undo,tmp,tansient,elpa,workspace}
  # It should make all except for undo and workspace itself?
  ## XXX: enable after upgrade to 20.09+
  # systemd.user.tmpfiles.rules = let
  #   emacsdir = (config.home.homeDirectory + "/.emacs.d");
  # in [
  #   "d ${emacsdir + "/undo"} - - - - -"
  #   "d ${emacsdir + "/tmp"} - - - - -"
  #   "d ${emacsdir + "/workspace"} - - - - -"
  #   "d ${emacsdir + "/elpa"} - - - - -"
  #   "d ${emacsdir + "/auto-save-list"} - - - - -"
  #   "d ${emacsdir + "/straight"} - - - - -"
  #   "d ${emacsdir + "/transient"} - - - - -"
  # ];

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
      nodejs  # for tide and to run node_modules

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
      # journalctl-mode

      racer flycheck-rust rustic

      rbenv enh-ruby-mode projectile-rails robe

      solarized-theme

      git-link github-review

      # if go
      go # godef gocode gotags gotools golint delve
      # errcheck go-tools unconvert

      # if nix
      nix-linter

      # projectile-{ag,rg}
      ag ripgrep

      # magit
      git
    ]);
  };
}
