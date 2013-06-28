source ~/.zsh.d/zshrc

source ~/.zsh.d/config/packages.zsh

#export DEBIAN_BUILDARCH=i686
alias emacs='env XMODIFIERS= GTK_IM_MODULE= emacs'

if [ x"$TERM" = x"xterm" ]; then
        export TERM=xterm-256color
fi

#alias nave="$HOME/work/nave/nave.sh use latest"
eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)

[ -s $HOME/.pythonz/etc/bashrc ] && source $HOME/.pythonz/etc/bashrc
