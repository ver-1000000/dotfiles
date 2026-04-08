.PHONY: all preparation git-clone git-config bashrc profile

all: preparation git-clone git-config bashrc profile

preparation:
	mkdir -p ~/.config/nvim ~/.config/efm-langserver ~/.config/hypr ~/.config/waybar ~/.config/rofi ~/.cache/dein/repos/github.com ~/.tmux/plugins/tpm
	ln -sf $(CURDIR)/.config/nvim/* ~/.config/nvim/
	ln -sf $(CURDIR)/.config/efm-langserver/* ~/.config/efm-langserver/
	ln -sf $(CURDIR)/.config/hypr/custom.conf ~/.config/hypr/custom.conf
	grep -qxF 'source = ~/.config/hypr/custom.conf' ~/.config/hypr/hyprland.conf || echo 'source = ~/.config/hypr/custom.conf' >> ~/.config/hypr/hyprland.conf
	ln -sf $(CURDIR)/.config/waybar/* ~/.config/waybar/
	ln -sf $(CURDIR)/.config/rofi/* ~/.config/rofi/
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
	echo 'export PATH="$$HOME/Dropbox/akai/.local/bin:$$HOME/.rbenv/bin:$$HOME/.local/bin:$$PATH"' >> $(FILE)
	echo 'export EDITOR=nvim' >> $(FILE)
	echo 'export HISTCONTROL=ignoreboth' >> $(FILE)
	echo 'export HISTSIZE=50000' >> $(FILE)
	echo 'export HISTTIMEFORMAT=`echo -e "\\033[0;36m"%F "\\033[0;33m"%T "\\033[0m" `' >> $(FILE)
	echo 'eval "$$(rbenv init -)"' >> $(FILE)
