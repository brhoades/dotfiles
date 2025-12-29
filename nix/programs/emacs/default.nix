{ config, pkgs, inputs, ... }:

{
  home.file = {
    ".emacs.d/init.el".source = ../../../dotemacs.d/init.el;
    ".emacs.d/config".source = ../../../dotemacs.d/config;
  };

  home.packages = with pkgs; [
    # nix-linter # 2023/06/09: marked broken on on 23.05
    pkgs.inputs.rnix
    gopls
  ];

  # emacs needs .emacs.d/{undo,tmp,tansient,elpa,workspace}
  # It should make all except for undo and workspace itself?
  systemd.user.tmpfiles.rules =
    let emacsdir = (config.home.homeDirectory + "/.emacs.d");
    in with pkgs.lib;
    mkIf (strings.hasInfix "linux" pkgs.stdenv.hostPlatform.system) [
      "d ${emacsdir + "/undo"} - - - - -"
      "d ${emacsdir + "/tmp"} - - - - -"
      "d ${emacsdir + "/workspace"} - - - - -"
      "d ${emacsdir + "/elpa"} - - - - -"
      "d ${emacsdir + "/auto-save-list"} - - - - -"
      "d ${emacsdir + "/straight"} - - - - -"
      "d ${emacsdir + "/transient"} - - - - -"
    ];

  programs.emacs = let isLinux = with pkgs; lib.strings.hasInfix "linux" system;
  in {
    enable = true;
    package = if isLinux then pkgs.emacs else pkgs.inputs.latest.emacs-macport;

    # use-package takes care of any extra packages
    # only defined in .el files.
    extraPackages = with pkgs;
      (epkgs:
        with epkgs; [
          ispell
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
          nix-mode
          #
          #          dap-mode
          #
          org
          org-noter
          org-roam
          pkgs.metals
          pkgs.sqlite # required to start
          pkgs.graphviz # org-roam requirement
          #
          pdf-tools
          #
          #          notmuch
          #
          xclip
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
          #          evil-collection  includes evil-mode too now?
          #          monokai-theme
          #
          #          # undo-fu undo-fu-session
          #          undo-tree
          #
          bind-key
          #          diminish
          #          exec-path-from-shell
          direnv
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
          #          # if nix
          # nix-linter
          #
          #          # projectile-{ag,rg}
          ag
          ripgrep
          #
          #          # magit
          git

          cppcheck # cpp-mode
          clang # cpp-mode
          # haskell-language-server

          pkgs.pyright # lsp-pyright
        ]);
  };
}
