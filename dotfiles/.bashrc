#
# My bash startup
#
export PATH=$PATH:~/bin:~/Scripts:/usr/new/bin:/usr/texbin:/opt/local/bin:~/usr/local/bin:/usr/local/bin:~/Library/Python/2.7/bin

set USER = `id | sed "s/)/(/" | cut -d"(" -f2`
set MY_host = `hostname | sed s/\.csl\.sri\.com//`

# setup umask to something reasonable
umask 022

#set history=500 set savehist=500
set filec

#  Fixes man page formats
export LANG C

# Determine active Python virtualenv details (https://gist.github.com/miki725/9783474)
function set_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
      PYTHON_VIRTUALENV=
  else
      PYTHON_VIRTUALENV="[`basename \"$VIRTUAL_ENV\"`] "
  fi
}

export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
source /usr/local/bin/virtualenvwrapper.sh

set_virtualenv
export PS1="$PYTHON_VIRTUALENV[\u@\h - `pwd`]\n    [\#]: "

cd    () { builtin cd "$@" && chpwd; }
pushd () { builtin pushd "$@" && chpwd; }
popd  () { builtin popd "$@" && chpwd; }
chpwd () {
    set_virtualenv
    export _OLD_VIRTUAL_PS1="[\u@\h - `pwd`]\n    [\#]: " 
    export PS1="$PYTHON_VIRTUALENV[\u@\h - `pwd`]\n    [\#]: "
}


source $HOME/.alias

function frameworkpython {
    if [[ ! -z "$VIRTUAL_ENV" ]]; then
        PYTHONHOME=$VIRTUAL_ENV /usr/local/bin/python2.7 "$@"
    else
        /usr/local/bin/python2.7 "$@"
    fi
}

export -f frameworkpython
