source ~/.zsh.d/zshenv

if [ -f  $HOME/perl5/perlbrew/etc/bashrc ] ; then
        source $HOME/perl5/perlbrew/etc/bashrc
fi

# if [ -f $HOME/.pythonbrew/etc/bashrc ] ; then
#         source $HOME/.pythonbrew/etc/bashrc
#         #eval "`pip completion --zsh`"
# fi
#

[[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc
#export PATH=$HOME/.pythonz/pythons/CPython-3.2.3/bin:$PATH
export PATH=$HOME/.pythonz/pythons/CPython-2.7.3/bin:$PATH

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export SCALA_HOME=~/.svm/current/rt
export PATH=$SCALA_HOME/bin:$PATH

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/jre/

export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$HOME/.denv/bin:$PATH
eval "$(denv init -)"
