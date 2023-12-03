# shellcheck shell=bash

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# enable Vi mode
# set -o vi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=5000

HISTTIMEFORMAT="%Y/%m/%d %H:%M "
HISTIGNORE="h:history:history :exit:clear:c:..:...:cd:fg"

# Base directories for cd command
CDPATH=.:~:~/Documents/guides

# Custom environment variables
export GH_TOKEN="$(awk -F '=' '/GH_TOKEN/ {print $2}' "$HOME/dotfiles/.env")"

# Change directory without cd command
shopt -s autocd

# Review a command like `sudo !!` before it gets executed
shopt -s histverify

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# set default applications
export EDITOR=/usr/bin/vim
export BROWSER=/usr/bin/firefox-esr

# key bindings
bind '"\C-f":"cd_fzf\n"'
bind '"\C-g":"cd_fzf_cwd\n"'
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

function prompt {
    local exit_code=$?

    local white clr_dir clr_branch clr_error clr_clear bold clr_branch underline clr_user
    white="\[$(tput setaf 7)\]"
    bold="\[$(tput bold)\]"
    clr_dir="\[$(tput setaf 3)\]"
    clr_branch="\[$(tput setaf 245)\]"
    clr_dollar="\[$(tput setaf 2)\]"
    clr_error="\[$(tput setaf 1)\]"
    clr_clear="\[$(tput sgr0)\]"
    underline="\[$(tput smul)\]"
    clr_user="\[$(tput setaf 4)\]"

    if [[ $(hostname) != laptop ]]; then
        clr_dir="\[$(tput setaf 4)\]"
    fi

    local branch
    branch="$(git branch --show-current 2>/dev/null)"

    local cwd
    cwd="$(pwd)"

    # PROMPT_DIRTRIM=2

    # Terminal window title
    PS1='\[\e]2;\u@\h:\w\a\]'

    # User
    # PS1+="${clr_user}${bold}\u${clr_clear} "

    # Current directory
    # [ "$cwd" != "$HOME" ] &&
    PS1+="${clr_dir}${bold}\W${clr_clear} "

    # Git branch
    [ -n "$branch" ] && PS1+="${clr_branch}${branch}${clr_clear} "
    PS1+="${bold}"

    # Exit status
    if (( exit_code != 0 )); then
        PS1+="${clr_error}"
    else
        PS1+="${clr_dollar}"
    fi

    PS1+='\$ '
    PS1+="${clr_clear}"

    # Optionally change text input, e.g. color
    # PS1+="$clr_dir"
    # PS0="$clr_clear"
    # PS0="\n"
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
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
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
src_files=(
    .bash_aliases
    .bash_functions.sh
    .cargo/env
)
for f in "${src_files[@]}"; do
    [ -f "${HOME}/${f}" ] && . "${HOME}/${f}"
done

source /usr/share/doc/fzf/examples/key-bindings.bash

# fzf[reverse]='--reverse'
# fzf[cycle]='--cycle'
# fzf[border]='--border=sharp'
# fzf[prompt]='--prompt=→ '
# fzf[pointer]='--pointer= '
# fzf[marker]='--marker=* '
# fzf[color]='--color=dark,fg+:white,fg:white,bg+:-1,marker:red,info:grey'
# fzf[height]='--height=90%'
# fzf[min_height]='--min-height=10'
# fzf[padding]='--padding=0,8%,13%,3%'
# fzf[preview]='--preview=git diff $@ --color=always -- {-1}'
# fzf[preview_window]="--preview-window=${fzf_preview_hidden:-}border-sharp"
# fzf[bind_preview]='--bind=ctrl-p:toggle-preview'
# fzf[bind_select]='--bind=ctrl-a:select-all,ctrl-d:deselect-all'

window_width=$(tput cols)

if (( window_width < 90 )); then
    fzf_preview_hidden='hidden,'
fi

export FZF_DEFAULT_COMMAND='fdfind . --hidden --strip-cwd-prefix'
export FZF_DEFAULT_OPTS="--layout=reverse-list --cycle --prompt='→ ' --pointer=' ' --border=sharp --preview-window=${fzf_preview_hidden:-}border-none --color=fg+:white,fg:247,bg+:-1,prompt:white,info:grey --bind=ctrl-u:clear-query --height=65%"

export FZF_CTRL_T_COMMAND='fd . --hidden --strip-cwd-prefix'

