if !1 | finish | endif
if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'othree/html5.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'tpope/vim-obsession'
NeoBundle 'tpope/vim-rails'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'yaasita/ore_markdown'
NeoBundle 'ngmy/vim-rubocop'
NeoBundle 'scrooloose/syntastic.git'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'Shougo/vimproc'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'Quramy/tsuquyomi'
call neobundle#end()

inoremap <silent> jj <ESC>
set t_Co=256
set nrformats-=octal
set fileencoding=utf-8 encoding=utf-8
set fileencodings=iso-2022-jp,utf-8,euc-jp,ucs-2le,ucs-2,cp932
set backspace=start,eol,indent
set mouse=nvchr
set incsearch nohlsearch
set wildmenu wildmode=full
set cursorline
set number
set noignorecase
set laststatus=2 statusline=%F%r%h%=%l,%c\ %P\ %{'['.(&fenc!=''?&fenc:&enc).']\ ['.&fileformat.']'}
set expandtab shiftwidth=2 softtabstop=2
set scrolloff=20
set splitbelow
set splitright
set clipboard=unnamedplus,unnamed
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_alto = 1
let g:ore_markdown_output_file = expand('~/preview.html')
let g:syntastic_ruby_checkers = ['rubocop']
let g:jsx_ext_required = 0
let g:syntastic_typescript_tsc_args = '--experimentalDecorators --target ES5'
au BufNewFile,BufRead *.tag :setf javascript.jsx

syntax on
colorscheme molokai
highlight Normal ctermbg=none
filetype plugin indent on

