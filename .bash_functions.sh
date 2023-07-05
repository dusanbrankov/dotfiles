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
mkfile() {
    mkdir -p "$(dirname "$1")" && touch "$1"
}

cheat() {
    curl https://cheat.sh/"$1"
}

showcolors() {
    for code in {1..255}; do
	    echo "$code: $(tput setaf "$code";)\
              The quick brown fox jumped over the lazy dog.\
              $(tput sgr0)"
    done
}

# Go to recent project
gtp() {
    local path project
    path="$HOME/dev/projects/web"
    project="$(find "$path" -mindepth 1 -maxdepth 1 -type d -printf "%TY-%Tm-%Td\t%f\n" | sort -r | cut -f "2" | head -n1)"
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

# create file and open in vs code
copen() {
    # local path="${1%/*}"
    # mkdir -p "${path}"
    mkdir -p "$(dirname "$1")"
    touch "$1"
    code -r "$1"
}

# -----------------------------------------------
# Compress and convert images to WebP and AVIF.
# Arguments:
#   target directory, resize width
# Usage:
#   img_convert DEST [<resize-width>]
# -----------------------------------------------
img-convert() {
    local dir="$1"
    local orig_dir="original_images"

    for i in "${dir:-.}"/*.{jpg,jpeg,png}; do
        local path="${i%/*}"
        local file="${i##*/}"
        local base="${file%%.*}"
        local ext="${file#*.}"

        if [[ ! "${file}" =~ \*  ]]; then
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
    local path date
    path='/media/dbran/HardDisk27491/backup'
    date="$(date +"%Y_%m_%d")"

    if [ ! -d "$path" ]; then
        echo "Cannot find dest path: '$path'" >&2
        return 1
    fi

    sudo rsync -av --delete \
        --exclude={'Downloads','Music','Steam','Videos','.steam'} \
        "$HOME" /etc /usr/local /media/dbran/HardDisk27491/backup \
        2> >(tee "$HOME/Documents/backups/my_backup/backup_error_$date.log")
}

# fuzzy finder
# Usage: <ctrl-f>
cd_fzf() {
    cd "$HOME" || return 1
    cd "$(fd -td --hidden \
        | fzf \
        --exact \
        --preview="tree -L 1 {}" \
        --bind="space:toggle-preview" \
        --preview-window=:hidden)" || return 1
}

# list dot files and directories
ld() {
    ls -dl .[!.]* 2>/dev/null
}

# list only dot files
ldf() {
    ls -pdl .[!.]* | grep -v '/$' 2>/dev/null
}

# list only dot directories
ldd() {
    ls -dl .[!.]*/ 2>/dev/null
}

# sample usage: calc '(2 + 3) / 2'
calc() {
    awk "BEGIN {print \"The answer is: \" $* }";
}
