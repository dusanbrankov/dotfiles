# shellcheck shell=bash

cd() {
    builtin cd "$@" >/dev/null || return 1
}

mkcd() {
    mkdir -p "$1" && builtin cd "$1" || return 1
}

# create direcotires and files in one command
# info: the dirname command in Linux prints a file path with its final component
# removed. this basically gives you the directory path from the file path.
mkf() {
    # mkdir -p "${1%/*}" && touch "$@"

    for f in "$@"; do
        [[ $f =~ / ]] && mkdir -p "${f%/*}"
    done

    touch "$@"
}

mkcp() {
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

# ls -l with displaying number of hidden files
ll() {
    local current_dir=${1:-.}
    local dotfiles=("${current_dir%/}"/.[!.]*)

    if [ -e "${dotfiles[0]}" ]; then
        echo "$(tput bold)hidden files: ${#dotfiles[@]}$(tput sgr0)"
    fi

    ls -hls "$@"
}

# list hidden files and directories
ld() {
    # ls -dl .[!.]* 2>/dev/null
    ls -al "${1:-.}" | awk '$NF ~ /^\.[^\.\/]/ {print}'
}

# list only hidden files
ldf() {
    # ls -pdl .[!.]* | grep -v '/$' 2>/dev/null
    ls -al "${1:-.}" | awk '$1 !~ /^d/ && $NF ~ /^\.[^\.\/]/ {print}'
}

# list only hidden directories
ldd() {
    # ls -dl .[!.]*/ 2>/dev/null
    ls -al "${1:-.}" | awk '$1 ~ /^d/ && $NF ~ /^\.[^\.\/]/ {print}'
}

cheat() {
    curl "https://cheat.sh/$1"
}

showcolors() {
    local num="${1:-255}"

    for code in $(seq "$num"); do
       echo "$code: $(tput setaf "$code";)\
             The quick brown fox jumped over the lazy dog.\
             $(tput sgr0)"
    done
}

# Go to recent project
gtp() {
    local path
    path="$HOME/dev/projects/web"

    local project
    project="$(find "$path" -mindepth 1 -maxdepth 1 -type d \
               -printf "%TY-%Tm-%Td\t%f\n" | \
               sort -r | cut -f "2" | head -n1)"

    cd "$path/$project" || return 1
}

# rename tab in terminal
set-title() {
    if [[ -z "$ORIG" ]]; then
        ORIG=$PS1
    fi

    TITLE="\[\e]2;$*\a\]"
    PS1=${ORIG}${TITLE}
}

# create file (and directories) and open file in vs code
copen() {
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
img-convert() {
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

local-backup() {
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
cd_fzf() {
    local fd_options=(
        --type directory
        --hidden
        --absolute-path
        --base-directory "$HOME"
    )

    local fzf_options=(
        --exact
        --preview='tree -L 1 {}'
        --bind=ctrl-space:toggle-preview
    )

    cd "$(fd "${fd_options[@]}" | fzf "${fzf_options[@]}")" || return 1
}

# cc - cd with fuzzy finder
# Usage: cc [path]
#
# Examples:
#     Use current directory as starting point:
#         $ cc
#     Use another directory as starting point:
#         $ cc ~/Downloads
cc() {
    local fd_options fzf_options target

    fd_options=(
        --hidden
    )

    fzf_options=(
        --exact
        --preview='tree -L 1 {}'
        --bind=ctrl-space:toggle-preview
        --exit-0
    )

    target="$(fd . "${1:-.}" "${fd_options[@]}" | fzf "${fzf_options[@]}")"

    test -f "$target" && target="${target%/*}"

    cd "$target" || return 1
}

# Open document with fuzzy finder ($HOME as starting point)
# Usage: <ctrl-o>
open_fzf() {
    local target
    target="$(fzf --exact --select-1 --exit-0)"
    test -n "$target" && "${EDITOR:-vim}" "$target"
}

# Open document with fuzzy finder (cwd as starting point)
# Usage: <ctrl-p>
open_fzf_cwd() {
    local target
    target="$(fd --strip-cwd-prefix | fzf --exact --select-1 --exit-0)"
    test -n "$target" && "${EDITOR:-vim}" "$target"
}

# sample usage: calc '(2 + 3) / 2'
calc() {
    awk "BEGIN {print \"result: \" $* }";
}

# create bash script and open it in default editor
# usage: mkbash <script name>
mkbash() {
    touch "$1"
    chmod 744 "$1"
    printf '#!/usr/bin/env bash\n\n' >"$1"
    "${EDITOR:-vim}" "$1"
}

# git add and commit in one go
# usage: gitac <file1> <file2>... 'commit message'
gitac() {
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
mkphp() {
    if (( $# == 0 )); then
        echo 'Missing argument' >&2
        return 1
    fi

    local project="$1"
    local editor="${2:-code}"
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

mkphpdir() {
    local path=/var/www/html/"$1"
    sudo mkdir "$path" || return 1
    sudo chown "$USER": "$path"
    cd "$path" || return 1
}

chwebroot() {
    local config_file='/etc/apache2/sites-available/000-default.conf'

    sudo sed -iE 's:DocumentRoot /var/www/html.*:DocumentRoot /var/www/html/'"${1:-}"':' "$config_file"

    sudo systemctl restart apache2
}

rsd() {
    local cur
    cur="$(units EUR RSD | grep -Eo '[0-9]{3}\.[0-9]{2}')"
    echo "1.00 EUR = $cur RSD"
}

shwebroot() {
    local config_file='/etc/apache2/sites-available/000-default.conf'
    grep -Eo 'DocumentRoot\s+(\w|-|/)+' "$config_file" \
        | cut --delimiter=' ' --fields=2
}

# Create a Github repo
# Usage: gh-repo-create <repo_name>
# Doc: https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#create-a-repository-for-the-authenticated-user
gh-repo-create() {
    read -rp 'Name: ' repo_name
    read -rp 'Description: ' repo_desc
    read -rp 'Private (true/false): ' repo_is_private

    curl -L \
         -X POST \
         -H "Accept: application/vnd.github+json" \
         -H "Authorization: Bearer $GH_TOKEN" \
         -H "X-GitHub-Api-Version: 2022-11-28" \
         https://api.github.com/user/repos \
         -d "{\"name\":\"$repo_name\",\"description\":\"$repo_desc\",\"homepage\":\"https://github.com\",\"private\":$repo_is_private,\"is_template\":false}"
}

# Delete a Github repository
# Usage: gh-repo-del <repo-name>
gh-repo-del() {
    curl -L \
         -X DELETE \
         -H "Accept: application/vnd.github+json" \
         -H "Authorization: Bearer $GH_TOKEN" \
         -H "X-GitHub-Api-Version: 2022-11-28" \
         https://api.github.com/repos/dusanbrankov/"$1"
}

# This is equivalent to 'git mv file_from file_to'
# Usage: command <current-filemame> <old-filename>
git-update-filename() {
    # mv README.md README
    git rm "$2"
    git add "$1"
}

# Append file(s) to the last commit
# Usage: command <file>...
git-append() {
    git add "$@"
    git commit --amend

    up_to_date="$(git fetch)"

    if [ -z "$up_to_date" ]; then
        git push --force
    fi
}

penv() {
    printenv | fzf
}
