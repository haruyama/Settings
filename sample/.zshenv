source ~/.zsh.d/zshenv

ulimit -n 513828

# export JAVA_HOME=/usr/lib/jvm/java-9-openjdk-amd64/

# path=($HOME/.nodebrew/current/bin(N-/) $path)

# export SCALA_HOME=~/.svm/current/rt
# path=($SCALA_HOME/bin(N-/) $path)

export GOPATH=$HOME/lib/Go
path=($GOPATH/bin(N-/) $path)

# path=($HOME/.rbenv/shims(N-/) $HOME/.rbenv/bin(N-/) $path)
# eval "$(rbenv init -)"
path=(~/.gem/ruby/3.0.0/bin(N-/) $path)

path=(~/.local/share/coursier/bin(N-/) $path)

# path=($HOME/src/Nim/nim/bin(N-/) $path)
# path=($HOME/.nimble/bin(N-/) $path)

# export VAGRANT_HOME=~/.vagrant.d
# export VAGRANT_DEFAULT_PROVIDER=libvirt

# path=($HOME/.cargo/bin(N-/) $path)
# export RUST_SRC_PATH=$HOME/src/Rust/rust/src

# export MAKEFLAGS="-j 20"

source $HOME/.cargo/env
path=($HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/ $path)

export QT_QPA_PLATFORMTHEME="qt5ct"
export RUNEWIDTH_EASTASIAN=1

export ASDF_DATA_DIR=/home/haruyama/.asdf

# eval "$(~/.linuxbrew/bin/brew shellenv)"
#
# source "$HOME/.rye/env"
