"let g:airline_section=''
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''
"let g:airline#extensions#tabline#left_alt_sep = '│'

set laststatus=2
set showtabline=2

if exists('g:nyaovim_version')
  let g:airline_powerline_fonts = 0
  let g:airline_left_sep = ''
  let g:airline_right_sep = ''
else
  " Powerline系フォントを利用する
  let g:airline_powerline_fonts = 1
endif

" Tabにもairlineを適用
let g:airline#extensions#tabline#enabled = 1

" bufferをtabsに表示しない
let g:airline#extensions#tabline#show_buffers = 0

" 0 = ウィンドウの数
" 1 = 左から連番
let g:airline#extensions#tabline#tab_nr_type = 1

" タブの表示形式
let g:airline#extensions#tabline#fnamemod = ':t'
