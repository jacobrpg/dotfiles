# Explicitly configured $PATH variable
PATH=/usr/local/git/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/local/bin:/opt/local/sbin:/usr/X11/bin

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="jacobparra"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git command-not-found pip django virtualenvwrapper node npm bower vagrant)

source $ZSH/oh-my-zsh.sh

# Shell Aliases
## Git Aliases
alias ga='git add'
alias gc='git commit'
alias gl='git pull'
alias gp='git push'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias grm='git rm $(git ls-files -d)'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"

# Shortcuts
alias d="cd ~/Dropbox"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias c="cd ~/Code"
alias g="git"
alias v="vim"
alias s="subl ."

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Simple Server with python 2.7
alias servethis='python -m SimpleHTTPServer'
# for python 3.x version:
#alias servethis='python -m http.server'

# Custom exports
## Set EDITOR to /usr/bin/vim if Vim is installed
if [ -f /usr/bin/vim ]; then
    export EDITOR=/usr/bin/vim
fi

# Solarized Theme for GNU ls command, uncomment if using Linux
eval `dircolors ~/.dircolors`

# Virtualenvwrapper, uncomment if installed
export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# Android SDK, uncomment if installed
#export PATH=${PATH}:~/android-sdk-linux/platform-tools
