let g:neoterm_size = 8
let g:neoterm_fixedsize = 0

nnoremap <silent> ,rc :TREPLSendFile<cr>
nnoremap <silent> ,rl :TREPLSendLine<cr>
vnoremap <silent> ,rl :TREPLSendSelection<cr>

" Useful maps
" hide/close terminal
"nnoremap <silent> ,th :call neoterm#close()<cr>
" clear terminal
"nnoremap <silent> ,tl :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
"nnoremap <silent> ,tc :call neoterm#kill()<cr>

nnoremap <silent> tt :Tnew<cr>
"nnoremap <silent> vs :terminal<cr>
