""" `Netrw` settings
let g:netrw_localrmdir ='rm -r'
let g:netrw_liststyle  = 3
let g:netrw_altv       = 1
let g:netrw_alto       = 1
""" `Netrw` settings

""" `angular-cli.vim` settings
autocmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd FileType typescript,html call angular_cli#init()
""" `angular-cli.vim` settings

""" LSP settings
set omnifunc=lsp#complete
let g:lsp_virtual_text_enabled     = 0
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay  = 0
let g:lsp_settings                 = {
      \  'efm-langserver': {
      \    'disabled': 0,
      \    'allowlist': ['ruby']
      \  }
      \}
nnoremap <C-]>     :<C-u>LspDefinition<CR>
nnoremap <Leader>h :<C-u>LspHover<CR>
nnoremap <Leader>r :<C-u>LspRename<CR>
nnoremap <Leader>d :<C-u>LspDocumentDiagnostics<CR>
nnoremap <Leader>n :<C-u>LspNextDiagnostic<CR>
nnoremap <Leader>p :<C-u>LspPreviousDiagnostic<CR>
""" LSP settings
