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

  export EDITOR=/usr/bin/vim

  alias rm='rm -i'
  alias ls='ls --color=always'

  # enable programmable completion features (you don't need to enable
  # this, if i's already enabled in /etc/bash.bashrc and /etc/profile
  # sources /etc/bash.bashrc).
  if [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
  fi

  PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

  export COMMAND_NOT_FOUND_INSTALL_PROMPT=1
  start_megaprompt() {
    export PROMPT_COMMAND='PS1=$($HOME/bin/binaries/megaprompt/pyprompt)'
  }

  start_rs_megaprompt() {
    live_compile=$1
    mp="$HOME/bin/binaries/megaprompt"
    cmd="PS1=\$($HOME/bin/megaprompt)"
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

  big_echo() {
    echo "####$(echo $@ | sed 's/./#/g')####"
    echo "##  $(echo $@ | sed 's/./ /g')  ##"
    echo "##  $@  ##"
    echo "##  $(echo $@ | sed 's/./ /g')  ##"
    echo "####$(echo $@ | sed 's/./#/g')####"
  }

  start_rs_megaprompt

  if [ ! -d $HOME/.homesick/repos/homeshick ]; then
    echo "Setting up Homeshick. Please Wait."
    git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
  fi

  source "$HOME/.homesick/repos/homeshick/homeshick.sh"
  source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"

  RUSTUP_LOCATION=~/bin/rustup

  [ -f ~/.fzf.bash ] && source ~/.fzf.bash
  [ -f ~/.bashrc.local ] && source ~/.bashrc.local

  PATH=$HOME/bin:$PATH

  clear

  if [ ! -f "$RUSTUP_LOCATION" ]; then
    wget https://static.rust-lang.org/rustup.sh -O "$RUSTUP_LOCATION"
    chmod +x "$RUSTUP_LOCATION"
    big_echo "FILE UPDATED: CHECK '$RUSTUP_LOCATION'"
  fi

  if [ "$use_local_rustup" == "yes" ]; then
    PATH=$PATH:$HOME/bin/rust/bin
    PATH=$PATH:$HOME/.cargo/bin
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/bin/rust/lib

    alias rustup="'$RUSTUP_LOCATION' --channel=nightly --prefix=~/bin/rust --disable-sudo"
  else
    alias rustup="'$RUSTUP_LOCATION' --channel=nightly"
  fi

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
