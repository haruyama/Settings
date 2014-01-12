update:
	.vim/bundle/neobundle.vim/bin/neoinstall
	git submodule update --init --recursive

init:
	make -f .vim/Makefile
	.vim/bundle/neobundle.vim/bin/neoinstall
	git submodule update --init --recursive
