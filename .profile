# ======================================================================= #
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
#
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
# umask 022
#
# ======================================================================= #

# Load .bashrc if running bash
# ----------------------------------------------------------------------- #

if [ -n "$BASH_VERSION" ] && [ -r "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

# Add user's bin directories to PATH
# ----------------------------------------------------------------------- #

set -- ".local/bin" "bin" ".npm-global/bin" ".config/composer/vendor/bin"

for bin in "$@"; do
    [ -d "$HOME/$bin" ] && export PATH="$HOME/$bin:$PATH"
done

# bin_dirs=(
#     ".local/bin"
#     "bin"
#     ".npm-global/bin"
#     ".config/composer/vendor/bin"
# )
#
# for bin in "${bin_dirs[@]}"; do
#     [ -d "$HOME/$bin" ] && export PATH="$HOME/$bin:$PATH"
# done


# ======================================================================= #
#
# Additional info:
#
# [npm] Resolving EACCES permissions errors when installing
# packages globally
# More information: https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
#
# ======================================================================= #

