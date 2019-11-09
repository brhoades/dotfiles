(setq flycheck-rust-cargo-executable "~/.cargo/bin/cargo")
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
