update:
	vim -N -u ~/.vimrc -c "try | call dein#update() | finally | qall! | endtry" -U NONE -i NONE -V1 -e -s || echo ''
	git submodule update --init --recursive

init:
	[ -d ~/.fzf ] || git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install --bin --key-bindings --completion
	git submodule update --init --recursive
