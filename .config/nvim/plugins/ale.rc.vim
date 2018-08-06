" 保存時のみ実行
let g:ale_lint_on_text_changed = 0

" 表示に関する設定
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:airline#extensions#ale#open_lnum_symbol = '('
let g:airline#extensions#ale#close_lnum_symbol = ')'
let g:ale_echo_msg_format = '[%linter%]%code: %%s'
let g:ale_lint_on_text_changed = 'normal'

call ale#linter#Define('markdown', {
\   'name': 'textlint',
\   'executable': 'textlint',
\   'command': 'textlint -f unix %t',
\   'callback': 'ale#handlers#unix#HandleAsError',
\})

let g:ale_linters = {
\   'html': [],
\}

" Ctrl + kで次の指摘へ、Ctrl + jで前の指摘へ移動
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)