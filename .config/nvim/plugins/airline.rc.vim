" Powerline系フォントを利用する
let g:airline_powerline_fonts = 1

" Tabバーのカスタマイズを有効にする
let g:airline#extensions#tabline#enabled = 1

if !has('nvim')
  let g:airline#extensions#whitespace#mixed_indent_algo = 2 " see :help airline-whitespace@en
endif
