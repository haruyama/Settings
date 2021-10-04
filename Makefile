ASDF_VIM_CONFIG="--with-tlib=ncurses --with-compiledby=asdf --enable-multibyte --enable-cscope --enable-terminal --enable-perlinterp --enable-rubyinterp --enable-python3interp --enable-luainterp --enable-gui=gtk3"

update: asdf_update asdf_install # fzf_install
	vim -N -u ~/.vimrc -c "try | call dein#update() | finally | qall! | endtry" -U NONE -i NONE -V1 -e -s || echo ''

fzf_install:
	[ -d ~/.fzf ] || git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	cd ~/.fzf && git pull && ./install --all

init: asdf git
	ln -fs ~/lib/Settings/.[A-Z0-9a-z]* ~/
	rm ~/.git ~/.gitignore
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

git:
	mkdir -p ~/.config/git
	ln -fs ~/lib/Settings/_config/git/* ~/.config/git/

neovim: js_neovim_install
	pip3 install pynvim msgpack
	gem install --user neovim

gtk3:
	gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"

js_install: textlint_install js_dev_install js_misc_install js_neovim_install

js_dev_install:
	npm install -g jshint jslint eslint eslint_d coffeelint npm-check-updates fixpack license-checker eslint-plugin-react tern nsp typescript @typescript-eslint/eslint-plugin @typescript-eslint/parser prettier eslint-config-prettier eslint-plugin-prettier tree-sitter-cli

js_neovim_install:
	npm install -g neovim

js_misc_install:
	npm install -g honyaku

textlint_install:
	npm install -g textlint textlint-rule-max-ten textlint-rule-spellcheck-tech-word textlint-rule-no-mix-dearu-desumasu  textlint-rule-preset-jtf-style textlint-rule-prh

tmux:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

lsp_install:
	go install golang.org/x/tools/gopls@latest
	npm i -g vue-language-server javascript-typescript-langserver purescript-language-server typescript-language-server
	pip3 install python-language-server pyls-black cmake-language-server

asdf:
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf
	cd ~/.asdf && git checkout "`git describe --abbrev=0 --tags`"


asdf_plugin:
	asdf plugin add vim
	asdf plugin add neovim
	asdf plugin add deno https://github.com/asdf-community/asdf-deno.git
	asdf plugin add nim https://github.com/asdf-community/asdf-nim
	asdf plugin add hadolint https://github.com/looztra/asdf-hadolint
	asdf plugin add golang https://github.com/kennyp/asdf-golang.git
	asdf plugin add gohugo
	asdf plugin add fzf https://github.com/kompiro/asdf-fzf.git
	asdf plugin add nodejs
	bash -c ~/.asdf/plugins/nodejs/bin/import-release-team-keyring


asdf_install:
	asdf install fzf latest && asdf global fzf "`asdf latest fzf`"
	asdf install nodejs latest && asdf global nodejs latest
	asdf install golang latest && asdf global golang "`asdf latest golang`"
	asdf install gohugo latest && asdf global gohugo "`asdf latest gohugo`"
	asdf install nim latest && asdf global nim "`asdf latest nim`"
	asdf install deno latest && asdf global deno "`asdf latest deno`"
	asdf install neovim nightly && asdf global neovim nightly
	env ASDF_VIM_CONFIG=${ASDF_VIM_CONFIG} asdf install vim latest && asdf global vim "`asdf latest vim`"

asdf_update:
	asdf update
	asdf plugin update --all

SKKDIC_DIR=/usr/share/skk
MY_SKKDIC=~/.local/share/skk/SKK-JISYO.my
TMP_EUC_SKKDIC=/tmp/SKK-JISYO.euc-jisx0213
TMP_UTF8_SKKDIC=/tmp/SKK-JISYO.utf8
TMP_JAWII_SKKDIC=/tmp/SKK-JISYO.jawiki
# original: https://github.com/eidera/skktools/blob/47de7074952e3374d21b33a02319ceb1cdc986dc/scripts/run.bash
skkdic:
	skkdic-expr2 \
		${SKKDIC_DIR}/SKK-JISYO.L + \
		${SKKDIC_DIR}/SKK-JISYO.geo + \
		${SKKDIC_DIR}/SKK-JISYO.jinmei + \
		${SKKDIC_DIR}/SKK-JISYO.propernoun + \
		${SKKDIC_DIR}/SKK-JISYO.station + \
		> ${TMP_EUC_SKKDIC}

	iconv -f euc-jisx0213 -t utf8 ${TMP_EUC_SKKDIC} > ${TMP_UTF8_SKKDIC}
	curl https://raw.githubusercontent.com/tokuhirom/jawiki-kana-kanji-dict/master/SKK-JISYO.jawiki -o ${TMP_JAWII_SKKDIC}
	mkdir -p ~/.local/share/skk
	rm -f ${MY_SKKDIC}
	echo ';; -*- coding: utf-8 -*-'  > ${MY_SKKDIC}
	skkdic-expr2 ${TMP_UTF8_SKKDIC} ${TMP_JAWII_SKKDIC} >> ${MY_SKKDIC}
	rm ${TMP_EUC_SKKDIC} ${TMP_UTF8_SKKDIC} ${TMP_JAWII_SKKDIC}
