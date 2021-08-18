""" prepare
if &compatible
  set nocompatible
endif
""" prepare

""" `dein.vim` settings
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#load_toml('~/.config/nvim/dein.toml', { 'lazy': 0 })
  call dein#end()
  call dein#save_state()
endif
""" `dein.vim` settings

""" custom `set` settings
set nrformats-=octal
set cursorline
set fileencoding=utf-8 encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,ucs-2le,ucs-2,cp932
set backspace=start,eol,indent
set mouse=nvchr
set incsearch hlsearch
set wildmenu wildmode=full
set number
set laststatus=2 statusline=%F%r%h%=%l,%c\ %P\ %{'fenc['.(&fenc!=''?&fenc:&enc).']\ ff['.&fileformat.']'}
set autoindent smartindent expandtab shiftwidth=2 tabstop=2 showtabline=2
set scrolloff=20
set splitbelow splitright
set startofline
set clipboard=unnamedplus,unnamed
""" custom `set` settings

""" autochdir settings
" <C-x><C-f>のファイルパス補完を、現在開いているファイル基準にするため、InsertEnter時はautochdirにする
autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
""" autochdir settings

""" custom remap settings
let mapleader="\<Space>"
nnoremap <Leader>e :<C-u>e %:h<CR>
nnoremap <Leader>v :<C-u>vs %:h<CR>
nnoremap <Leader>s :<C-u>sp %:h<CR>
nnoremap <Leader>t :<C-u>tabnew %:h<CR>
nnoremap <ESC>     :<C-u>set nohlsearch<CR>
nnoremap /         :<C-u>set hlsearch<CR>/
nnoremap ?         :<C-u>set hlsearch<CR>?
nnoremap *         :<C-u>set hlsearch<CR>*
nnoremap ZAA       :<C-u>qa!<CR>
inoremap jj        <ESC>
""" custom remap settings

""" custom command settings
command! -nargs=0 Reload source $MYVIMRC
"""

""" Other settings
source ~/.config/nvim/plugins.init.vim
colorscheme vim-monokai-tasty
highlight Normal ctermbg=none
filetype plugin indent on
syntax enable
""" Other settings
