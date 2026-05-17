fpath=(~/.local/share/zsh/completions(N-/) $fpath)
# autoload -U compinit
# compinit

source ~/.zsh.d/zshrc
# alias tmux='tmux -2'
alias vi='vim'
alias grep='/bin/grep --color=auto --exclude-dir=.libs --exclude-dir=.deps --exclude-dir=.git --exclude-dir=.hg  --exclude-dir=.svn --exclude=\*.tmp --directories=recurse --binary-files=without-match'
alias fd='fdfind'
alias bat='batcat'
alias V='nvim'
alias P='less'

# alias emacs='env XMODIFIERS= GTK_IM_MODULE= emacs'
# alias oz='env XMODIFIERS= GTK_IM_MODULE= oz'

# if [ x"$TERM" = x"xterm" ]; then
#         export TERM=xterm-256color
# fi

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(/usr/bin/direnv hook zsh)"

# _cache_hosts=($_cache_hosts kanzashi-devonaws-step.pp-dev.org kanzashi-production-step.pp-dev.org relax-devonaws-step.pp-dev.org relax-production-step.pp-dev.org kirei-devonaws-step.pp-dev.org kirei-production-step.pp-dev.org partner-step-devonaws.pp-dev.org partner-step-production.pp-dev.org hair-devonaws-step.pp-dev.org)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/haruyama/lib/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/haruyama/lib/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/haruyama/lib/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/haruyama/lib/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<
# conda deactivate

export MAKEFLAGS="-j 20"

eval $(opam env)
# export PATH="/home/haruyama/.linuxbrew/opt/tmux@3.3/bin:$PATH"
export PATH="/usr/libexec/afdko:$PATH"

alias norg="gron --ungron"
alias ungron="gron --ungron"

path=(/usr/lib/ccache(N-/) $path)

path=(~/.local/venv/bin(N-/) $path)

export PATH="$ASDF_DATA_DIR/shims:$PATH"

export GOBIN=$GOPATH/bin

path=(~/.gem/ruby/3.3.0/bin(N-/) $path)

path=(~/.pack/bin(N-/) $path)

export WASMTIME_HOME="$HOME/.wasmtime"

export PATH="$WASMTIME_HOME/bin:$PATH"

export PATH="/opt/docker-desktop/bin:$PATH"

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

eval "$(uv generate-shell-completion zsh)"
