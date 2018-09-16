" exchange colon for semicolon
"nnoremap ; :
"nnoremap : ;

nnoremap j gj
nnoremap k gk

" change display mapping
nmap wj <C-w>j
nmap wk <C-w>k
nmap wh <C-w>h
nmap wl <C-w>l

nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>

" ESC
inoremap jj <ESC>

" Vertical size adjust '<' '>'
"nnoremap <silent>< <C-w><
"nnoremap <silent>> <C-w>>
" Horizonal size adjust '+' '-'
"noremap <silent>+ <C-w>+
"noremap <silent>- <C-w>-

" tabnew mapping : tn
nnoremap <silent> tn :<C-u>tabnew<CR>

" Tab jump
noremap t1 1gt
noremap t2 2gt
noremap t3 3gt
noremap t4 4gt
noremap t5 5gt
noremap t6 6gt
noremap t7 7gt
noremap t8 8gt
noremap t9 9gt
noremap t0 :tablast<CR>


" terminal
if has('nvim')
  " Esc to cmd mode
  tnoremap <silent> <ESC> <C-\><C-n>
endif

" word highlight using [SPACE]
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
" word highlight replace using [SPACE] [s]
nmap <Space>s <Space><Space>:%s/<C-r>///g<Left><Left>
" word highlight off
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" save as superuser
cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>

" c.f. keymap {{{
" ---------------------------------------------------------
" map /noremap = NORMAL and VISUAL mode
"  nmap/nnoremap = NORMAL  mode only
"  imap/inoremap = INSERT  mode only
"  cmap/cnoremap = COMMAND mode only
"  vmap/vnoremap = VISUAL  mode only
" map!/noremap! = INSERT and COMMAND mode
" ---------------------------------------------------------
" ([n/v/c/i][nore]map]) <option> Set_keymap Vim_keymap
" }}}
