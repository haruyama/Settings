fpath=(~/.local/share/zsh/completions(N-/) $fpath)

. $HOME/.asdf/asdf.sh

source ~/.zsh.d/zshrc
alias tmux='/usr/bin/tmux -2'
alias grep='/bin/grep --color=auto --exclude-dir=.libs --exclude-dir=.deps --exclude-dir=.git --exclude-dir=.hg  --exclude-dir=.svn --exclude=\*.tmp --directories=recurse --binary-files=without-match'

# alias emacs='env XMODIFIERS= GTK_IM_MODULE= emacs'
# alias oz='env XMODIFIERS= GTK_IM_MODULE= oz'

# if [ x"$TERM" = x"xterm" ]; then
#         export TERM=xterm-256color
# fi

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(/usr/bin/direnv hook zsh)"

_cache_hosts=($_cache_hosts kanzashi-devonaws-step.pp-dev.org kanzashi-production-step.pp-dev.org relax-devonaws-step.pp-dev.org relax-production-step.pp-dev.org kirei-devonaws-step.pp-dev.org kirei-production-step.pp-dev.org)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/haruyama/lib/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/haruyama/lib/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/haruyama/lib/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/haruyama/lib/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
conda deactivate
