update:
	vim -N -u ~/.vimrc -c "try | call dein#update() | finally | qall! | endtry" -U NONE -i NONE -V1 -e -s || echo ''
	git submodule update --init --recursive

init:
	ln -fs ~/lib/Settings/.[A-Z0-9a-z]* ~/
	rm ~/.git
	mkdir -p ~/bin
	ln -fs ~/lib/Settings/bin/* ~/bin/
	[ -e ~/.ssh ] || mkdir -m=700 ~/.ssh
	touch ~/.ssh/config
	cp ~/lib/Settings/sample/.zshenv ~
	cp ~/lib/Settings/sample/.zshrc ~
	[ -d ~/.fzf ] || git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install --bin --key-bindings --completion
	git submodule update --init --recursive
