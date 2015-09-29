# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# ta bort Ctrl+S = lås
stty stop undef
stty start undef

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

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
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias irca='ssh malin@tunna.org'
alias gotosleep='sudo pm-suspend-hybrid'
alias printwhat='lpq -a'
alias printstop='lprm'
alias findprinter='system-config-printer'
alias abstract='~/GF/lib/src/abstract/*'
alias scandinavian='~/GF/lib/src/scandinavian/*'
alias swedish='~/GF/lib/src/swedish/*'
alias untar='tar -xvf'
alias ungz='tar -xzf'
alias gs='git status'
alias ga='git add -u'
alias gm='git commit -m'
alias gp='git push'
alias gb='git branch'
alias gc='git checkout'

alias gsvnup='git svn rebase'
alias gsvnp='git svn dcommit'
alias scheck='svn checkout'
alias sc='svn commit -m'
alias sup='svn update'
alias ss='svn status'

alias sshkark='ssh kark.spraakdata.gu.se'
alias ssk='ssh kark.spraakdata.gu.se'
alias sshdemo='ssh demo.spraakdata.gu.se'
alias ssb='ssh burk.spraakdata.gu.se'
alias ssba='ssh bark.spraakdata.gu.se'

alias ghc='ghc -i$GHC_INCLUDE_DIRS'
alias ghci='ghci -i$GHC_INCLUDE_DIRS'
alias runghc='runghc -i$GHC_INCLUDE_DIRS'

alias givm='gvim'

alias lt='ls -lt | head'
alias cal='ncal -Mb'
alias tidyx='tidy -m -i -xml'
alias kleene='java -jar /home/malin/lib/kleenelang/current/Kleene.jar -encoding UTF-8'
alias kleenenouni='java -jar /home/malin/lib/kleenelang/current/Kleene.jar'
alias tokleene='cd /home/malin/lib/kleenelang/current'

alias dvorak='setxkbmap us;  setxkbmap -variant dvorak-intl ; xmodmap ~/xmodmap-swapcapsesc ; xmodmap ~/svensk-aoe ; xmodmap ~/xmod-restore'

alias cl='cdl'
function cdl(){
  cd "$1"
  ls
  }
function nmtray(){
  echo "hej"
  stalonetray ;
  nm-applet 
  }
function showfst_sym (){
   fstdraw --isymbols=syms.txt --osymbols=syms.txt $1 kast.dot
   dot -Tps kast.dot > fst.ps
}
function showfst (){
   fstdraw $1 kast.dot
   dot -Tps kast.dot > fst.ps
}
function trams () {
  TEX=$1
  MODS=$1
  if [ $# -gt 1 ] ; then
   shift
   TEX=$@
  fi
  echo $TEX
    }
function dolatex () {
  TEX=$1
  MODS=$1
  if [ $# -gt 1 ] ; then
   MODS=$@
  fi
  while true;
  do (yes '' | pdflatex $TEX);
  inotifywait -q -e modify $MODS ; done
    }
function dobiblatex () {
  TEX=$1
  MODS=$@
  BIB="`basename $1 .tex`.aux"
  while true;
  do (yes '' | pdflatex $TEX);
  bibtex $BIB;
  bibtex $BIB;
  (yes '' | pdflatex $TEX);
  inotifywait -q -e modify $MODS ; done
    }
function makelatex () {
  while true;
  do (make);
  inotifywait -q -e modify $MODS ; done
    }
function showdot () {
 dot -Tpdf $1 > tmp.pdf ;
 xpdf tmp.pdf  ;
 } 

#function gvim(){
#  gvim $@ &
#  }

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


xset r rate 150
export GF_LIB_PATH=~/GF/lib/src/
export JUNTO_DIR=~/lib/junto-master
export PATH="$JUNTO_DIR/bin:$PATH"
export GHC_INCLUDE_DIRS=.
export PATH="$HOME/.cabal/bin:$HOME/bin:$PATH:$HOME/bin/foma"
export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH:/home/malin/lib/kleenelang/kleene/kleene-linux-0.9.3.5"
export JAVA_HOME="/usr/lib/jvm/java-6-openjdk-i386"
export TESSDATA_PREFIX="/home/malin/lib/ocricola-code"
export CLASSPATH="/usr/share/java/weka.jar:/home/malin/lib/libsvm/java/libsvm.jar:/home/malin/lib/libsvm/java/"
alias scpfromkark="echo {kark.spraakdata.gu.se:$1} $2"
scpkark () {
  scp $@ kark.spraakdata.gu.se:.
  }
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}
alias mktar='tar -cvzf' # name.tgz subdir
export PYTHONIOENCODING=utf-8
export PYTHONPATH="/home/malin/lib/scikit-learn:$PYTHONPATH"
export PATH="$HOME/.vim/bundle/syntastic/syntax_checkers/python:$PATH"
export PATH="/usr/local/texlive/2012/bin/i386-linux:$PATH"

source <(jbo bashrc)
