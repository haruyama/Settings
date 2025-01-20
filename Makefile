ASDF_VIM_CONFIG="--with-tlib=ncurses --with-compiledby=asdf --enable-multibyte --enable-cscope --enable-terminal --enable-perlinterp --enable-rubyinterp --enable-python3interp --enable-luainterp --enable-gui=gtk3"

.PHONY: update init git neovim gtk3 tmux tool_update tool_instal go_tool_install lsp_update lsp_install asdf asdf_plugin asdf_install asdf_update skkdic jetpack test clean all ssh_init bin_init neovim_init

update: asdf_update asdf_install tool_update
#	vim -N -u ~/.vimrc -c "try | call dein#update() | finally | qall! | endtry" -U NONE -i NONE -V1 -e -s || echo ''

init: asdf git ssh_init bin_init neovim_init
	ln -fs ~/lib/Settings/.[A-Z0-9a-z]* ~/
	rm ~/.git ~/.gitignore
	cp ~/lib/Settings/sample/.zshenv ~
	cp ~/lib/Settings/sample/.zshrc ~

ssh_init:
	[ -e ~/.ssh ] || mkdir -m=700 ~/.ssh
	touch ~/.ssh/config
	chmod 600 ~/.ssh/config

bin_init:
	mkdir -p ~/bin
	ln -fs ~/lib/Settings/bin/* ~/bin/

neovim_init:
	mkdir -p ~/.config/nvim
	ln -fs ~/lib/Settings/_config/nvim/init.vim ~/.config/nvim/init.vim
	ln -fs ~/.vim/after ~/.config/nvim/after
	ln -fs ~/lib/Settings/_config/vsnip ~/.config/vsnip

git:
	mkdir -p ~/.config/git
	ln -fs ~/lib/Settings/_config/git/* ~/.config/git/
	git config --global commit.template ~/.config/git/message

neovim:
	gem install --user neovim

gtk3:
	gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"

# tmux:
# 	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

tool_update: lsp_update go_tool_install

tool_install: lsp_install go_tool_install
	pipx install flake8

go_tool_install:
	go install golang.org/x/tools/cmd/goimports@latest
	go install golang.org/x/tools/gopls@latest
	curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b ${GOPATH}/bin latest
	go install github.com/rhysd/actionlint/cmd/actionlint@latest
	go install github.com/go-task/task/v3/cmd/task@latest

lsp_update:
	pipx upgrade-all
	npm update -g intelephense javascript-typescript-langserver typescript-language-server

lsp_install:
	pipx install pyright
	pipx install cmake-language-server

asdf:
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf
	cd ~/.asdf && git checkout "`git describe --abbrev=0 --tags`"

asdf_plugin:
	asdf plugin add zig
	# asdf plugin add vim
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
	# env ASDF_VIM_CONFIG=${ASDF_VIM_CONFIG} asdf install vim latest && asdf global vim "`asdf latest vim`"
	asdf install zig latest && asdf global zig "`asdf latest zig`"

asdf_update:
	cd ~/.asdf && git checkout "`git describe --abbrev=0 --tags`"
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
	# curl https://raw.githubusercontent.com/tokuhirom/jawiki-kana-kanji-dict/master/SKK-JISYO.jawiki -o ${TMP_JAWII_SKKDIC}
	mkdir -p ~/.local/share/skk
	rm -f ${MY_SKKDIC}
	echo ';; -*- coding: utf-8 -*-'  > ${MY_SKKDIC}
	# skkdic-expr2 ${TMP_UTF8_SKKDIC} ${TMP_JAWII_SKKDIC} >> ${MY_SKKDIC}
	cat ${TMP_UTF8_SKKDIC} >> ${MY_SKKDIC}
	rm -f ${TMP_EUC_SKKDIC} ${TMP_UTF8_SKKDIC} ${TMP_JAWII_SKKDIC}

jetpack:
	curl -fLo ~/.local/share/nvim/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim
