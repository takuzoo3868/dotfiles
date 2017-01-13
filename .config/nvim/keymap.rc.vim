" exchange colon for semicolon
"nnoremap ; :
"nnoremap : ;

" change display mapping
nmap <Down> <C-w>j
nmap <Up> <C-w>k
nmap <Left> <C-w>h
nmap <Right> <C-w>l

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
noremap t0 :tablast<cr>


" terminal
if has('nvim')
  " Esc to cmd mode
  tnoremap <silent> <ESC> <C-\><C-n>
endif

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
