{ config, pkgs, inputs, ... }:

{
  home.file = {
    ".emacs.d/init.el".source = ../../dotemacs.d/init.el;
    ".emacs.d/config".source = ../../dotemacs.d/config;
    ".emacs.d/.cache/lsp/rust/rust-analyzer".source =
      "${pkgs.inputs.latest.rust-analyzer}/bin/rust-analyzer";
  };

  home.packages = with pkgs; [
    # nix-linter # 2023/06/09: marked broken on on 23.05 
    pkgs.inputs.rnix
    gopls
  ];

  # emacs needs .emacs.d/{undo,tmp,tansient,elpa,workspace}
  # It should make all except for undo and workspace itself?
  systemd.user.tmpfiles.rules = let
    emacsdir = (config.home.homeDirectory + "/.emacs.d");
    in with pkgs.lib; mkIf (strings.hasInfix "linux" pkgs.system) [
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
          #          evil-smartparens # evil-collection  includes evil-mode too now?
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
          #          # if go
          go godef gocode gotags gotools golint delve
          govet
          errcheck go-tools unconvert
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
          haskell-language-server
        ]);
  };
}
