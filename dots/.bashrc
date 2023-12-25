# shellcheck shell=bash

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Enable Vi mode
# set -o vi

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=5000
export HISTFILESIZE=5000
export HISTTIMEFORMAT="%Y/%m/%d %H:%M "
export HISTIGNORE="h:history:history :exit:clear:c:..:...:cd:fg"

# Set default applications
export EDITOR="/usr/bin/nvim"
export BROWSER="/usr/bin/firefox-esr"

# Base directories for cd command
# CDPATH=.:~:~/Documents/guides

# Append to the history file, don't overwrite it
shopt -s histappend

# Change directory without cd command
shopt -s autocd

# Review a command like `sudo !!` before it gets executed
shopt -s histverify

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s extglob globstar nullglob

# key bindings
bind '"\C-f":"cd_fzf\n"'
bind -x '"\C-o":"open_fzf"'
bind -x '"\C-p":"open_fzf_cwd"'
bind -x '"\ez":"fg"'

open_dir() { vim . ; }
bind -x '"\C-l":"open_dir"'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
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

PROMPT_DIRTRIM=3

red="\[$(tput setaf 1)\]"
green="\[$(tput setaf 2)\]"
yellow="\[$(tput setaf 3)\]"
blue="\[$(tput setaf 4)\]"
purple="\[$(tput setaf 5)\]"
cyan="\[$(tput setaf 6)\]"
white="\[$(tput setaf 7)\]"
grey="\[$(tput setaf 245)\]"
bold="\[$(tput bold)\]"
underline="\[$(tput smul)\]"
rst="\[$(tput sgr0)\]"

prompt() {
    local exit_code=$?

    # colors
    local clr_dir
    clr_dir="\[$(tput setaf 110)\]"
    local clr_ssh
    clr_ssh="\[$(tput setaf 109)\]"
    local clr_branch
    clr_branch="\[$(tput setaf 246)\]"
    local clr_user
    clr_user="\[$(tput setaf 66)\]"
    local branch
    branch="$(git branch --show-current 2>/dev/null)"

    # terminal window title
    PS1='\[\e]2;\u@\h:\w\a\]'

    # user
    # PS1+="${clr_user}\u@\h${rst} "

    if [[ -n $SSH_CLIENT || -n $SSH_TTY ]]; then
        clr_dir="$clr_ssh"
    fi

    # current directory
    PS1+="${clr_dir}\w${rst} "

    # git branch
    test -n "$branch" && PS1+="${clr_branch}(${branch})${rst} "

    PS1+="${grey}"
    # exit status
    (( exit_code != 0 )) && PS1+="${red}"

    PS1+='\$ '
    PS1+="${rst}"
    # PS0='\n'
    # append history from current session to the history file,
    # otherwise it won't be saved when in tmux
    history -a
}


if [ "$color_prompt" = yes ]; then
    export PROMPT_COMMAND=prompt
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
    alias ls='ls -F --group-directories-first'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

# source files
src_paths=(
    "$HOME/.config/bash/aliases"
    "$HOME/.config/bash/functions"
    "$HOME/.config/gg/.env"
    "$HOME/.cargo/env"
    "/usr/share/doc/fzf/examples/key-bindings.bash"
)

for path in "${src_paths[@]}"; do
    test -f "$path" && . "$path"
done

window_width=$(tput cols)

if (( window_width < 90 )); then
    fzf_preview_window_pos=bottom
fi

fzf_def_opts=(
    "--layout=reverse-list"
    "--cycle"
    "--prompt='→ '"
    "--pointer=' '"
    "--border=sharp"
    "--preview-window=hidden,${fzf_preview_window_pos:-right},border-none"
    "--color=fg+:white,fg:247,bg+:-1,prompt:white,info:grey"
    "--bind=ctrl-u:clear-query"
    "--bind=ctrl-space:toggle-preview"
    "--height=85%"
)

export FZF_DEFAULT_COMMAND="fdfind . --hidden --follow"
export FZF_DEFAULT_OPTS="${fzf_def_opts[@]}"

export FZF_CTRL_T_COMMAND="fdfind . --type file --type directory --hidden --strip-cwd-prefix"
export FZF_CTRL_T_OPTS="
    --preview 'batcat -n --color always {}'
    --preview-window=hidden,${fzf_preview_window_pos:-right},border-none"

# Custom environment variables
GH_TOKEN="$(awk -F '=' '/GH_TOKEN/ {print $2}' "$HOME/dotfiles/.env")"
export GH_TOKEN

export NPM_CONFIG_USERCONFIG="$HOME/.config/npm/npmrc"

# export PAGER="most"

nnn_cd() {
    if [ -n "$NNN_PIPE" ]; then
        printf "%s\0" "0c${PWD}" > "${NNN_PIPE}" !&
    fi
}
trap nnn_cd EXIT

export NNN_PLUG='f:finder;o:fzopen;p:mocq;d:diffs;t:nmount;v:imgview'

export BAT_THEME="base16"

