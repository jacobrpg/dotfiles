#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
############################

########## Variables

dir=~/.dotfiles                    # dotfiles directory

##########

function install_zsh {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone my oh-my-zsh repository from GitHub only if it isn't already present
    if [[ ! -d ~/.oh-my-zsh/ ]]; then
        wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh);
    fi
else
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
        sudo apt-get install zsh
        install_zsh
    # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
        echo "Please install zsh, then re-run this script!"
        exit
    fi
fi
}
install_zsh

echo "Downloading dircolors-solarized"
# https://github.com/seebi/dircolors-solarized
rm -f ~/.dircolors
wget --no-check-certificate https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark -O ~/.dircolors

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# Create symlinks from the homedir to any files in the ~/.dotfiles 
files="zshrc vimrc gitconfig gitignore vim oh-my-zsh/custom/jacobparra.zsh-theme"
for file in $files; do
    echo "Creating symlink to $file in home directory."
    if [ -e ~/.$file ]
    then
        rm ~/.$file
    fi
    ln -s $dir/$file ~/.$file
done
