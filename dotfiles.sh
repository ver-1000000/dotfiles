#! /bin/bash
mkdir -p ~/.config/{nvim,efm-langserver}
mkdir -p ~/.cache/dein/repos/github.com
mkdir -p ~/.tmux/plugins/tpm

git config --global user.name 'AKAI'
git config --global core.editor 'nvim'
git config --global alias.co checkout
git config --global alias.graph 'log --graph --date=short --pretty="format:%C(yellow)%h %C(cyan)%ad %C(green)%an%Creset%x09%s %C(red)%d%Creset"'
git config --global push.default simple
git config --global pull.ff only

git clone https://github.com/Shougo/dein.vim ~/.cache/dein/repos/github.com/Shougo/dein.vim &
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build &

ln -s `pwd`/.config/nvim/* ~/.config/nvim/
ln -s `pwd`/.config/efm-langserver/* ~/.config/efm-langserver/
ln -s `pwd`/.tmux.conf ~/.tmux.conf

[ -e ~/.profile ] && file=~/.profile || file=~/.bash_profile
echo 'export PATH="$HOME/Dropbox/akai/bin:$HOME/.rbenv/bin:$PATH"' >> $file
echo 'export EDITOR=nvim' >> $file
echo 'export HISTCONTROL=ignoreboth' >> $file
echo 'export HISTSIZE=50000' >> $file
echo 'export HISTTIMEFORMAT=`echo -e "\033[0;36m"%F "\033[0;33m"%T "\033[0m" `' >> $file
echo 'eval "$(rbenv init -)"' >> $file
echo 'PS1="\[\033[1;41m\][\[\033[31m\]\u\[\033[37m\]@\[\033[31m\]\h \[\033[34m\]\w\[\033[37;41m\]]\[\033[33m\]\[\033[0;00m\]\$ "' >> ~/.bashrc
echo 'complete -cf sudo' >> ~/.bashrc
echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.bashrc
echo 'source /usr/share/git/completion/git-completion.bash' >> ~/.bashrc
echo 'alias ls="ls --color=auto --group-directories-first"' >> ~/.bashrc
echo 'alias ll="ls -lah"' >> ~/.bashrc
echo 'alias vim="nvim"' >> ~/.bashrc
echo 'alias sudo="sudo -E "' >> ~/.bashrc

exit
