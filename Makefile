update:
	.vim/bundle/neobundle.vim/bin/neoinstall
	git submodule update --init --recursive

init:
	[ -d ~/.fzf ] || git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install --bin --key-bindings --completion
	make -f .vim/Makefile
	.vim/bundle/neobundle.vim/bin/neoinstall
	git submodule update --init --recursive
