update: fzf_install
	vim -N -u ~/.vimrc -c "try | call dein#update() | finally | qall! | endtry" -U NONE -i NONE -V1 -e -s || echo ''
	git submodule update --init --recursive

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
	git submodule update --init --recursive

js_install: textlint_install js_linter_install

js_linter_install:
	npm install -g jshint jslint eslint eslint_d

textlint_install:
	npm install -g textlint textlint-rule-max-ten textlint-rule-spellcheck-tech-word textlint-rule-no-mix-dearu-desumasu  textlint-rule-preset-jtf-style textlint-rule-prh
