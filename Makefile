ASDF_VIM_CONFIG="--with-tlib=ncurses --with-compiledby=asdf --enable-multibyte --enable-cscope --enable-terminal --enable-perlinterp --enable-rubyinterp --enable-python3interp --enable-luainterp --enable-gui=gtk3"

# --- Pinned versions (managed by Renovate in Phase C) ---
# asdf v0.15.0 is the last shell-based release. v0.16.0+ is a Go rewrite distributed
# as a prebuilt binary, which requires migrating the `asdf` / `asdf_update` targets
# off `git clone + checkout`. Keep on v0.15.0 until that migration is scoped.
# renovate: datasource=github-releases depName=asdf-vm/asdf allowedVersions=<0.16.0
ASDF_VERSION := v0.15.0

# renovate: datasource=go depName=golang.org/x/tools
GOIMPORTS_VERSION := v0.44.0
# renovate: datasource=go depName=golang.org/x/tools/gopls
GOPLS_VERSION := v0.21.1
# renovate: datasource=go depName=github.com/rhysd/actionlint
ACTIONLINT_VERSION := v1.7.12
# renovate: datasource=go depName=github.com/go-task/task/v3
TASK_VERSION := v3.50.0
# NOTE: on a major-version bump, also update the /v3 segment in go_tool_install below.
# renovate: datasource=go depName=github.com/suzuki-shunsuke/pinact/v3
PINACT_VERSION := v3.9.0
# renovate: datasource=go depName=github.com/derailed/k9s
K9S_VERSION := v0.50.18

# renovate: datasource=github-releases depName=golangci/golangci-lint
GOLANGCI_LINT_VERSION := v2.11.4
GOLANGCI_LINT_VERSION_NUM := $(GOLANGCI_LINT_VERSION:v%=%)
# SHA256 of golangci-lint-$(GOLANGCI_LINT_VERSION_NUM)-linux-amd64.tar.gz.
# Must be updated together with GOLANGCI_LINT_VERSION. Source:
# https://github.com/golangci/golangci-lint/releases/download/$(GOLANGCI_LINT_VERSION)/golangci-lint-$(GOLANGCI_LINT_VERSION_NUM)-checksums.txt
GOLANGCI_LINT_SHA256_LINUX_AMD64 := 200c5b7503f67b59a6743ccf32133026c174e272b930ee79aa2aa6f37aca7ef1

# SHA256 of https://claude.ai/install.sh. Anthropic updates the installer in-place;
# on mismatch, review the new script and bump this SHA.
CLAUDE_INSTALL_SCRIPT_SHA256 := b315b46925a9bfb9422f2503dd5aa649f680832f4c076b22d87c39d578c3d830

# tani/vim-jetpack has no release tags; pin to a commit SHA on main.
# renovate: datasource=git-refs depName=https://github.com/tani/vim-jetpack branch=main
VIM_JETPACK_SHA := 56558f41c2148120b94526e5c8e46f172864b990

# renovate: datasource=npm depName=intelephense
INTELEPHENSE_VERSION := 1.16.5
# renovate: datasource=npm depName=typescript-language-server
TS_LANGSERVER_VERSION := 5.1.3

# renovate: datasource=pypi depName=flake8
FLAKE8_VERSION := 7.3.0
# renovate: datasource=pypi depName=mysql-mcp-server
MYSQL_MCP_SERVER_VERSION := 0.2.2
# renovate: datasource=pypi depName=pyright
PYRIGHT_VERSION := 1.1.409
# renovate: datasource=pypi depName=cmake-language-server
CMAKE_LANGSERVER_VERSION := 0.1.11

.PHONY: update init git neovim gtk3 tmux tool_update tool_instal go_tool_install golangci_lint_install lsp_update lsp_install asdf asdf_plugin asdf_install asdf_update skkdic jetpack test clean all ssh_init ssh_agent bin_init neovim_init claude_install

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

ssh_agent:
	systemctl --user enable --now ssh-agent.socket

bin_init:
	mkdir -p ~/bin
	ln -fs ~/lib/Settings/bin/* ~/bin/

neovim_init:
	mkdir -p ~/.config/nvim
	ln -fs ~/lib/Settings/_config/nvim/init.lua ~/.config/nvim/init.lua
	ln -fs ~/lib/Settings/_config/nvim/lua ~/.config/nvim/lua
	ln -fs ~/lib/Settings/_config/nvim/after ~/.config/nvim/after
	ln -fs ~/lib/Settings/_config/vsnip ~/.config/vsnip
	ln -fs ~/lib/Settings/_config/nvim/jetpack.toml ~/.config/nvim/jetpack.toml

uv_init:
	mkdir -p ~/.config/uv
	ln -fs ~/lib/Settings/_config/uv/uv.toml ~/.config/uv/uv.toml

git:
	mkdir -p ~/.config/git
	ln -fs ~/lib/Settings/_config/git/* ~/.config/git/
	git config --global commit.template ~/.config/git/message

neovim:
	gem install --user neovim

gtk3:
	gsettings set org.gnome.desktop.interface gtk-key-theme "Emacs"
	gsettings set org.gnome.desktop.interface gtk-enable-primary-paste true

# tmux:
# 	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

tool_update: lsp_update go_tool_install
	claude update

tool_install: lsp_install go_tool_install
	pipx install flake8==$(FLAKE8_VERSION) --force
	pipx install mysql-mcp-server==$(MYSQL_MCP_SERVER_VERSION) --force

claude_install:
	tmp=$$(mktemp) && \
		curl -fsSL -o $$tmp https://claude.ai/install.sh && \
		echo "$(CLAUDE_INSTALL_SCRIPT_SHA256)  $$tmp" | sha256sum -c - && \
		bash $$tmp && \
		rm -f $$tmp

go_tool_install: golangci_lint_install
	go install golang.org/x/tools/cmd/goimports@$(GOIMPORTS_VERSION)
	go install golang.org/x/tools/gopls@$(GOPLS_VERSION)
	go install github.com/rhysd/actionlint/cmd/actionlint@$(ACTIONLINT_VERSION)
	go install github.com/go-task/task/v3/cmd/task@$(TASK_VERSION)
	go install github.com/suzuki-shunsuke/pinact/v3/cmd/pinact@$(PINACT_VERSION)
	go install github.com/derailed/k9s@$(K9S_VERSION)

golangci_lint_install:
	tmpdir=$$(mktemp -d) && \
		tarball=golangci-lint-$(GOLANGCI_LINT_VERSION_NUM)-linux-amd64.tar.gz && \
		curl -fsSL -o $$tmpdir/$$tarball https://github.com/golangci/golangci-lint/releases/download/$(GOLANGCI_LINT_VERSION)/$$tarball && \
		echo "$(GOLANGCI_LINT_SHA256_LINUX_AMD64)  $$tmpdir/$$tarball" | sha256sum -c - && \
		tar -xzf $$tmpdir/$$tarball -C $$tmpdir && \
		install -m 0755 $$tmpdir/golangci-lint-$(GOLANGCI_LINT_VERSION_NUM)-linux-amd64/golangci-lint $(GOPATH)/bin/golangci-lint && \
		rm -rf $$tmpdir

lsp_update:
	pipx install pyright==$(PYRIGHT_VERSION) --force
	pipx install cmake-language-server==$(CMAKE_LANGSERVER_VERSION) --force
	pipx install flake8==$(FLAKE8_VERSION) --force
	pipx install mysql-mcp-server==$(MYSQL_MCP_SERVER_VERSION) --force
	npm install -g intelephense@$(INTELEPHENSE_VERSION) typescript-language-server@$(TS_LANGSERVER_VERSION)

lsp_install:
	pipx install pyright==$(PYRIGHT_VERSION)
	pipx install cmake-language-server==$(CMAKE_LANGSERVER_VERSION)

asdf:
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf
	cd ~/.asdf && git checkout $(ASDF_VERSION)

asdf_plugin:
	asdf plugin add terraform
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
	asdf plugin add kubectl

asdf_install:
	asdf install

asdf_update:
	cd ~/.asdf && git checkout $(ASDF_VERSION)
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
	curl -fLo ~/.local/share/nvim/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/$(VIM_JETPACK_SHA)/plugin/jetpack.vim
