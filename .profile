# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ] && [ -r "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"

# npm: Resolving EACCES permissions errors when installing packages globally
# https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
[ -d "$HOME/.npm-global/bin" ] && PATH="$HOME/.npm-global/bin:$PATH"

composer="$HOME/.config/composer/vendor/bin"
[ -d "$composer" ] && PATH="$composer:$PATH"
