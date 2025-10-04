fpath=(~/.local/share/zsh/completions(N-/) $fpath)

. $HOME/.asdf/asdf.sh
path=($HOME/.asdf/bin(N-/) $path)
path=($HOME/.asdf/shims(N-/) $path)

source ~/.zsh.d/zshrc
alias grep='/bin/grep --color=auto --exclude-dir=.libs --exclude-dir=.deps --exclude-dir=.git --exclude-dir=.hg  --exclude-dir=.svn --exclude=\*.tmp --directories=recurse --binary-files=without-match'
alias V='nvim'
alias P='less'

eval "$(/usr/bin/direnv hook zsh)"
