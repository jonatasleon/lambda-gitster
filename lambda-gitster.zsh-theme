local ret_status="%(?:%{$fg_bold[green]%}λ :%{$fg_bold[red]%}λ %s)"

function get_pwd(){
  git_root=$PWD
  while [[ $git_root != / && ! -e $git_root/.git ]]; do
    git_root=$git_root:h
  done
  svn_root=$PWD
  while [[ $svn_root != / && ! -e $svn_root/.svn ]]; do
    svn_root=$svn_root:h
  done
  if [[ $git_root = / ]]; then
    if [[ $svn_root = / ]]; then
      unset svn_root
      prompt_short_dir=%~
    else
      parent=${svn_root%\/*}
      prompt_short_dir=${PWD#$parent/}
    fi
  else
    parent=${git_root%\/*}
    prompt_short_dir=${PWD#$parent/}
  fi
  echo $prompt_short_dir
}

PROMPT='$ret_status %{$fg[white]%}$(get_pwd) $(git_prompt_info)$(svn_prompt_info)%{$reset_color%}%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✓%{$reset_color%}"
ZSH_THEME_SVN_PROMPT_PREFIX="%{$fg[cyan]%}"
ZSH_THEME_SVN_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_SVN_PROMPT_CLEAN=" %{$fg[green]%}✓%{$reset_color%}"
ZSH_THEME_SVN_PROMPT_DIRTY=" %{$fg[yellow]%}✗%{$reset_color%}"
