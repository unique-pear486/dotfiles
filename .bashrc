PYTHONSTARTUP=~/.pythonrc.py
export PYTHONSTARTUP

# So I can launch qaac or refalac with a single command:
alias qaac='wine ~/.wine/drive_c/qaac/qaac.exe'
alias refalac='wine ~/.wine/drive_c/qaac/refalac.exe'

# Turn off a few pesky warnings (well, actually all of them!):
export WINEDEBUG=-all
export PATH=$PATH:~/bin/
