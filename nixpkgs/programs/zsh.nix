{ pkgs, ... }:

let
  p10k = pkgs.zsh-powerlevel10k;
  p10kPath = "${p10k}/share/zsh-powerlevel10k";
  unstablePkgs = import <nixpkgs> {};
  prezto = unstablePkgs.zsh-prezto;
  enhancd = pkgs.fetchFromGitHub {
    owner = "b4b4r07";
    repo = "enhancd";
    rev = "v2.2.4";
    sha256 = "1smskx9vkx78yhwspjq2c5r5swh9fc5xxa40ib4753f00wk4dwpp";
  };
in {
  home = {
    packages = [
      prezto unstablePkgs.fzy
      # 20.03 p10k isn't playing nice with 20.03 zsh
      unstablePkgs.zsh-powerlevel10k
    ];

    # p10k prompts the config wizard unless its output
    # exists.
    file = {
      ".p10k.zsh".source = ../../zshconfigs/dotp10k.zsh;
      ".preztorc".source = ../../zshconfigs/dotpreztorc;
      ".zlogout".source = prezto + "runcoms/zlogout";
      ".zlogin".source = prezto + "runcoms/zlogin";
      ".zprofile".source = prezto + "runcoms/zprofile";
      ".zshenv".source = prezto + "runcoms/zshenv";
    };
  };

  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;

    history = {
      size = 1000000;
      share = true;
      expireDuplicatesFirst = true;
    };

    initExtraBeforeCompInit = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
      
      # export VDPAU_DRIVER=va_gl
      # export LIBVA_DRIVER_NAME=i965
      
      # direnv extensions cause warnings
      typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
      
      source "$HOME/.p10k.zsh"
      source "${p10kPath}/powerlevel10k.zsh-theme"
      source "${prezto}/init.zsh"
      source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
    '';

    initExtra = ''
      export ENHANCD_DISABLE_DOT=1
      export ENHANCD_DISABLE_HYPHEN=1
      export ENHANCD_DISABLE_HOME=1
      source "${enhancd}/init.sh"
      
      # the first compinit doesn't catch everything on fpath.
      compinit
      
      # Show loading dots while waiting for tab completion.
      export COMPLETION_WAITING_DOTS="true"
      
      zstyle :prezto:module:prompt theme powerlevel10k
      
      # Use the same colors as ls from dircolors.
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      
      # arrow key menu-style selection of tab completions
      zstyle ':completion:*' menu select
      
      # Set the Prezto modules to load (browse modules).
      # The order matters.
      zstyle ':prezto:load' pmodule \
        'environment' \
        'terminal' \
        'editor' \
        'history' \
        'directory' \
        'spectrum' \
        'utility' \
        'ssh' \
        'ruby' \
        'rails' \
        'completion' \
        'command-not-found' \
        'prompt'
      
      setopt clobber
      setopt no_rm_star_silent
      setopt APPEND_HISTORY # sessions append rather than replace
      
      typeset -A ZSH_HIGHLIGHT_STYLES
      ZSH_HIGHLIGHT_STYLES[cursor]=underline
      
      if [[ -e "$HOME/.local/bin" ]]; then
        export PATH=$HOME/.local/bin:$PATH
      fi
      
      if [[ -e "$HOME/go/bin" ]]; then
        export PATH=$HOME/go/bin:$PATH
      fi
      
      if [[ -d "$HOME/.nix-defexpr/channels" ]]; then
        export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
      fi
      
      hash kubectl &> /dev/null && source <(kubectl completion zsh) || {}
      
      # alias gopass='GPG_TTY=$(tty) gopass'
      # alias git='GPG_TTY=$(tty) git'
      bindkey -e
      
      # ctrl left/right
      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word
      
      # delete
      bindkey  "^[[3~"  delete-char
      
      (( ! ''${+functions[p10k]} )) || p10k finalize
    '';

    shellAliases = {
      ls = "ls --color=auto";
      yay = "yay --color=auto";
      dmesg = "dmesg --color=auto";
      less = "less -r"; # allow color passthrough
      suspend = "sudo systemctl suspend";
    };

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.6.4";
          sha256 = "0h52p2waggzfshvy1wvhj4hf06fmzd44bv6j18k3l9rcx6aixzn6";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "v0.7.1";
          sha256 = "03r6hpb5fy4yaakqm3lbf4xcvd408r44jgpv4lnzl9asp4sb9qc0";
        };
      }
      {
        name = "enhancd";
        src = enhancd;
      }
      {
        name = "zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "0.31.0";
          sha256 = "0rw23m8cqxhcb4yjhbzb9lir60zn1xjy7hn3zv1fzz700f0i6fyk";
        };
      }
    ];
  };
}
