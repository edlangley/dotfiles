
######################
### Custom prompt  ###
#: 'hh:mm:ss'
#PS1_TIME="\e[0;33m\]\T\e[0m"
PS1_TIME="\[\033[01;33m\]\T\[\033[00m\]"
#: 'user@host:cwd [jobs]'
#PS1_INFO="\e[32m\]\u\e[90m\]@\e[35m\]\h\e[90m\]:\e[36m\[\w\e[0m\] [\j]"
PS1_INFO="\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;35m\]\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\] [\j]"

if [ "$(whoami)" == "root" ]; then
  PS1_PROMPT="# "
else
  PS1_PROMPT="$ "
fi
#: '$ '
#PS1_PROMPT="$ "
#: '$?'
PS1_FULL="${PS1_TIME} ${PS1_INFO}"
PS1_ERROR="\e[91m\$RET\e[0m"
PS1="${PS1_FULL}${PS1_PROMPT}"
PROMPT_COMMAND='RET=$?;if [ "$RET" != "0" ]; then PS1="${PS1_FULL} ${PS1_ERROR}\n${PS1_PROMPT}"; else PS1="${PS1_FULL}\n${PS1_PROMPT}"; fi; export PS1;'

export PS1_PROMPT
export PS1_FULL
export PS1_ERROR
export PS1
export PROMPT_COMMAND
### end custom prompt  ###
##########################


