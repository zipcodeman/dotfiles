if [[ -n "$PS1" ]]; then
  export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

  # append to the history file, don't overwrite it
  shopt -s histappend

  # check the window size after each command and, if necessary,
  # update the values of LINES and COLUMNS.
  shopt -s checkwinsize

  # make less more friendly for non-text input files, see lesspipe(1)
  [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

  # set variable identifying the chroot you work in (used in the prompt below)
  if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
      debian_chroot=$(cat /etc/debian_chroot)
  fi

  if [ -f ~/.config/zsh/zsh-bash-common.sh ]; then
    source ~/.config/zsh/zsh-bash-common.sh
  fi

  # enable programmable completion features (you don't need to enable
  # this, if i's already enabled in /etc/bash.bashrc and /etc/profile
  # sources /etc/bash.bashrc).
  if [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
  fi

  start_megaprompt() {
    export PROMPT_COMMAND='PS1=$($HOME/bin/binaries/megaprompt/pyprompt)'
  }

  start_rs_megaprompt() {
    live_compile=$1
    mp="$HOME/bin/binaries/megaprompt"
    cmd="PS1=\$($HOME/.cargo/bin/megaprompt --bash)"
    if [ -z "$live_compile" ]; then
      export PROMPT_COMMAND=$cmd
    else
      export PROMPT_COMMAND="(
        cd $mp;
        cargo build --release &&
          ! cmp --silent $mp/target/release/megaprompt $HOME/bin/megaprompt &&
          cp -fv $mp/target/release/megaprompt $HOME/bin/megaprompt
        ); $cmd"
    fi
  }


  [ -f ~/.fzf.bash ] && source ~/.fzf.bash
  [ -f ~/.bashrc.local ] && source ~/.bashrc.local

  clear

  echo "Check homeshick"
  homeshick refresh 1
  echo
  echo -ne "\033[0m"
  cal -3
  echo
  ddate;date +'%I:%M:%S.%N'
  echo
  echo -ne "\033[0;36m";uptime
  echo
  echo -ne "\033[1;34m""Hello $USER, Welcome to bash\033[0m"
  echo
  #echo

  start_rs_megaprompt
fi


## KEEP THIS STUFF LAST
function command_log () {
  # Save the rv
  local -i rv="$?"
  # Get the last line local
  last_line="${BASH_COMMAND}"
  mkdir -p $HOME/.shell_logs
  local logfile="$HOME/.shell_logs/${HOSTNAME}"
  local current_ts="$(date '+%Y%m%d %H:%M:%S')"
  if [ "$last_line" != '' ] && [ "$last_line" != "PS1=\$($HOME/zmbush/bin/megaprompt)" ]; then
    echo "${current_ts} ${LOGNAME} Status[${rv}] SPID[${$}] PWD[${PWD}]" \
      \'${last_line#        }\' >> "${logfile}"
  fi
}

trap command_log DEBUG

function settitle() {
  case "$BASH_COMMAND" in
    *PS1=*)
      # Usually happens on a PROMPT_COMMAND
      # Reset title
      echo -ne "\033]0;Terminal\007"
      ;;
    *)
      # Set title to match command
      echo -ne "\033]0;${BASH_COMMAND}\007"
  esac
}

trap 'settitle' DEBUG

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
