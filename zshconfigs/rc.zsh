setopt clobber
setopt no_rm_star_silent
setopt APPEND_HISTORY # sessions append rather than replace

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
#
# Executes commands at the start of an interactive session.
#
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/lib/dotconfigs/zshconfigs/powerlevel10k/powerlevel10k.zsh-theme
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

# debian garbage
if ! echo "$PATH" | grep -q "/usr/sbin"; then
  export PATH="/usr/sbin:$PATH"
fi

if [[ -e "$HOME/.local/bin" ]]; then
  export PATH=$HOME/.local/bin:$PATH
fi

eval "$(direnv hook zsh)"

NVM_DIR="$HOME/.nvm"
if [[ -d $NVM_DIR ]]; then
  export NVM_DIR
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# old stuff
JAVA_HOME="/usr/lib/jvm/java-8-openjdk"
if [[ -d $JAVA_HOME ]]; then
  export JAVA_HOME
fi

ANDROID_SDK_HOME="/opt/android-sdk/"
if [[ -d $ANDROID_SDK_HOME ]]; then
  export ANDROID_SDK_HOME
fi

# CPP stuff
export GTEST_INCLUDE_DIRS=/usr/lib/

# work stuff
if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi

eval "$(pazi init zsh)"
