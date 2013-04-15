export _Z_CMD=j
. ~/bin/z/z.sh

setopt autocd
setopt promptpercent
setopt promptsubst

PS1='$(~/bin/pyprompt zsh)'
# function precmd() {
  # PS1=$(~/bin/pyprompt zsh)
# }

function chpwd() {
  emulate -L zsh
  ls -a
}

PATH=$PATH:$HOME/.rvm/bin:$HOME/.aws/eb/linux/python2.7/:~/.android-tools/platform-tools:~/.android-tools/tools
