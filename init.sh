#! /bin/bash
mkdir -p ~/.vim/bundle
mkdir -p ~/.tmux/plugins/tpm

git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim &
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim &
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O git-completion.bash &

ln -s ~/dotfiles/.vimrc ~/.vimrc &
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.Xdefaults ~/.Xdefaults
ln -s ~/dotfiles/.rubocop.yml ~/

git config --global user.name 'Akai'
git config --global core.editor 'vim'
git config --global alias.co checkout
git config --global push.default simple

echo 'source ~/dotfiles/git-completion.bash' >> ~/.bashrc
echo 'alias tmux="tmux -2"' >> ~/.bashrc

cd ~/.vim/bundle/vimproc && make && cd
exit
