if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
  call dein#end()
  call dein#save_state()
endif

call dein#add('bdauria/angular-cli.vim')
call dein#add('dense-analysis/ale')
call dein#add('leafgarland/typescript-vim')
call dein#add('mattn/emmet-vim')
call dein#add('peitalin/vim-jsx-typescript')
call dein#add('posva/vim-vue')
call dein#add('prettier/vim-prettier')
call dein#add('Shougo/denite.nvim')
call dein#add('tomasr/molokai')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-obsession')
call dein#add('tpope/vim-rails')
call dein#add('tpope/vim-endwise')
call dein#add('Townk/vim-autoclose')

autocmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd BufNewFile,BufRead *.vue set filetype=vue
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx " [peitalin/vim-jsx-typescript]
autocmd FileType typescript,html call angular_cli#init()           " [bdauria/angular-cli.vim]

""" denite.vim settings
nnoremap # :<C-u>Denite file/rec -split=floating file:new<CR>
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>  denite#do_map('do_action')
  nnoremap <silent><buffer><expr> o     denite#do_map('do_action', 'split')
  nnoremap <silent><buffer><expr> v     denite#do_map('do_action', 'vsplit')
  nnoremap         <buffer><expr> t     denite#do_map('do_action', 'dein_update')
  nnoremap <silent><buffer><expr> d     denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p     denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> <Esc> denite#do_map('quit')
  nnoremap <silent><buffer><expr> q     denite#do_map('quit')
  nnoremap <silent><buffer><expr> i     denite#do_map('open_filter_buffer')
endfunction
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o> <Plug>(denite_filter_quit)
endfunction
""" denite.vim settings


inoremap <silent> jj <ESC>
nnoremap <Esc><Esc> :<C-u>set nohlsearch<Return>
nnoremap / :<C-u>set hlsearch<Return>/
nnoremap ? :<C-u>set hlsearch<Return>?
nnoremap * :<C-u>set hlsearch<Return>*

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
set omnifunc=ale#completion#OmniFunc                   " [w0rp/ale] completion setting
set completeopt=menu,menuone,preview,noselect,noinsert " [w0rp/ale] completion setting

let g:netrw_localrmdir              ='rm -r' " Allow netrw to remove non-empty local directories
let g:netrw_liststyle               = 3
let g:netrw_altv                    = 1
let g:netrw_alto                    = 1
let g:angular_cli_stylesheet_format = 'scss'
let g:ale_lint_on_text_changed      = 'never' " [w0rp/ale] never lint on text changes
let g:ale_lint_on_enter             = 0       " [w0rp/ale] never lint open files
let g:ale_completion_enabled        = 1       " [w0rp/ale] completion setting
let g:ale_completion_delay          = 100     " [w0rp/ale] completion setting

""" [w0rp/ale] Key mappings.
function ALELSPMappings()
  let l:lsp_found = 0
  for l:linter in ale#linter#Get(&filetype) | if !empty(l:linter.lsp) | let l:lsp_found = 1 | endif | endfor
  if (l:lsp_found)
    nnoremap <buffer> <C-]> :ALEGoToDefinition<CR>
    nnoremap <buffer> <C-^> :ALEFindReferences<CR>
  else
    silent! unmap <buffer> <C-]>
    silent! unmap <buffer> <C-^>
  endif
endfunction
autocmd BufRead,FileType * call ALELSPMappings()

colorscheme molokai
highlight Normal ctermbg=none
filetype plugin indent on
syntax enable
