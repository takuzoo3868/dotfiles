call vimfiler#custom#profile('default', 'context', {
     \ 'safe' : 0,
     \ 'auto_expand' : 1,
     \ 'parent' : 0,
     \ })

"default explore -> vimfiler
let g:vimfiler_as_default_explorer = 1

"buffer directory
nnoremap <silent> fe :<C-u>VimFilerBufferDir -quit<CR>

" Open filer
noremap <C-e> :<C-u>VimFilerBufferDir -split -winwidth=48 -toggle -no-quit<CR>

" Don't let <CR> enter the directory but let it open the directory
"autocmd FileType vimfiler nmap <buffer> <CR> <Plug>(vimfiler_expand_or_edit)

" Automatically open vimfiler on start
"autocmd VimEnter * VimFilerExplorer
" If no files are specified, open vimfiler
"autocmd VimEnter * if !argc() | VimFiler | endif

"key mapping
autocmd MyAutoCmd FileType vimfiler call s:vimfiler_my_settings()
function! s:vimfiler_my_settings()
  nnoremap <silent><buffer><expr> s vimfiler#do_switch_action('vsplit')
  nnoremap <silent><buffer><expr> v vimfiler#do_switch_action('split')
  nnoremap <silent><buffer><expr> t vimfiler#do_action('tabopen')
endfunction

" Textmate icons
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'
