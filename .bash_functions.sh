# shellcheck shell=bash


function cd
{
    builtin cd "$@" >/dev/null || return 1
}


function mkcd
{
    mkdir -p "$1" && builtin cd "$1" || return 1
}


# create direcotires and files in one command
# info: the dirname command in Linux prints a file path with its final component
# removed. this basically gives you the directory path from the file path.
function mkf
{
    # mkdir -p "${1%/*}" && touch "$@"

    for f in "$@"; do
        [[ $f =~ / ]] && mkdir -p "${f%/*}"
    done

    touch "$@"
}

function mkcp
{
    local args args_last_index last_arg dest new_filename
    args=("$@")
    args_last_index=$(("${#args[@]}" - 1 ))
    last_arg="${args[-1]}"
    dest="${last_arg%/*}"
    new_filename="${last_arg##*/}"

    mkdir -p "$dest"

    for i in "${!args[@]}"; do
        (( i == args_last_index )) && break
        cp "${args[$i]}" "$dest/${new_filename}" || return 1
    done
}

# ls -l with info about number of hidden files
function ll
{
    local current_dir=${1:-.}
    local dotfiles=("${current_dir%/}"/.[!.]*)

    if [ -e "${dotfiles[0]}" ]; then
        echo "$(tput bold)hidden files: ${#dotfiles[@]}$(tput sgr0)"
    fi

    ls -hls "$@"
}


# list hidden files and directories
function ld
{
    ls -dl .[!.]* 2>/dev/null
}


# list only hidden files
function ldf
{
    ls -pdl .[!.]* | grep -v '/$' 2>/dev/null
}


# list only hidden directories
function ldd
{
    ls -dl .[!.]*/ 2>/dev/null
}


function cheat
{
    curl https://cheat.sh/"$1"
}


function showcolors
{
    for code in {1..255}; do
        echo "$code: $(tput setaf "$code";)\
              The quick brown fox jumped over the lazy dog.\
              $(tput sgr0)"
    done
}


# Go to recent project
function gtp
{
    local path
    path="$HOME/dev/projects/web"

    local project
    project="$(find "$path" -mindepth 1 -maxdepth 1 -type d \
               -printf "%TY-%Tm-%Td\t%f\n" \
               | sort -r | cut -f "2" | head -n1)"

    cd "$path/$project" || return 1
}


# rename tab in terminal
function set-title
{
    if [[ -z "$ORIG" ]]; then
        ORIG=$PS1
    fi

    TITLE="\[\e]2;$*\a\]"
    PS1=${ORIG}${TITLE}
}


# create file (and directories) and open file in vs code
function copen
{
    if [[ -e $1 ]]; then
        echo "File already exists" >&2
        return 1
    fi

    [[ $1 == */* ]] && mkdir -p "${1%/*}"
    # mkdir -p "$(dirname "$1")"

    touch "$1"

    [[ $1 == *.php ]] && echo '<?php' > "$1"

    code -r "$1"
}


# -----------------------------------------------
# Compress and convert images to WebP and AVIF.
#
# Arguments:
# target directory, resize width
#
# Usage:
# img_convert DEST [<resize-width>]
# -----------------------------------------------
function img-convert
{
    local dir="$1"
    local orig_dir="original_images"

    for i in "${dir:-.}"/*.{jpg,jpeg,png}; do

        local path="${i%/*}"
        local file="${i##*/}"
        local base="${file%%.*}"
        local ext="${file#*.}"

        if [[ ! "${file}" =~ \* ]]; then

            mkdir -p "${orig_dir}"
            cp -i "${i}" "${orig_dir}" || return

            convert "${i}" -sampling-factor 4:2:0 \
                           -strip -quality 70 \
                           -interlace Plane \
                           -colorspace RGB \
                           "${i}"
            convert "${i}" "${path}/${base}.webp"
            convert "${i}" "${path}/${base}.avif"

            if [[ -n "$2"  ]]; then
                    convert "${i}" -colorspace RGB \
                                   -resize "${2}" \
                                   -colorspace sRGB \
                                   "${path}/${base}-${2}.${ext}"
            fi
        fi
    done
}


function local-backup
{
    local path
    path='/media/dbran/HardDisk27491/backup'

    local date
    date="$(date +"%Y_%m_%d")"

    if [ ! -d "$path" ]; then
        echo "Path doesn't exist: '$path'" >&2
        return 1
    fi

    sudo rsync -av --delete \
        --exclude={'Downloads','Music','Pictures','Videos','Steam','.steam'} \
        "$HOME" /media/dbran/HardDisk27491/backup \
        2> >(tee "$HOME/Documents/backups/my_backup/backup_error_$date.log")
}


# cd with fuzzy finder
# Usage: <ctrl-f>
function cd_fzf
{
    cd "$(fd -td --hidden --absolute-path --base-directory "$HOME" \
        | fzf --exact \
        --preview="tree -L 1 {}" \
        --bind="space:toggle-preview" \
        --preview-window=:hidden)" || return 1
}


# cd with fuzzy finder (cwd as startig point)
# Usage: <ctrl-g>
function cd_fzf_cwd
{
    cd "$(fd -td --hidden --absolute-path --strip-cwd-prefix \
        | fzf --exact \
        --preview="tree -L 1 {}" \
        --bind="space:toggle-preview" \
        --preview-window=:hidden)" || return 1
}


# open document with fuzzy finder
# Usage: <ctrl-o>
function open_fzf
{
    $EDITOR "$(fd -tf --hidden --ignore --absolute-path --base-directory "$HOME" \
        | fzf --exact \
        --preview="cat {}" \
        --bind="space:toggle-preview" \
        --preview-window=:hidden)"
}


# open document with fuzzy finder (cwd as starting point)
# Usage: <ctrl-p>
function open_fzf_cwd
{
    $EDITOR "$(fd -tf --hidden --ignore --strip-cwd-prefix \
        | fzf --exact \
        --preview="cat {}" \
        --bind="space:toggle-preview" \
        --preview-window=:hidden)"
}


# sample usage: calc '(2 + 3) / 2'
function calc
{
    awk "BEGIN {print \"The answer is: \" $* }";
}

# create bash script and open it in default editor
# usage: mkbash <script name>
function mkbash
{
    touch "$1"
    chmod 744 "$1"
    printf '#!/usr/bin/env bash\n\n' >"$1"
    "$EDITOR" "$1"
}

# git add and commit in one go
# usage: gitac <file1> <file2>... 'commit message'
function gitac
{
    local args args_num
    args=("$@")
    args_num=$(($# - 1))

    for ((i = 0; i < args_num; i++)); do

        if [ ! -f "${args[i]}" ]; then
            echo "${args[i]} does not exist" >&2
            return 1
        fi

        git add --verbose "${args[i]}"

    done

    git commit --message="${args[-1]}"
}

# create new php project
# usage: mkphp <project_name>
function mkphp
{
    if (( $# == 0 )); then
        echo 'Missing argument' >&2
        return 1
    fi

    local project="$1"
    local editor=${2:-code}
    local path="/var/www/html/$project"
    local skel="$HOME/dev/skel/web/php"
    local window
    window="$(xdotool getactivewindow)"

    sudo mkdir "$path" || return 1
    sudo chown "$USER":www-data "$path"
    sudo chmod g+s "$path"
    sudo chmod o-rwx "$path"
    cp -r "$skel"/* "$path"
    cd "$path" || return 1

    xdotool search 'Mozilla Firefox' \
            windowactivate --sync \
            key --clearmodifiers CTRL+t \
            type "http://localhost/$project"
    xdotool windowfocus --sync "$window"
    xdotool windowactivate --sync "$window"
    xdotool search 'Mozilla Firefox' \
            windowactivate --sync \
            key Return
    xdotool windowfocus --sync "$window"
    xdotool windowactivate --sync "$window"

    "$editor" "$path"
}

function mkphpdir
{
    local path=/var/www/html/"$1"
    sudo mkdir "$path" || return 1
    sudo chown "$USER": "$path"
    cd "$path" || return 1
}

function chwebroot
{
    local config_file='/etc/apache2/sites-available/000-default.conf'
    sudo sed -iE 's:DocumentRoot /var/www/html.*:DocumentRoot /var/www/html/'"${1:-}"':' "$config_file"
    sudo systemctl restart apache2
}
