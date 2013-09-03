#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
############################

########## Variables

dir=~/.dotfiles                    # dotfiles directory
excludes="makesymlinks.sh README.markdown oh-my-zsh sublime-text-3"    # list of files/folders to symlink in homedir

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
        chsh -s $(which zsh)
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

function install_sublime {
# Check platform
platform=$(uname);
# If the platform is Linux
if [[ $platform == 'Linux' ]]; then
    # Test to see if Sublime Text 3 is installed.  If it is:
    if [ -f /usr/bin/subl ]; then
	    echo "Creating symlink to $dir/sublime-text-3/Packages/User in ~/.config/sublime-text-3/Packages/User"
	    rm -rf ~/.config/sublime-text-3/Packages/User
	    ln -s $dir/sublime-text-3/Packages/User ~/.config/sublime-text-3/Packages/User
    else
        # If Sublime Text isn't installed, try an apt-get to install sublime and then recurse
        sudo add-apt-repository ppa:webupd8team/sublime-text-3
        sudo apt-get update
        sudo apt-get install sublime-text-installer
        install_sublime
    fi
# If the platform is OS X
elif [[ $platform == 'Darwin' ]]; then
    if [ -d "~/Library/Application Support/Sublime Text 3" ]; then
        echo "Creating symlink to $dir/sublime-text-3/Packages/User in ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User"
        rm -rf ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
        ln -s $dir/sublime-text-3/Packages/User ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
    else
        echo "Please install Sublime Text 3, then re-run this script!"
        exit
    fi
fi
}
install_sublime

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# Create symlinks from the homedir to any files in the ~/.dotfiles 
files=*
files="$files oh-my-zsh/custom/jacobrpg.zsh-theme"
for file in $files; do
    if [[ ! $excludes =~ $file ]]; then 
        echo "Creating symlink to $file in home directory."
        if [ -e ~/.$file ]
        then
            rm ~/.$file
        fi
        ln -s $dir/$file ~/.$file
    fi
done
