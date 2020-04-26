setopt clobber
setopt no_rm_star_silent
setopt APPEND_HISTORY # sessions append rather than replace

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

SCRIPT=$(readlink -f $0)
SPATH=$(dirname "$SCRIPT")
source "$SPATH/powerlevel10k/powerlevel10k.zsh-theme"
zstyle :prezto:module:prompt theme powerlevel10k
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[cursor]=underline

export TERM='xterm-256color'
export EDITOR=vim
export GIT_EDITOR=$EDITOR
export GPG_TTY=$(tty)
alias suspend='sudo systemctl suspend'
alias rm='rm'
alias dmesg='dmesg --color=always'
alias less='less -r'
alias yay='yay --color=always'
bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

if [[ -e "$HOME/.local/bin" ]]; then
  export PATH=$HOME/.local/bin:$PATH
fi

NVM_DIR="$HOME/.nvm"
if [[ -d $NVM_DIR ]]; then
  export NVM_DIR
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

hash kubectl && source <(kubectl completion zsh) || {}
hash direnv && eval "$(direnv hook zsh)" || {}
hash pazi && eval "$(pazi init zsh)" || {}
