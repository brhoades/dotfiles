{ pkgs, ... }:

let
  p10k = pkgs.zsh-powerlevel10k;
  p10kPath = "${p10k}/share/zsh-powerlevel10k";
  unstablePkgs = import <nixpkgs-unstable> {};
  prezto = unstablePkgs.zsh-prezto;
in {
  home = {
    packages = [
      prezto
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
# POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true # ~/.p10k is missing on nixos and p10k is persistent.
'';

    initExtra = ''
setopt clobber
setopt no_rm_star_silent
setopt APPEND_HISTORY # sessions append rather than replace

# Show loading dots while waiting for tab completion.
COMPLETION_WAITING_DOTS="true"

# Use the same colors as ls from dircolors.
zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

source "${prezto}/init.zsh"
source "$HOME/.p10k.zsh"
source "${p10kPath}/powerlevel10k.zsh-theme"
zstyle :prezto:module:prompt theme powerlevel10k

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

# Refresh gpg-agent tty in case user switches into an X session
# export GPG_TTY=$(tty)
# eval "$(gpgconf --launch gpg-agent)"
# gpg-connect-agent updatestartuptty /bye >/dev/null

# Enable SSH Agent support in GPG Agent
# unset SSH_AGENT_PID
# export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

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
          sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "v0.7.1";
          sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
        };
      }
    ];
  };

  # systemd zsh completions.
  # environment.pathsToLink = [ "/share/zsh" ];
}
