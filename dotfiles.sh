#! /bin/bash
mkdir -p ~/.config/nvim
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
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash &

ln -s ~/dotfiles/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

[ -e ~/.profile ] && file=~/.profile || file=~/.bash_profile
echo 'export PATH="$HOME/Dropbox/akai/bin:$HOME/.rbenv/bin:$PATH"' >> $file
echo 'export EDITOR=vim' >> $file
echo 'export HISTCONTROL=ignoreboth' >> $file
echo 'export HISTSIZE=50000' >> $file
echo 'export HISTTIMEFORMAT=`echo -e "\033[0;36m"%F "\033[0;33m"%T "\033[0m" `' >> $file
echo 'complete -cf sudo' >> $file
echo 'eval "$(rbenv init -)"' >> $file
echo 'source ~/.git-completion.bash' >> ~/.bashrc
echo 'PS1="\[\033[0;30m\][\[\033[0;31m\]\u@\h\[\033[0;34m\] \W\[\033[30m\]]\[\033[0;00m\]\$ "' >> ~/.bashrc
echo 'alias ls="ls --color=auto --group-directories-first"' >> ~/.bashrc
echo 'alias ll="ls -lah"' >> ~/.bashrc
echo 'alias vim="nvim"' >> ~/.bashrc

exit
