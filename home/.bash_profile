shell="$(readlink -f /proc/$$/exe)"
bashrc="$HOME/.bashrc"

# load .bashrc if running bash
if [[ "${shell##*/}" == "bash" && -r "$bashrc" ]]; then
    source "$bashrc"
fi

# add user's bin directories to PATH
bin_paths=(
    ".local/bin"
    "bin"
    ".npm-global/bin"
    ".config/composer/vendor/bin"
)

for bin_path in "${bin_paths[@]}"; do
    if [ -d "$HOME/$bin_path" ]; then
        export PATH="$HOME/$bin_path:$PATH"
    fi
done

