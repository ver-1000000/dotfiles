#! /bin/bash
mkdir -p ~/.vim/bundle
mkdir -p ~/.tmux/plugins/tpm

git config --global user.name 'akai'
git config --global core.editor 'vim'
git config --global alias.co checkout
git config --global alias.graph 'log --graph --date=short --pretty="format:%C(yellow)%h %C(cyan)%ad %C(green)%an%Creset%x09%s %C(red)%d%Creset"'
git config --global push.default simple

git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim &
git clone https://github.com/Shougo/vimproc.vim ~/.vim/bundle/vimproc && cd ~/.vim/bundle/vimproc && make && cd &
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build &
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O git-completion.bash &

ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.rubocop.yml ~/.rubocop.yml

[ -e ~/.profile ] && file=~/.profile || file=~/.bash_profile
echo 'export PATH="$HOME/Dropbox/akai/bin:$HOME/.rbenv/bin:$PATH"' >> $file
echo 'export EDITOR=vim' >> $file
echo 'export HISTCONTROL=ignoreboth' >> $file
echo 'export HISTSIZE=10000' >> $file
echo 'export HISTTIMEFORMAT=`echo -e "\033[0;36m"%F "\033[0;33m"%T "\033[0m" `' >> $file
echo 'complete -cf sudo' >> $file
echo 'eval "$(rbenv init -)"' >> $file
echo 'alias tmux="tmux -2"' >> .bashrc
echo 'alias ls='ls --color=auto --group-directories-first'' >> .bashrc
echo 'alias ll="ls -lah"' >> .bashrc

exit
