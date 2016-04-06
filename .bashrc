# LISA
if [ `hostname -d` = iro.umontreal.ca ];
then    
    umask 027
    export RIZAR_CONF_VERSION=mila

    if [ -e "/opt/lisa/os_v5/.local.bashrc" ];
    then 
        source /opt/lisa/os_v5/.local.bashrc; 
    else 
        source /data/lisa/data/local_export/.local.bashrc; 
    fi
elif [ `hostname -d` = helios ];
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
    export BSTINPUTS=.:$HOME/LISA/svn_repos/trunk/articles/bst
    export BIBINPUTS=.:$HOME/LISA/svn_repos/trunk/articles/bib
fi

# Environment
export PATH='/home/rizar/scripts:'\
'/home/rizar/.local/bin:'\
'/home/rizar/bin:'\
$PATH
export LD_LIBRARY_PATH="/home/rizar/.local/lib:$LD_LIBRARY_PATH"
export SVN_EDITOR=vim
export TMP3=/data/lisatmp3/bahdanau
export TMP4=/data/lisatmp4/bahdanau
export PYTHONPATH="$HOME/.local/lib/python2.7/site-packages:$PYTHONPATH"
export YA=rizar@asr-dev03h.dev.voicetech.yandex.net
export YA2=rizar@cuda-sge09h.dev.voicetech.yandex.net

if [ `hostname` = 'rizar-Dell' ];
then
    # Set Hadoop-related environment variables
    export HADOOP_PREFIX=/usr/local/hadoop
    
    # # Set JAVA_HOME (we will also configure JAVA_HOME directly for Hadoop later on)
    export JAVA_HOME=/usr/lib/jvm/java-6-openjdk-amd64
    
    # # Some convenient aliases and functions for running Hadoop-related commands
    # unalias fs &> /dev/null
    # alias fs="hadoop fs"
    # unalias hls &> /dev/null
    # alias hls="fs -ls"
    
    # # If you have LZO compression enabled in your Hadoop cluster and
    # # compress job outputs with LZOP (not covered in this tutorial):
    # # Conveniently inspect an LZOP compressed file from the command
    # # line; run via:
     
    # # $ lzohead /hdfs/path/to/lzop/compressed/file.lzo
     
    # # Requires installed 'lzop' command.
    lzohead () {
        hadoop fs -cat $1 | lzop -dc | head -1000 | less
    }
    # Add Hadoop bin/ directory to PATH
    export PATH=$PATH:$HADOOP_HOME/bin
fi

# Aliases and functions
. ~/.zsh_aliases
