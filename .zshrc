# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bira"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
#

# Environment
export BASH_ENV='~/.bashrc'
export PATH="$PATH:"\
'/home/rizar/scripts:'\
'/home/rizar/.local/bin:'\
'/home/rizar/bin'
export SVN_EDITOR=vim
export PRJ=/home/rizar/Jacobs/Robotics/Project
export RGBD=/home/rizar/Jacobs/Robotics/TUM/rgbd_dataset_freiburg1_360

export DISABLE_AUTO_TITLE=true
export DIRSTACKSIZE=8

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

# Advanced history completion
autoload -Uz history-beginning-search-menu
zle -N history-beginning-search-menu
bindkey '^X^X' history-beginning-search-menu

# Disable correction
setopt nocorrectall
