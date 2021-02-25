update: asdf_plugin_update asdf_install # fzf_install
	vim -N -u ~/.vimrc -c "try | call dein#update() | finally | qall! | endtry" -U NONE -i NONE -V1 -e -s || echo ''

fzf_install:
	[ -d ~/.fzf ] || git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	cd ~/.fzf && git pull && ./install --all

init: asdf
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
	ln -fs ~/.vim/after ~/.config/nvim/after

neovim: js_neovim_install
	pip3 install pynvim msgpack
	gem install --user neovim

gtk3:
	gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"

js_install: textlint_install js_dev_install js_misc_install js_neovim_install

js_dev_install:
	npm install -g jshint jslint eslint eslint_d coffeelint npm-check-updates fixpack license-checker eslint-plugin-react tern nsp typescript @typescript-eslint/eslint-plugin @typescript-eslint/parser prettier eslint-config-prettier eslint-plugin-prettier

js_neovim_install:
	npm install -g neovim

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

lsp_install:
	go install golang.org/x/tools/gopls@latest
	npm i -g vue-language-server javascript-typescript-langserver purescript-language-server
	pip3 install python-language-server pyls-black

asdf:
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf
	cd ~/.asdf && git checkout "`git describe --abbrev=0 --tags`"


asdf_plugin:
	asdf plugin add hadolint https://github.com/looztra/asdf-hadolint
	asdf plugin add golang https://github.com/kennyp/asdf-golang.git
	asdf plugin add gohugo
	asdf plugin add fzf https://github.com/kompiro/asdf-fzf.git
	asdf plugin add nodejs
	bash -c ~/.asdf/plugins/nodejs/bin/import-release-team-keyring


asdf_install:
	asdf install fzf latest && asdf global fzf "`asdf latest fzf`"
	asdf install nodejs latest && asdf global nodejs "`asdf latest nodejs`"
	asdf install golang latest && asdf global golang "`asdf latest golang`"
	asdf install gohugo latest && asdf global gohugo "`asdf latest gohugo`"

asdf_plugin_update:
	asdf plugin update --all
