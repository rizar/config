# LISA
umask 027
if [ `hostname -d` = iro.umontreal.ca ];
then    
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
fi

# Environment
# TODO: do not mess with CUDA_ROOT
export CUDA_ROOT='/usr/local/cuda'
export PATH='/home/rizar/scripts:'\
'/home/rizar/.local/bin:'\
'/home/rizar/bin:'\
$CUDA_ROOT:$PATH
export LD_LIBRARY_PATH="/home/rizar/.local/lib:$CUDA_ROOT/lib64:$LD_LIBRARY_PATH"
export SVN_EDITOR=vim
export PRJ=/home/rizar/Jacobs/Robotics/Project
export RGBD=/home/rizar/Jacobs/Robotics/TUM/rgbd_dataset_freiburg1_360
export GHOG=$HOME/Projects/groundhog
export TMP3=/data/lisatmp3/bahdanau
export TMP4=/data/lisatmp4/bahdanau
export SNT=$TMP3/sentence_models
export GOLD=/data/lisatmp/vanmerb/joint_paper_hs/dev
# TODO: should not be necessary
export PYTHONPATH="$HOME/.local/lib/python2.7/site-packages:$PYTHONPATH:$GHOG"
export OPENBLAS_NUM_THREADS=1
export BSTINPUTS=.:$HOME/LISA/svn_repos/trunk/articles/bst:
export BIBINPUTS=.:$HOME/LISA/svn_repos/trunk/articles/bib  

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
