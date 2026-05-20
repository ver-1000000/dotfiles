.PHONY: all preparation git-clone git-config bashrc profile

HYPRLAND_LUA := /usr/share/hypr/hyprland.lua

all: preparation git-clone git-config bashrc profile

preparation:
	mkdir -p ~/.config/{nvim,efm-langserver,hypr,waybar,rofi} ~/.local/bin ~/.cache/dein/repos/github.com ~/.tmux/plugins/tpm
	ln -sf $(CURDIR)/.config/nvim/* ~/.config/nvim/
	ln -sf $(CURDIR)/.config/efm-langserver/* ~/.config/efm-langserver/
	ln -sf $(CURDIR)/.config/hypr/custom.lua ~/.config/hypr/custom.lua
	ln -sf $(CURDIR)/.config/hypr/hypridle.conf ~/.config/hypr/hypridle.conf
	touch ~/.config/hypr/local.lua
ifneq ($(wildcard $(HYPRLAND_LUA)),)
	[ -e ~/.config/hypr/hyprland.lua ] || cp $(HYPRLAND_LUA) ~/.config/hypr/hyprland.lua
	grep -qxF 'require("custom")' ~/.config/hypr/hyprland.lua || echo 'require("custom")' >> ~/.config/hypr/hyprland.lua
endif
	rm -f ~/.config/hypr/hyprland.conf ~/.config/hypr/custom.conf
	ln -sf $(CURDIR)/.config/waybar/* ~/.config/waybar/
	ln -sf $(CURDIR)/.config/rofi/* ~/.config/rofi/
	ln -sf $(CURDIR)/.local/bin/* ~/.local/bin/
	ln -sf $(CURDIR)/.tmux.conf ~/.tmux.conf

git-clone:
	git clone https://github.com/Shougo/dein.vim ~/.cache/dein/repos/github.com/Shougo/dein.vim &
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &
	git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
	git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build &

git-config:
	git config --global user.name 'AKAI'
	git config --global core.editor 'nvim'
	git config --global alias.co checkout
	git config --global push.default simple
	git config --global pull.ff only

bashrc:
	echo "PS1=$$'\[\e[38;5;202m\]\u\[\e[38;5;39m\]🏠\H:\[\e[38;5;251m\]\w\[\e[0m\]\$$ '" >> ~/.bashrc
	echo 'complete -cf sudo' >> ~/.bashrc
	echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.bashrc
	echo 'source /usr/share/git/completion/git-completion.bash' >> ~/.bashrc
	echo 'alias ls="ls --color=auto --group-directories-first"' >> ~/.bashrc
	echo 'alias ll="ls -lah"' >> ~/.bashrc
	echo 'alias vim="nvim"' >> ~/.bashrc
	echo 'alias sudo="sudo -E "' >> ~/.bashrc
	echo '[[ "$TERM" == "xterm-ghostty" ]] && export TERM=xterm-256color' >> ~/.bashrc
	echo 'startw() { exec start-hyprland; }' >> ~/.bashrc

profile:
	$(eval FILE := $(shell [ -e ~/.bash_profile ] && echo '~/.bash_profile' || echo '~/.profile'))
	echo 'export PATH="$$HOME/.rbenv/bin:$$HOME/.local/bin:$$PATH"' >> $(FILE)
	echo 'export EDITOR=nvim' >> $(FILE)
	echo 'export HISTCONTROL=ignoreboth' >> $(FILE)
	echo 'export HISTSIZE=50000' >> $(FILE)
	echo 'export HISTTIMEFORMAT=`echo -e "\\033[0;36m"%F "\\033[0;33m"%T "\\033[0m" `' >> $(FILE)
	echo 'eval "$$(rbenv init -)"' >> $(FILE)
