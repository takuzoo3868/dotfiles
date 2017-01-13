" Basic setting
autocmd! BufEnter,BufWritePost * Neomake

" ColorScheme
autocmd MyAutoCmd VimEnter * highlight SignColumn ctermbg=237
autocmd MyAutoCmd ColorScheme * hi NeomakeErrorSign cterm=bold ctermfg=255 ctermbg=203
autocmd MyAutoCmd ColorScheme * hi NeomakeWarningSign cterm=bold ctermfg=233 ctermbg=150
autocmd MyAutoCmd ColorScheme * hi NeomakeMessageSign cterm=bold ctermfg=8 ctermbg=150
autocmd MyAutoCmd ColorScheme * hi NeomakeInfoSign cterm=bold ctermfg=8 ctermbg=110
let g:neomake_error_sign = {'text': 'E➤', 'texthl': 'NeomakeErrorSign'}
let g:neomake_warning_sign = {
    \   'text': 'W➤',
    \   'texthl': 'NeomakeWarningSign',
    \ }
let g:neomake_message_sign = {
     \   'text': 'M➤',
     \   'texthl': 'NeomakeMessageSign',
     \ }
let g:neomake_info_sign = {'text': 'ℹ➤', 'texthl': 'NeomakeInfoSign'}

" for c/c++
let g:neomake_cpp_enabled_makers = ['gcc']

" eslint
let g:neomake_javascript_enabled_makers = ['eslint']

" for Python
let g:neomake_python_enabled_makers = ['python', 'flake8', 'mypy']
