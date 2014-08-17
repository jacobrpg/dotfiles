function git_prompt_custom() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "on $(parse_git_dirty)$(git_prompt_info)"
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '→'
}

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

PROMPT='
%{$fg[blue]%}%n%{$reset_color%} at %{$fg[cyan]%}%m%{$reset_color%} in $fg[yellow]${PWD/#$HOME/~}%{$reset_color%} $(git_prompt_custom)
$(virtualenv_info)%(?,,%{${fg_bold[white]}%}[%?]%{$reset_color%})→ '

PROMPT='
%{$fg[blue]%}%n%{$reset_color%} at %{$fg[cyan]%}%m%{$reset_color%} in $fg[yellow]${PWD/#$HOME/~}%{$reset_color%} $(git_prompt_custom)
$(prompt_char) '

ZSH_THEME_GIT_PROMPT_PREFIX="[git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="]$reset_color"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]"
