PYTHONSTARTUP=~/.pythonrc.py
export PYTHONSTARTUP

# So I can launch qaac or refalac with a single command:
alias qaac='wine ~/.wine/drive_c/qaac/qaac.exe'
alias refalac='wine ~/.wine/drive_c/qaac/refalac.exe'

# Turn off a few pesky warnings (well, actually all of them!):
export WINEDEBUG=-all
export PATH=$PATH:~/bin/

# Load virtualenvwrapper for python
venvwrap="virtualenvwrapper.sh"
/usr/bin/which $venvwrap > /dev/null
if [ $? -eq 0 ]; then
    venvwrap=`/usr/bin/which $venvwrap`
    source $venvwrap
fi

# Set eternal bash history (https://stackoverflow.com/a/19533853)
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
