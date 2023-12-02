# allow running aliases with sudo
alias sudo='sudo '

# dotfiles
alias brc='$EDITOR $HOME/.bashrc'
alias src='. $HOME/.bashrc'
alias a='$EDITOR $HOME/.bash_aliases'
alias f='$EDITOR $HOME/.bash_functions.sh'
alias vrc='$EDITOR $HOME/.vimrc'
alias ac='$EDITOR $HOME/.config/alacritty/alacritty.toml'
alias tc='$EDITOR $HOME/.tmux.conf'

# colorize stdout
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'

# cd shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'

# ls shortcuts
alias la='ls -hlsaA'
alias l1='ls -1'

# shortcuts
alias c='clear'
alias e='exit'
alias h='history'
alias hg='history | grep'
alias i='sudo apt install'
alias ui='sudo apt update && sudo apt install'
alias uu='sudo apt update && sudo apt upgrade'
alias j='jobs'
alias v='vim'

# bookmarks
alias gtnotes='cd ~/Documents/notes'
alias gtphp='cd /var/www/html'

alias st='speedtest'
alias open='xdg-open'

# rmdir, mkdir etc.
alias mv='mv -i'
alias mkp='mkdir -p'
alias rmr='rm -r'

# npm
alias ns='npm start'
alias nb='npm run build'

# git
alias ga='git add'
alias gb='git branch'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gc='git commit'
alias gcm='git commit -m'
alias gd='git diff'
alias gl='git log --stat --relative-date'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gps='git push'
alias gst='git status'
alias gsw='git switch'
alias gsc='git switch --create'

# font-converter
alias woffy='font-converter ft2wf'

# freetube
alias ftweb='freetube https://www.youtube.com/playlist?list=PLWZ_T9JHHIpPh8jKzVVHvVChrbYfVwEKe'
alias ftlinux='freetube https://youtube.com/playlist?list=PLWZ_T9JHHIpPPdH0haqui_81AEPNB_3rE'
alias ftcli='freetube https://youtube.com/playlist?list=PLWZ_T9JHHIpNzApoYVuLgtzLraADY7Zh9&si=es_gasLr7cruR-YB'

# more shortcuts
alias md='glow'
alias fd='fdfind'
alias tldr='tldr -p linux'

# 'cat' with syntax-highlighting
alias bat='batcat'

# show $PATH (replace ':' with new line)
alias path='printf "%b\n" "${PATH//:/\\n}"'

# show my public ip address
alias whatsmyip='curl http://icanhazip.com'

alias new-py='source new-py'
alias stylebot='xclip -sel clip  $HOME/dev/snippets/stylebot/stylebot.css'
alias tree='tree --dirsfirst'

# fd
alias fdignore='vim ~/.config/fd/ignore'
alias gitignore='vim ~/.config/git/ignore'
