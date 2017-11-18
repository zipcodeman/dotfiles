export ZSH=~/.oh-my-zsh

ZSH_THEME="megaprompt"
ZSH_CUSTOM=~/.config/zsh/custom/

plugins=(
  common-aliases
  cp
  git
)

source ~/.config/zsh/zsh-bash-common.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -s '/etc/zsh_command_not_found' ]]; then
  source '/etc/zsh_command_not_found'
fi

source $ZSH/oh-my-zsh.sh
