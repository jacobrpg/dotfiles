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





################################################################################
################################################################################

# /os/os_x/installs/install_xcode.sh

if ! xcode-select --print-path &> /dev/null; then

    # Prompt user to install the XCode Command Line Tools
    xcode-select --install &> /dev/null

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the XCode Command Line Tools are installed
    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done

    print_result $? 'Install XCode Command Line Tools'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Point the `xcode-select` developer directory to
    # the appropriate directory from within `Xcode.app`
    # https://github.com/alrra/dotfiles/issues/13

    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
    print_result $? 'Make "xcode-select" developer directory point to Xcode'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Prompt user to agree to the terms of the Xcode license
    # https://github.com/alrra/dotfiles/issues/10

    sudo xcodebuild -license
    print_result $? 'Agree with the XCode Command Line Tools licence'

fi

print_result $? 'XCode Command Line Tools'


################################################################################
################################################################################


# os/os_x/installs/install_homebrew.sh

if ! cmd_exists 'brew'; then
    printf "\n" | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &> /dev/null
    #  └─ simulate the ENTER keypress
fi

print_result $? 'Homebrew'

# http://meng6.net/pages/computing/installing_and_configuring/installing_and_configuring_command-line_utilities/

# The GNU Core Utilities (coreutils) contains "the basic file,
# shell and text manipulation utilities of the GNU operating system."
brew install coreutils


brew tap homebrew/dupes

# # The --default-names option will prevent Homebrew from prepending gs to the
# # newly installed commands, thus we could use these commands as default ones
# # over the ones shipped by OS X.
brew install binutils
brew install diffutils
brew install ed --with-default-names
# # GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils --with-default-names ## This will cause 'brew doctor' to issue warning: "Putting non-prefixed findutils in your path can cause python builds to fail."
# brew install findutils
brew install gawk
brew install gnu-indent --with-default-names
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-which --with-default-names
brew install gnutls
brew install grep --with-default-names
brew install gzip
brew install screen
brew install watch
brew install wdiff --with-gettext
# # Install wget with IRI support
brew install wget --with-iri
brew install gnupg
brew install gnupg2

# # Some command line tools already exist on OS X, but you may wanna a newer version:
brew install bash
brew link --overwrite bash
brew install gdb  # gdb requires further actions to make it work. See `brew info gdb`.
brew install guile
brew install gpatch
brew install m4
brew install make
brew install nano

# As a complementary set of packages, the following ones are not from GNU, but
# you can install and use a newer version instead of the version shipped by OS X:
brew install file-formula
brew install git
brew install less
brew install openssh
brew install rsync
brew install svn
brew install unzip
brew install vim --override-system-vi
brew install macvim --override-system-vim --custom-system-icons
brew link --overwrite macvim
brew linkapps macvim
brew install zsh


# It seems --with-default-names is not applicable to the coreutils package, so
# PATH="/usr/local/opt/gnu-coreutils/libexec/gnubin:$PATH"
# MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
# always need to be applied.


# Install Python:
brew install python
brew linkapps python
pip install --upgrade pip setuptools

brew install sqlite
brew install openssl
brew install node # This installs `npm` too using the recommended installation method
# brew install ruby-build
# brew isntall rbenv
brew install android-platform-tools

brew install youtube-dl
brew install castnow
# brew install postgresql

brew tap caskroom/versions

# Core casks
brew cask install --appdir="~/Applications" iterm2
brew cask install --appdir="~/Applications" java
brew cask install --appdir="~/Applications" keka

# daily
brew cask install --appdir="/Applications" android-file-transfer
brew cask install --appdir="/Applications" beardedspice
brew cask install --appdir="/Applications" dropbox
brew cask install --appdir="/Applications" google-drive
brew cask install --appdir="/Applications" rescuetime
brew cask install --appdir="/Applications" spectacle

# Development tool casks
# brew cask install --appdir="/Applications" android-studio
brew cask install --appdir="/Applications" atom
brew cask install --appdir="/Applications" pycharm
brew cask install --appdir="/Applications" virtualbox
# brew cask install --appdir="/Applications" vagrant

# Misc casks
brew cask install --appdir="/Applications" calibre
brew cask install --appdir="/Applications" google-chrome-beta
brew cask install --appdir="/Applications" firefox
brew cask install --appdir="/Applications" flux
brew cask install --appdir="/Applications" skype
brew cask install --appdir="/Applications" slack
brew cask install --appdir="/Applications" utorrent
brew cask install --appdir="/Applications" vlc


# Install developer friendly quick look plugins;
# see https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook


################################################################################
################################################################################


# os/os_x/installs/update_and_upgrade.sh

# System software update tool
# https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man8/softwareupdate.8.html

execute 'sudo softwareupdate --install --all' 'Update system software'
printf '\n'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if cmd_exists 'brew'; then
    execute 'brew update' 'brew (update)'
    execute 'brew upgrade --all' 'brew (upgrade)'
fi


################################################################################
################################################################################

# os/os_x/installs/cleanup.sh

# By default Homebrew does not uninstall older versions
# of formulas, so in order to remove them, `brew cleanup`
# needs to be used
#
# https://github.com/Homebrew/homebrew/blob/b311d1483fa434f6692ab8dddb0bfd876d01a668/share/doc/homebrew/FAQ.md#how-do-i-uninstall-old-versions-of-a-formula

if cmd_exists 'brew'; then

    execute 'brew cleanup' 'brew (cleanup)'
    execute 'brew cask cleanup' 'brew cask (cleanup)'

fi
# Remove outdated versions from the cellar.
brew cleanup


################################################################################
################################################################################

# os/install_npm_packages.sh

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare -r -a NPM_PACKAGES=(
    'yo'
    'maildev'
    'trash-cli'
    # 'jshint'
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Ensure the most recent version of `npm` is installed

execute 'npm install --global npm' 'npm (update)'
printf '\n'

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Install the `npm` packages

for i in ${NPM_PACKAGES[@]}; do
    execute "npm install --global $i" "$i"
done

npm install -g grunt-cli
npm install -g yo
npm install -g gulp
npm install -g bower

npm install -g generator-gulp-angular

npm install -g trash-cli
npm install -g maildev

################################################################################
################################################################################


# github.com/jamiew/git-friendly
# the `push` command which copies the github compare URL to my clipboard is heaven
bash < <( curl https://raw.github.com/jamiew/git-friendly/master/install.sh)

# Add alias rm=trash to your .zshrc/.bashrc to reduce typing & safely trash files: $ rm unicorn.png.


################################################################################
################################################################################

# https://github.com/donnemartin/dev-setup/blob/master/osx.sh

# Originally from https://mths.be/osx
# Also look: https://github.com/alrra/dotfiles/blob/master/os/os_x/preferences/main.sh

# Set computer name (as done via System Preferences → Sharing)
#sudo scutil --set ComputerName "0x6D746873"
#sudo scutil --set HostName "0x6D746873"
#sudo scutil --set LocalHostName "0x6D746873"
#sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "0x6D746873"


################################################################################
################################################################################

# os/update_content.sh

ask 'Please provide an email address (email): ' && printf '\n'
ssh-keygen -t rsa -b 4096 -C "$(get_answer)" -f "$1"
print_result $? 'Generate SSH keys'



################################################################################
################################################################################

# https://github.com/donnemartin/dev-setup/blob/master/pydata.sh

# Install virtual environments globally
pip install virtualenv
pip install virtualenvwrapper

# echo "# Source virtualenvwrapper, added by pydata.sh" >> $EXTRA_PATH
# echo "export WORKON_HOME=~/.virtualenvs" >> $EXTRA_PATH
# echo "source /usr/local/bin/virtualenvwrapper.sh" >> $EXTRA_PATH


################################################################################
################################################################################
