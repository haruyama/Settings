update: fzf_install
	vim -N -u ~/.vimrc -c "try | call dein#update() | finally | qall! | endtry" -U NONE -i NONE -V1 -e -s || echo ''

fzf_install:
	[ -d ~/.fzf ] || git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	cd ~/.fzf && git pull && ./install --all

init: fzf_install
	ln -fs ~/lib/Settings/.[A-Z0-9a-z]* ~/
	rm ~/.git
	mkdir -p ~/bin
	ln -fs ~/lib/Settings/bin/* ~/bin/
	[ -e ~/.ssh ] || mkdir -m=700 ~/.ssh
	touch ~/.ssh/config
	chmod 600 ~/.ssh/config
	cp ~/lib/Settings/sample/.zshenv ~
	cp ~/lib/Settings/sample/.zshrc ~
	mkdir -p ~/.config/nvim
	ln -fs ~/.vimrc ~/.config/nvim/init.vim

neovim:
	pip3 install neovim

gtk3:
	gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"

js_install: textlint_install js_dev_install js_misc_install

js_dev_install:
	npm install -g jshint jslint eslint eslint_d coffeelint npm-check-updates fixpack license-checker eslint-plugin-react tern nsp tslint typescript

js_misc_install:
	npm install -g honyaku

textlint_install:
	npm install -g textlint textlint-rule-max-ten textlint-rule-spellcheck-tech-word textlint-rule-no-mix-dearu-desumasu  textlint-rule-preset-jtf-style textlint-rule-prh

nodebrew:
	wget git.io/nodebrew
	perl nodebrew setup
	rm nodebrew

tmux:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
