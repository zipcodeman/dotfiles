txtblk='\[\e[0;30m\]' # Black - Regular
txtred='\[\e[0;31m\]' # Red
txtgrn='\[\e[0;32m\]' # Green
txtylw='\[\e[0;33m\]' # Yellow
txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;36m\]' # Cyan
txtwht='\[\e[0;37m\]' # White
bldblk='\[\e[1;30m\]' # Black - Bold
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldblu='\[\e[1;34m\]' # Blue
bldpur='\[\e[1;35m\]' # Purple
bldcyn='\[\e[1;36m\]' # Cyan
bldwht='\[\e[1;37m\]' # White
unkblk='\[\e[4;30m\]' # Black - Underline
undred='\[\e[4;31m\]' # Red
undgrn='\[\e[4;32m\]' # Green
undylw='\[\e[4;33m\]' # Yellow
undblu='\[\e[4;34m\]' # Blue
undpur='\[\e[4;35m\]' # Purple
undcyn='\[\e[4;36m\]' # Cyan
undwht='\[\e[4;37m\]' # White
bakblk='\[\e[40m\]'   # Black - Background
bakred='\[\e[41m\]'   # Red
badgrn='\[\e[42m\]'   # Green
bakylw='\[\e[43m\]'   # Yellow
bakblu='\[\e[44m\]'   # Blue
bakpur='\[\e[45m\]'   # Purple
bakcyn='\[\e[46m\]'   # Cyan
bakwht='\[\e[47m\]'   # White
txtrst='\[\e[0m\]'    # Text Reset

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
if [[ -n "$PS1" ]]; then

clear
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


# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=yes
    fi
fi


function get_prompt(){
  dir=`pwd`
  SPLIT=(${dir//\// })
  PROMPT="\n┌─ [$txtpur\w$txtrst]\n"
  if [[ ${SPLIT[0]} == 'www' ]]; then
    if [[ ${#SPLIT[@]} -lt 2 ]]; then
      PROMPT="${PROMPT}├┬─ [${txtpur}Websites$txtrst] \n$txtrst"
      PROMPT="${PROMPT}`ls --color=never --indicator-style=none | sed -e"s/^/││ /"`"
      PROMPT="${PROMPT}\n"
    elif [[ ${#SPLIT[@]} -lt 3 ]]; then
      PROMPT="┌─ [${txtpur}${SPLIT[1]}$txtrst]\n"
    else
      PROMPT="┌─ [${txtpur}${SPLIT[2]}.${SPLIT[1]}$txtrst]\n"
    fi
  fi
  GIT_CHECK=$(git rev-parse --git-dir 2> /dev/null)
  if [ "$?" == "0" ]; then
    status=`git status --porcelain -uno 2> /dev/null | sed -e 's/^/││/'`
    PROMPT="${PROMPT}├┬─ [${txtblu}Git$txtrst]\n"
    branch=$(git branch | grep --color=never ^\* | sed -e 's/* //')
    remote=$(git config branch.$branch.remote)
    something=false
    if [ ! -z "$status" ]; then
      something=true
      PROMPT="${PROMPT}$txtrst││$txtblu Status $txtrst\n$status\n"
    fi
    if [[ $something == false ]]; then
      PROMPT="${PROMPT}$txtrst││$txtblu Nothing to report$txtrst\n"
    fi
    PROMPT="${PROMPT}├┘$txtcyn $branch $txtrst-> $txtpur$remote$txtrst\n"
  fi
  PROMPT="${PROMPT}└$txtred\$ $bldwht"
  tput sgr 0
  echo "$PROMPT"
}

bigP="$txtrst[$bldblu\!$txtrst][$bldred\u@\H:\w$txtrst]$txtred\$$bldwht "
smallP="$bldblu[\!]$txtred\$$bldpur "
funP="${bldblu}I can haz command ${bldred}\u? > $bldpur"
looseP="$bldblu\! $bldred\u : \W $txtred\$$bldpur "
conciseP="$bldred\w $tetrsn:$bldpur "
noP="$txtred>$bldpur "
newP="$txtrst[$txtblu\w$txtrst]$txtred\$ $bldwht"
dynP="$(get_prompt)"

fullP=""
if [ "$color_prompt" == yes ]; then
	# PS1=$bigP
  # PS1=$newP
  export PROMPT_COMMAND='history -a;history -r;PS1=$(pyprompt)'
  # export PS1 PROMPT_COMMAND
	#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	
else
	PS1='[\!][\u@\H:\w]\$ '
# PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
#
#if [ -f ~/.bash_aliases ]; then
 #   . ~/.bash_aliases
#fi

export EDITOR=/usr/bin/vim
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
#    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#programming
alias toco="cd /home/zach/toco"
alias cs13="cd /home/zach/sc/cs13"

#Cal Classes
alias cs61c="ssh -X cs61c-gw@hive20.cs.berkeley.edu"
alias cs188="ssh -X cs188-gb@hive11.cs.berkeley.edu"
alias cs170="ssh -X cs170-nx@hive15.cs.berkeley.edu"

alias gc="ssh -X gamers@ocf.berkeley.edu"

# alias cs61as="ssh -X cs61as-bs@nova.cs.berkeley.edu"
# alias cs47b="ssh -X cs47b-ak@star.cs.berkeley.edu"
# alias cs70="ssh -X cs70-cr@star.cs.berkeley.edu"

function hawk(){
   echo Changing Directory
   cd /home/zach/rh/batch
   echo Updating SVN
   svn update
   echo Running ctags
   ctags --c++-kinds=+p --fields=+iaS --extra=+q *.cpp *.hpp
   UNAME=$(whoami)
   echo Everything is ready for you, $UNAME
}
function hawkApp(){
   echo Changing Directory
   cd /home/zach/rh/RecipeHawkApp
   echo Updating SVN
   svn update
   echo Entering Trunk
   cd trunk
   echo Running ctags
   ctags --c++-kinds=+p --fields=+iaS --extra=+q *.cpp *.hpp
   UNAME=$(whoami)
   echo Everything is ready for you, $UNAME
}

alias gcweb="~/jobs/gcweb"
alias gcserver="~/jobs/gcserver"

#alias doxygen="hawk;doxygen;doxycommit"
alias phil="cd /home/zach/sc/phil4"
alias progr="cd /home/zach/programming"
alias orbit="cd /home/zach/programming/planets"
alias AI="cd /home/zach/programming/AI"
#common feh instances

#Fullscreen recursive zoomed
alias ffeh="feh -rdZF"
alias feh1="ffeh -D1" # 1 sec
alias feh2="ffeh -D2" # 2 sec
alias feh3="ffeh -D3" # 5 sec
alias feh4="ffeh -D4" # 4 sec
alias feh5="ffeh -D5" # 5 sec
alias feh6="ffeh -D6" # 6 sec
alias feh7="ffeh -D7" # 7 sec
alias feh8="ffeh -D8" # 8 sec
alias feh9="ffeh -D9" # 9 sec

alias rfeh1="ffeh -zD1"
alias rfeh2="ffeh -zD2"
alias rfeh3="ffeh -zD3"
alias rfeh4="ffeh -zD4"
alias rfeh5="ffeh -zD5"
alias rfeh6="ffeh -zD6"
alias rfeh7="ffeh -zD7"
alias rfeh8="ffeh -zD8"
alias rfeh9="ffeh -zD9"


#alias ls="ls --color=always"
alias lls="ls -la"
alias rm='rm -i'
alias frm='rm'
alias getme="sudo aptitude install"
alias throwout="sudo aptitude remove"
alias music="mplayer -shuffle Music/* Music/*/*"
alias mkdir="mkdir -p"
alias psl="ps -eH"
alias du='du -kh'
alias df='df -kTh'

#printing
alias lp='lp -o page-top=30 -o page-bottom=40 -o page-left=10 -o page-right=10'

alias lock='svn lock'
alias unlock='svn unlock'
alias commit='svn commit'
alias update='svn update'

#alias mandelbrot='/home/zach/programming/adaptiveManderbrot/bin/mandelbrot'

# some more ls aliases
alias ll="ls -l --group-directories-first"
alias ls='ls -hF --color'  # add colors for filetype recognition
alias la='ls -Al'          # show hidden files
alias lx='ls -lXB'         # sort by extension
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -al | more'    # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias tree='tree -Csu'     # nice alternative to 'recursive ls'
alias vmac='cd /home/zach/sc/cs13/lab5; java vmTest'
alias twit='/home/zach/jobs/twit'

# task manager
alias t='python ~/bin/t/t.py --task-dir ~/tasks --list tasks'
alias g='python ~/bin/t/t.py --task-dir ~/tasks --list groceries'

alias cowall='cowsay | wall'

alias nautilus='nautilus --no-desktop'
# j 
# export JPY=~/bin/j/j.py
# . ~/bin/j/j.sh

# some handy functions

function pf(){
   if [ -f $1 ] ; then
      mpage -1 $1 | lp
   else
      echo File $1 Not Found
   fi
}

function gnome-open(){
  echo It\'s called xdg-open, you moron.

  xdg-open $@
}

alias op="xdg-open"

function extract()      # Handy Extract Program.
{
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xvjf $1     ;;
			*.tar.gz)    tar xvzf $1     ;;
			*.bz2)       bunzip2 $1      ;;
			*.rar)       unrar x $1      ;;
			*.gz)        gunzip $1       ;;
			*.tar)       tar xvf $1      ;;
			*.tbz2)      tar xvjf $1     ;;
			*.tgz)       tar xvzf $1     ;;
			*.zip)       unzip $1        ;;
			*.Z)         uncompress $1   ;;
			*.7z)        7z x $1         ;;
			*)           echo "'$1' cannot be extracted via >extract<" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

function doxycommit(){
   MESS=`date`
   svn commit ~/rh/batch/doxy/html -m"$MESS"
}

function archive()	# Archive any file
{
	len=${#1}
	c=0
	for i in "$@"; do
		if [ $c == 0 ];  then
			c=1
		else
			files=$files" "$i
		fi
	done
	case $1 in 
		*.tar)			tar -cfv $1 $files		;;
		*.tar.bz2)		tar -cjfv $1 $files		;;
		*.tar.gz)		tar -czfv $1 $files		;;
		*.bz2)			bzip2 -kv $files		;;
	esac
}

function vimlock(){
	rm -f /tmp/vimlock.check
	svn lock $1 2> /tmp/vimlock.check
	if [ ! -s /tmp/vimlock.check ]; then
		vim $1
		read -r -n1 -p "Commit? "  yn
		echo
		if [ "$yn" == "y" ]; then
			read -r -p "Message: " mess
			svn commit $1 -m "$mess"
			svn unlock $1 2> /dev/null
		else
			read -r -n1 -p "Unlock? " yn
			echo
			if [ "$yn" == "y" ]; then
				svn unlock $1
			fi
		fi
	else
		echo "An error was encountered trying to lock '`pwd`/$1'"
		cat /tmp/vimlock.check
	fi

}
function prompt() 	# prompt loader
{
	case $1 in
		-l)			PS1=$bigP		;;
		-s)			PS1=$smallP		;;
		-f)			PS1=$funP		;;
		-L)			PS1=$looseP		;;
		-c)			PS1=$conciseP	;;
		-N)			PS1=$noP		;;
		*)
			echo "No Type Specified"
			echo "Valid Args:"
			echo "	-l:		long format"
			echo "	-s:		short format"
			echo "	-f:		a funny prompt" 
			echo "	-L:		loose prompt"
			echo "	-c:		concise prompt"
			echo "	-N:		No Prompt"
			echo "you entered: '$1'"
			;;
	esac
}

# enable programmable completion features (you don't need to enable
# this, if i's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$HOME/bin/
PATH=$PATH:$HOME/bin/rust/bin/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/bin/rust/lib/

alias rustup="rustup --channel=nightly --prefix=~/bin/rust/ --disable-sudo"


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

firm() {
  cd $HOME/Projects/Firmware/android-j
  source build/envsetup.sh
  lunch capri_me1-eng
  cd ..
  start_rs_megaprompt
}

dni () {
  cd $HOME/Projects/Firmware/android-j/packages/apps/DroidNode

  mm && \
    adb push $OUT/system/app/DroidNode.apk /system/app && \
    adb shell "kill \`ps | grep com.meraki.droidnode$ | tr -s ' ' | cut -d ' ' -f2\`"
}
dn () {
  cd $HOME/Projects/Firmware/android-j/packages/apps/DroidNode

  dni
  while inotifywait -r -e delete -e create -e move -e modify *; do
    dni
  done
}
start_rs_megaprompt
