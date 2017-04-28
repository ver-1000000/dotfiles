if !1 | finish | endif
if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundle 'bdauria/angular-cli.vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'ngmy/vim-rubocop'
NeoBundle 'othree/html5.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'Quramy/tsuquyomi'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'surround.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'tomasr/molokai'
NeoBundle 'tpope/vim-obsession'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'vim-syntastic/syntastic'
NeoBundle 'yaasita/ore_markdown'
call neobundle#end()

autocmd FileType typescript,html call angular_cli#init() " bdauria/angular-cli.vim

inoremap <silent> jj <ESC>
nnoremap <Esc><Esc> :<C-u>set nohlsearch<Return>
nnoremap / :<C-u>set hlsearch<Return>/
nnoremap ? :<C-u>set hlsearch<Return>?
nnoremap * :<C-u>set hlsearch<Return>*
nnoremap # :<C-u>set hlsearch<Return>#
set t_Co=256
set nrformats-=octal
set fileencoding=utf-8 encoding=utf-8
set fileencodings=iso-2022-jp,utf-8,euc-jp,ucs-2le,ucs-2,cp932
set backspace=start,eol,indent
set mouse=nvchr
set incsearch hlsearch
set wildmenu wildmode=full
set cursorline
set number
set noignorecase
set laststatus=2 statusline=%F%r%h%=%l,%c\ %P\ %{'['.(&fenc!=''?&fenc:&enc).']\ ['.&fileformat.']'}
set autoindent smartindent expandtab shiftwidth=2 softtabstop=2 showtabline=2
set scrolloff=20
set splitbelow
set splitright
set clipboard=unnamedplus,unnamed
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_alto = 1
let g:ore_markdown_output_file = expand('~/preview.html')
let g:jsx_ext_required = 0
let g:angular_cli_stylesheet_format = 'scss'
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_typescript_checkers = ['tsuquyomi', 'tslint']
let g:syntastic_typescript_tsc_args = '--experimentalDecorators --target ES5'
au BufNewFile,BufRead *.tag :setf javascript.jsx

set dir=$HOME/.vim/swap " @angular/cliのため
if !isdirectory(&dir) | call mkdir(&dir, 'p', 0700) | endif

syntax on
colorscheme molokai
highlight Normal ctermbg=none
filetype plugin indent on
