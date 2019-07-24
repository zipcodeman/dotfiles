export ZSH=~/.oh-my-zsh

ZSH_THEME="megaprompt"
ZSH_CUSTOM=~/.config/zsh/custom/

plugins=(
  common-aliases
  cp
  git
)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -s '/etc/zsh_command_not_found' ]]; then
  source '/etc/zsh_command_not_found'
fi

if [ -f ~/.bashrc.local ]; then
  autoload -U +X compinit && compinit
  autoload -U +X bashcompinit && bashcompinit

  source ~/.bashrc.local
fi

source $ZSH/oh-my-zsh.sh
source ~/.config/zsh/zsh-bash-common.sh

alias bigfont="printf '\\e]710;%s\\007' \"xft:Ubuntu Mono derivative Powerline:pixelsize=30:antialias=true:hinting=full,xft:DejaVu Sans Mono for Powerline:pixelsize=30:antialias=true:hinting=full\""
alias bigbold="printf '\\e]711;%s\\007' \"xft:Ubuntu Mono derivative Powerline:style=bold:pixelsize=30:antialias=true:hinting=full,xft:DejaVu Sans Mono for Powerline:style=bold:pixelsize=30:antialias=true:hinting=full\""
