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
prompt-git-info () {
    # Get Git status, if applicable
    local git_info=""
    if [ $(git rev-parse --is-inside-work-tree &> /dev/null; echo "${?}") == "0" ]; then
        git_info+=" ("
        # Current branch name
        git_info+="$(git symbolic-ref --quiet --short HEAD)"
        # Status
        git_status="$(git status)"
        dir_status=""
        if [ $(echo "${git_status}" | grep --silent "Your branch is behind"; echo "${?}") == "0" ]; then
            dir_status+="↓"
            dir_status+=$(echo "${git_status}" | grep 'Your branch is behind' | cut -d' ' -f7)
        fi
        if [ $(echo "${git_status}" | grep --silent "Your branch is ahead"; echo "${?}") == "0" ]; then
            dir_status+="↑"
            dir_status+=$(echo "${git_status}" | grep 'Your branch is ahead' | cut -d' ' -f8)
        fi
        git_stash_list="$(git stash list)"
        if [ $(echo "${git_stash_list}" | wc -l) != "0" ]; then
            dir_status+="≡"
            dir_status+=$(echo "${git_stash_list}" | wc -l)
        fi
        if [ "${dir_status}" != "" ]; then
            git_info+=" ${dir_status}"
        fi
        dirtiness=""
        if [ $(echo "${git_status}" | grep --silent "Changes to be committed"; echo "${?}") == "0" ]; then
            dirtiness+="•"
        fi
        if [ $(echo "${git_status}" | grep --silent "Changes not staged"; echo "${?}") == "0" ]; then
            dirtiness+="±"
        fi
        if [ "${dirtiness}" != "" ]; then
            git_info+=" ${dirtiness}"
        fi
        git_info+=")"
    fi
    echo "${git_info}"
}

promptbasic () { # Command: Change to a basic prompt
    local default=$(tput sgr0)
    local gray=$(tput setaf 236)
    local red=$(tput setaf 52)
    local brightred=$(tput setaf 124)
    local green=$(tput setaf 22)
    local blue=$(tput setaf 27)
    local usercolor=$red
    if [ "$USER" == "root" ]; then
        usercolor=$brightred
    fi
    PS1="${gray}[${usercolor}\u @ \h ${green}\W${blue}\$(prompt-git-info)${gray}]\\$ ${default}"
    PS3="${gray}> ${default}"
    PS4="${gray}+ ${default}"
    export PS1 PS2 PS4
}
promptbasic

# Toggle the ThinkLight on my laptop
togglethinklight () {
    local LIGHTDEVICE='/sys/class/leds/tpacpi::thinklight/brightness'
    local MAXBRIGHTNESS='255'
    local MINBRIGHTNESS='0'
    if [ $(cat $LIGHTDEVICE) == 0 ]; then
        echo $MAXBRIGHTNESS | sudo tee $LIGHTDEVICE > /dev/null
    else
        echo $MINBRIGHTNESS | sudo tee $LIGHTDEVICE > /dev/null
    fi
}

# Use the ThinkLight for notification
alias flash='togglethinklight;sleep 1;togglethinklight'

# ROT13 function/filter
rot13() {
    if [ $# -eq 0 ]; then
        tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
    else
        echo $* | tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
    fi
}

# Block until a specific date/time
# Usage: sleep-until tomorrow 16:30; echo "foobar"
sleep-until() {
    if [ $# -eq 0 ]; then
        echo "sleep-until: no date string provided" >&2
        return 1
    fi
    local now=$(date +%s)
    local target=$(date --date "$*" +%s)
    local duration=$(( $target - $now ))
    sleep $duration
}

# Force-toggle Night Light on
nightlight-on() {
    gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
    gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 0
    gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 24
    gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true

}

# Force-toggle Night Light off
nightlight-off() {
    gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled false
}

# Set Night Light to automatic mode
nightlight-auto() {
    gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 20
    gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 6
    gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic true
    gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
}

# Utility function for various compression formats
extract() {
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
alias iddad="sudo -s"
alias please="sudo"
alias fuck='sudo $(history -p !!)'
alias gohome="ssh jkbockstael@jkbockstael.be"
alias doom-shareware="doom -iwad doom1-shareware.wad" # DOOM Shareware
alias doom1="doom -iwad ultimate-doom.wad" # The Ultimate Doom
alias doom-final-plutonia="doom -iwad plutonia.wad" # Final Doom - The Plutonia Experiment
alias doom-final-tnt="doom -iwad tnt.wad" # Final Doom - TNT: Evilution
alias doom2="doom -iwad doom2.wad" # Doom II: Hell on Earth
alias heretic="/usr/games/heretic -iwad heretic.wad" # Heretic: Shadow of the Serpent Riders
alias hexen="/usr/games/hexen -iwad hexen.wad" # HeXen: Beyond Heretic
alias hexen-dk="/usr/games/hexen -iwad hexen.wad -file hexdd.wad" # HeXen: Deathkings of the Dark Citadel
