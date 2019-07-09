export EDITOR=nvim
export LC_ALL=en_US.UTF-8
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export COMMAND_NOT_FOUND_INSTALL_PROMPT=1

if [ ! -d $HOME/.homesick/repos/homeshick ]; then
  echo "Setting up Homeshick. Please Wait."
  git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
fi

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
if [ -n "$ZSH_VERSION" ]; then
  fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
elif [ -n "$BASH_VERSION" ]; then
  source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
fi

if [ ! -d $HOME/.solarized/dircolors-solarized ]; then
  echo "Setting up dircolors solarized. Please wait."
  (
    mkdir ~/.solarized
    cd ~/.solarized
    git clone git://github.com/seebi/dircolors-solarized.git
  )
fi
eval `dircolors ~/.solarized/dircolors-solarized/dircolors.ansi-dark`

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$HOME/bin:$PATH
PATH=$HOME/.local/bin:$PATH
PATH=$HOME/Projects/woff2/:$PATH
PATH=$HOME/.yarn/bin:$PATH
PATH=$HOME/Projects/fuchsia/.jiri_root/bin:$PATH
PATH=$PATH:$HOME/Projects/cobalt/sysroot/bin

source $HOME/.cargo/env

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias vim='nvim'
alias rm='rm -i'
alias ls='ls --color=always'
alias update-vim='vim +PlugUpgrade +PlugClean +PlugInstall +PlugUpdate +qall'
alias tmux='tmux -2'
alias t='todo.sh'

big_echo() {
  echo "####$(echo $@ | sed 's/./#/g')####"
  echo "##  $(echo $@ | sed 's/./ /g')  ##"
  echo "##  $@  ##"
  echo "##  $(echo $@ | sed 's/./ /g')  ##"
  echo "####$(echo $@ | sed 's/./#/g')####"
}

echo "Check homeshick"
homeshick refresh 1
echo
