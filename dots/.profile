# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# source .bashrc if running bash
if [ -n "$BASH_VERSION" ] && [ -r "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

set -- \
    ".local/bin" \
    "bin" \
    ".npm-global/bin" \
    ".appimages" \
    ".config/composer/vendor/bin"
    
for bin_path in "$@"; do
    if [ -d "$HOME/$bin_path" ]; then
        export PATH="$HOME/$bin_path:$PATH"
    fi
done

