"        ___                                     ___           ___           ___     
"       /\  \          ___                      /\  \         /\  \         /\__\    
"       \:\  \        /\  \        ___         |::\  \       /::\  \       /:/  /    
"        \:\  \       \:\  \      /\__\        |:|:\  \     /:/\:\__\     /:/  /     
"    _____\:\  \       \:\  \    /:/__/      __|:|\:\  \   /:/ /:/  /    /:/  /  ___ 
"   /::::::::\__\  ___  \:\__\  /::\  \     /::::|_\:\__\ /:/_/:/__/___ /:/__/  /\__\
"   \:\~~\~~\/__/ /\  \ |:|  |  \/\:\  \__  \:\~~\  \/__/ \:\/:::::/  / \:\  \ /:/  /
"    \:\  \       \:\  \|:|  |   ~~\:\/\__\  \:\  \        \::/~~/~~~~   \:\  /:/  / 
"     \:\  \       \:\__|:|__|      \::/  /   \:\  \        \:\~~\        \:\/:/  /  
"      \:\__\       \::::/__/       /:/  /     \:\__\        \:\__\        \::/  /   
"       \/__/        ~~~~           \/__/       \/__/         \/__/         \/__/    

" Author: takuzoo3868
" Date: 06/Feb/2017

" Vi互換モードをオフ（Vimの拡張機能を有効化）
if &compatible
  set nocompatible
endif

" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

" dein settings {{{
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" プラグイン読み込み＆キャッシュ作成

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:nvim_rc_dir = expand('~/.config/nvim')
  let s:toml        = g:nvim_rc_dir . '/dein.toml'
  let s:lazy_toml   = g:nvim_rc_dir . '/dein_lazy.toml'
  
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  
  call dein#end()
  call dein#save_state()
endif

" 不足プラグインの自動インストール
if dein#check_install()
  call dein#install()
endif
" }}}

syntax enable
filetype plugin indent on

runtime! options.rc.vim
runtime! keymap.rc.vim
