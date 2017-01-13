" ColorScheme
au MyAutoCmd VimEnter * highlight SignColumn ctermbg=237
au MyAutoCmd VimEnter * highlight SyntasticErrorSign cterm=bold ctermfg=255 ctermbg=203
au MyAutoCmd VimEnter * highlight SyntasticWarningSign cterm=bold ctermfg=233 ctermbg=150
let g:syntastic_error_symbol = 'E➤'
let g:syntastic_warning_symbol = 'W➤'

" Basic setting
let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_save = 1
let g:syntastic_check_on_wq   = 0
