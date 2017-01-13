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
" Date: 13/Jan/2017

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

if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

" プラグイン読み込み＆キャッシュ作成
let s:toml_dir = fnamemodify(expand('<sfile>'), ':h')

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_dir])
  
  call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/deinlazy.toml', {'lazy' : 1})
  
  call dein#end()
  call dein#save_state()
endif

" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}

syntax enable
filetype plugin indent on

runtime! options.rc.vim
runtime! keymap.rc.vim
