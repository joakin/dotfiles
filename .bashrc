
PS1BACKUP="\h:\W \u\$"

PATHCOLOR="\[\e[33m\]"
HOSTCOLOR="\[\e[34m\]"
PROMPTCOLOR="\[\e[37m\]"
GITCOLOR="\[\e[36m\]"
RESETCOLOR="\[\e[0;0m\]"

function load_git_prompt_shit
{
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM="auto"
  GIT_PS1_SHOWCOLORHINTS=true
  source ~/bin/git-prompt
}
# load_git_prompt_shit

function local_prompt
{
# $GITCOLOR$(__git_ps1 "(%s) ")$RESETCOLOR\

  PS1BASE="$PATHCOLOR\W$RESETCOLOR \
$PROMPTCOLOR\$$RESETCOLOR "

  PS1=$PS1BASE
}

function remote_prompt
{
  PS1="$HOSTCOLOR\u@\h $PS1"
}

local_prompt

