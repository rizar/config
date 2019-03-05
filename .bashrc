# LISA
RIZAR_HOSTNAME=`hostname -d`
[ -z $RIZAR_HOSTNAME ] && RIZAR_HOSTNAME=unknown

if [ $RIZAR_HOSTNAME = iro.umontreal.ca ];
then    
    umask 027
    export RIZAR_CONF_VERSION=mila

    if [ -e "/opt/lisa/os_v5/.local.bashrc" ]; 
        then source /opt/lisa/os_v5/.local.bashrc;
    elif [ -e "/opt/lisa/os_v4/.local.bashrc" ];
        then source /opt/lisa/os_v4/.local.bashrc;
    fi
elif [ $RIZAR_HOSTNAME = helios ];
then
    export RIZAR_CONF_VERSION=helios

    # Source global definitions
    if [ -f /etc/bashrc ]; then
        . /etc/bashrc
    fi

    # CLUMEQ
    for i in /clumeq/etc/profile.d/*.sh ; 
    do
        if [ -r "$i" ]; 
        then
            . $i
        fi
    done

    # MILA definitions
    if [ -f /rap/jvb-000-aa/stack/.bashrc ]; then
        . /rap/jvb-000-aa/stack/.bashrc
    fi
else
    export RIZAR_CONF_VERSION=default
    #export BSTINPUTS=.:$HOME/LISA/svn_repos/trunk/articles/bst
    #export BIBINPUTS=.:$HOME/LISA/svn_repos/trunk/articles/bib
    [ -z $ZSH_VERSION ] && [ -e ~/.bashrc_ubuntu ] && . ~/.bashrc_ubuntu
fi

# Environment
export PATH="$HOME/scripts:"\
"$HOME/bin:"\
"$HOME/.local/bin:"\
$PATH
export CPATH="$HOME/.local/include:$CPATH"
export LIBRARY_PATH="$HOME/.local/lib:$LIBRARY_PATH:/usr/local/lib"
export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH:/usr/local/lib"
export SVN_EDITOR=vim
export TMP=/data/milatmp1/bahdanau
unset FUEL_DATA_PATH
export YA=rizar@asr-dev03h.dev.voicetech.yandex.net
export YA2=rizar@cuda-sge09h.dev.voicetech.yandex.net

# Aliases and functions
. ~/.zsh_aliases
