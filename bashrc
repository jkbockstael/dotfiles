# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

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

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Environment
PAGER=less
EDITOR=vim
VISUAL=vim
HISTFILE=~/.bash_history
export PAGER EDITOR VISUAL HISTFILE

# Prompt
promptbasic () { # Command: Change to a basic prompt
	local TERMDEFAULT='\[\e[0m\]'
	local BOLDGRAY='\[\e[30;1m\]'
	local LIGHTRED='\[\e[0;31m\]'
	local LIGHTGREEN='\[\e[0;32m\]'
	case $TERM in
		xterm*)	TITLEBAR="$TERMDEFAULT\u@\h:\w" ;;
		*)		TITLEBAR="" ;;
	esac
	PS1="${TERMDEFAULT}[${LIGHTRED}\u @ \h ${LIGHTGREEN}\W${TERMDEFAULT}]\$ "
	PS3="${TERMDEFAULT}> ${TERMDEFAULT}"
	PS4="${TERMDEFAULT}+ ${TERMDEFAULT}"
	export PS1 PS2 PS4
	}
promptbasic

# Aliases
alias ls="ls --color"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias more="less"
alias less="less -R"
alias top="top -u"
alias tree="tree -C"
alias grep="grep --color=always"
alias egrep="egrep --color=always"
alias fgrep="fgrep --color=always"
alias gohome="ssh jkbockstael@jkbockstael.be"
alias doom-shareware="doom -iwad doom1-shareware.wad" # DOOM Shareware
alias doom1="doom -iwad ultimate-doom.wad" # The Ultimate Doom
alias doom-final-plutonia="doom -iwad plutonia.wad" # Final Doom - The Plutonia Experiment
alias doom-final-tnt="doom -iwad tnt.wad" # Final Doom - TNT: Evilution
alias doom2="doom -iwad doom2.wad" # Doom II: Hell on Earth
alias heretic="/usr/games/heretic -iwad heretic.wad" # Heretic: Shadow of the Serpent Riders
alias hexen="/usr/games/hexen -iwad hexen.wad" # HeXen: Beyond Heretic
alias hexen-dk="/usr/games/hexen -iwad hexen.wad -file hexdd.wad" # HeXen: Deathkings of the Dark Citadel
