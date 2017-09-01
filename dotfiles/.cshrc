#
# this file gets executed by every shell you start
#

set path=(. /usr/local/bin /Applications/Emacs.app/Contents/MacOS ~/bin ~/Scripts /usr/new/bin /usr/texbin /opt/local/bin ~/usr/local/bin /usr/local/bin /usr/local/Homebrew/bin $path)

set USER = `id | sed "s/)/(/" | cut -d"(" -f2`
set MY_host = `hostname | sed s/\.csl\.sri\.com//`

# setup umask to something reasonable
umask 022

#set history=500 set savehist=500
set filec

#  11/5/2002  to fix man page formats
setenv LANG C

# make the prompt palatable
if( ${?prompt} ) then
    set host     = `hostname`
    set history  = 500
    set savehist = 500
    set editmode = emacs
    
    if( ! $?title ) set title=""

    # Cleanup kludge for virtualenv prompt
    set VE = ""
    alias setprompt 'set prompt="$VE [`whoami`@$MY_host - `pwd`]\n   [%h]: "'          
    setprompt # to set the initial prompt 
    
    alias cd    'set VE="`~/bin/getVirtualEnv.csh`"; chdir \!* && setprompt;' 
    alias pushd 'pushd \!* && set VE="`~/bin/getVirtualEnv.csh`" && setprompt'
    alias popd 'popd \!* && set VE="`~/bin/getVirtualEnv.csh`" && setprompt'
    
#    alias pushd 'set VE="`~/bin/getVirtualEnv.csh`"; pushd \!* && setprompt;'   
#    alias pushd 'pushd \!* && setprompt'
#    alias popd  'popd \!* && setprompt'
    
# set ls colors
setenv LSCOLORS "ExfxcxdxCxegedabagacad"

# Erase Command
stty erase '^?' 
stty kill '^]' 
stty intr '^C' echoe -parenb cs8

endif

# This is is needed to set terminal type.
alias ts 'set noglob; eval `tset -sQ \!*`; unset noglob; set term=$TERM'


# Try the automatic correction facility in tcsh:
set correct=all

#Matlab Path
#setenv MATLABPATH "~/Documents/MATLAB"

# Grackle Path
set path=(~/Grackle/grackle-1.0.0/bin $path)

# Source Aliases
source $HOME/.alias

# VirtualEnvWrapper (installed as pip install --user virtuenvwraper, which is different from how I installed virtualenv)
#setenv VIRTUALENVWRAPPER_PYTHON "/usr/local/bin/python"
#setenv VIRTUALENVWRAPPER_VIRTUALENV "/usr/local/bin/virtualenv"
#source /Users/jleffell/Library/Python/2.7/bin/virtualenvwrapper.sh

ulimit -c unlimited
set filec
set autolist

