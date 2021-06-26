{ config, pkgs, ... }:

let
  # bnixpkgs = import (pkgs.fetchFromGitHub {
  #   owner = "brhoades";
  #   repo = "nixpkgs";
  #   rev = "brhoades/emacs-28-pgtk";
  #   sha256 = "0s1zf23vvm14f4vvfhc9dgy5dkbgylxg26gflq4l5mpxqh3p7hgz";
  # }) {};
  # nix-linter breaks so frequently. Locking it down to a December version which used a hnix
  # that didn't give me ulcers.
  hnixPkgs = import (pkgs.fetchFromGitHub {
    owner = "brhoades";
    repo = "nixpkgs";
    rev = "frozen/nix-linter";
    sha256 = "1g0siknkxrf7a16fngcf61c9v02rh7p2bslmi80zi6s73qjnmcsw";
  }) { };
in {
  home.file = {
    ".emacs.d/init.el".source =
      config.lib.file.mkOutOfStoreSymlink ../../dotemacs.d/init.el;
    ".emacs.d/config".source =
      config.lib.file.mkOutOfStoreSymlink ../../dotemacs.d/config;
    ".emacs.d/.cache/lsp/rust/rust-analyzer".source =
      "${pkgs.rust-analyzer}/bin/rust-analyzer";
  };

  # XXX: nix-linter still broken >:(
  nixpkgs.config.packageOverrides = _pkgs: {
    hnix = hnixPkgs.haskellPackages.hnix;
    nix-linter = hnixPkgs.nix-linter;
  };

  home.packages = with pkgs;
    [
      # nix-linter
    ];

  # emacs needs .emacs.d/{undo,tmp,tansient,elpa,workspace}
  # It should make all except for undo and workspace itself?
  ## XXX: enable after upgrade to 20.09+
  systemd.user.tmpfiles.rules =
    let emacsdir = (config.home.homeDirectory + "/.emacs.d");
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
    # I've not been using the GUI. Having emacs in tmux is too nice.
    # emacs 28 introduces fuzzy search changes with projectile that are annoying
    # as hell. Additionally, it breaks undo-tree.
    # package = bnixpkgs.emacs28-pgtk;

    # use-package takes care of any extra packages
    # only defined in .el files.
    extraPackages = with pkgs;
      (epkgs:
        with epkgs;
        [
          use-package

          #          tide
          #          web-mode
          #          # rjsx-mode unstable: something broken with C?
          #          typescript-mode
          #          less-css-mode
          #          add-node-modules-path
          #          nodejs # for tide and to run node_modules
          #
          #          js2-mode
          #          vue-mode
          #          elm-mode
          #          purescript-mode
          #
          #          flycheck
          #
          #          lsp-ui
          #          lsp-mode
          #          yasnippet
          #          hydra
          #          company
          #          # company-lsp
          #
          #          # lsp-java unstable broken again
          #          scala-mode
          #
          #          nix-mode
          #
          #          dap-mode
          #
          #          org
          #          org-noter
          #          org-roam
          #          pkgs.sqlite
          #          pkgs.graphviz # org-roam requirement
          #
          #          pdf-tools
          #
          #          notmuch
          #
          #          xclip
          #
          #          python-mode
          #
          #          go-mode
          #          company-go
          #          go-projectile
          #
          #          projectile
          #          helm
          #          helm-rg
          #          helm-smex
          #          helm-projectile
          #          flx-ido
          #
          #          magit
          #          git-link
          #          # evil-magit is gone
          #          evil
          #          evil-smartparens # evil-collection  includes evil-mode too now?
          #          monokai-theme
          #
          #          # undo-fu undo-fu-session
          #          undo-tree
          #
          #          bind-key
          #          diminish
          #          exec-path-from-shell
          #          direnv
          #
          #          json-mode
          #          dockerfile-mode
          #          markdown-mode
          #          yaml-mode
          #          yamllint
          #          # journalctl-mode
          #
          #          racer
          #          flycheck-rust
          #          rustic
          #
          #          rbenv
          #          enh-ruby-mode
          #          projectile-rails
          #          robe
          #
          #          solarized-theme
          #
          #          git-link
          #          github-review
          #
          #          # if go
          #          go # godef gocode gotags gotools golint delve
          #          # errcheck go-tools unconvert
          #
          #          # if nix
          #          # nix-linter
          #
          #          # projectile-{ag,rg}
          #          ag
          #          ripgrep
          #
          #          # magit
          #          git
        ]);
  };
}
