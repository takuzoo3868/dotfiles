"======================================================================
"                                ___           ___           ___
"      ___                      /\  \         /\  \         /\__\
"     /\  \        ___         |::\  \       /::\  \       /:/  /
"     \:\  \      /\__\        |:|:\  \     /:/\:\__\     /:/  /
"      \:\  \    /:/__/      __|:|\:\  \   /:/ /:/  /    /:/  /  ___
"  ___  \:\__\  /::\  \     /::::|_\:\__\ /:/_/:/__/___ /:/__/  /\__\
" /\  \ |:|  |  \/\:\  \__  \:\~~\  \/__/ \:\/:::::/  / \:\  \ /:/  /
" \:\  \|:|  |   ~~\:\/\__\  \:\  \        \::/~~/~~~~   \:\  /:/  /
"  \:\__|:|__|      \::/  /   \:\  \        \:\~~\        \:\/:/  /
"   \::::/__/       /:/  /     \:\__\        \:\__\        \::/  /
"    ~~~~           \/__/       \/__/         \/__/         \/__/
"
"---------------------------------------------------------------------
"
" Author: takuzoo3868
" URL: https://www.twitter.com/takuzoo3868/
" Source: https://github.com/takuzoo3868/dotfiles/.vimrc
" Last Modified: 30 Dec 2016.
"
"=====================================================================


" release autogroup in MyAutoCmd
augroup MyAutoCmd
   autocmd!
augroup END


" Plugin Bundles
" NeoBundle
" vim起動時のみruntimepathにneobundle.vimを追加"
if has('vim_starting')
   if !&compatible
      set nocompatible
   endif
   set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
" neobundle.vimの初期化と設定開始
call neobundle#begin(expand('~/.vim/bundle/'))
" neobundle.vim自身をneobundle.vimで管理する
NeoBundleFetch 'Shougo/neobundle.vim'

" Unite
NeoBundle "Shougo/unite.vim"
NeoBundle 'Shougo/unite-build'
NeoBundleLazy 'h1mesuke/unite-outline', {
         \ "autoload": {
         \   "unite_sources": ["outline"],
         \ }}
NeoBundle 'Shougo/unite-help', {
         \ 'lazy': 1,
         \ 'on_source': 'unite.vim',
         \ }
NeoBundle 'ujihisa/unite-colorscheme', {
         \ 'lazy': 1,
         \ 'on_source': 'unite.vim',
         \ }
NeoBundle 'thinca/vim-unite-history', {
         \ 'lazy': 1,
         \ 'on_source': 'unite.vim',
         \ }

NeoBundleLazy "Shougo/vimfiler", {
         \ "depends": ["Shougo/unite.vim"],
         \ "autoload": {
         \   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
         \   "mappings": ['<Plug>(vimfiler_switch)'],
         \   "explorer": 1,
         \ }}
NeoBundle 'Shougo/vimshell', {
         \ 'lazy': 1,
         \ 'commands': [{'name': 'VimShell',
         \               'complete': 'customlist,vimshell#complete'},
         \              'VimShellExecute', 'VimShellInteractive',
         \              'VimShellTerminal', 'VimShellPop'],
         \ 'mappings': '<Plug>',
         \ }

" IDE
NeoBundleLazy 'scrooloose/nerdtree', {
         \ "autoload" : { "commands": ["NERDTreeToggle"] }}
NeoBundleLazy 'majutsushi/tagbar', {
         \ "autoload": { "commands": ["TagbarToggle"] }}
NeoBundleLazy 'wesleyche/SrcExpl', {
         \ "autoload" : { "commands": ["SrcExplToggle"]}}

" nerdtree settings
if ! empty(neobundle#get("nerdtree"))
   nn <Leader>N :NERDTreeToggle<CR>
endif
" SrcExpl settings
if ! empty(neobundle#get("SrcExpl"))
   " Set refresh time in ms
   let g:SrcExpl_RefreshTime = 1000
   " Is update tags when SrcExpl is opened
   let g:SrcExpl_isUpdateTags = 0
   " Tag update command
   let g:SrcExpl_updateTagsCmd = 'ctags --sort=foldcase %'
   " Update all tags
   function! g:SrcExpl_UpdateAllTags()
      let g:SrcExpl_updateTagsCmd = 'ctags --sort=foldcase -R .'
      call g:SrcExpl_UpdateTags()
      let g:SrcExpl_updateTagsCmd = 'ctags --sort=foldcase %'
   endfunction
   " Source Explorer Window Height
   let g:SrcExpl_winHeight = 14
   " Mappings
   nn [srce] <Nop>
   nm <Leader>E [srce]
   nn <silent> [srce]<CR> :SrcExplToggle<CR>
   nn <silent> [srce]u :call g:SrcExpl_UpdateTags()<CR>
   nn <silent> [srce]a :call g:SrcExpl_UpdateAllTags()<CR>
   nn <silent> [srce]n :call g:SrcExpl_NextDef()<CR>
   nn <silent> [srce]p :call g:SrcExpl_PrevDef()<CR>
endif
" tagbar settings
if ! empty(neobundle#get("tagbar"))
   " Width (default 40)
   let g:tagbar_width = 30
   " Map for toggle
   nn <silent> <leader>t :TagbarToggle<CR>
endif
" All view setting
if ! empty(neobundle#get("nerdtree")) &&
         \! empty(neobundle#get("SrcExpl")) &&
         \! empty(neobundle#get("tagbar"))
   nn <silent> <Leader>A :SrcExplToggle<CR>:NERDTreeToggle<CR>:TagbarToggle<CR>
endif


if has('lua') && v:version >= 703
   NeoBundle 'Shougo/neocomplete.vim'
else
   NeoBundle 'Shougo/neocomplcache.vim'
endif


" Library
NeoBundle 'Shougo/vimproc', {
         \ 'build' : {
         \   'windows' : 'make -f make_mingw32.mak',
         \   'cygwin' : 'make -f make_cygwin.mak',
         \   'mac' : 'make -f make_mac.mak',
         \   'unix' : 'make -f make_unix.mak',
         \ },
         \ }
NeoBundle 'mattn/webapi-vim'

" Development
NeoBundle 'thinca/vim-quickrun'
let g:quickrun_config={'*': {'split': ''}}
let g:quickrun_config._={ 'runner':'vimproc',
         \       "runner/vimproc/updatetime" : 10,
         \       "outputter/buffer/close_on_empty" : 1,
         \ }

" Git
NeoBundle 'tpope/vim-fugitive'
NeoBundleLazy "mattn/gist-vim", {
         \ "depends": ["mattn/webapi-vim"],
         \ "autoload": {
         \   "commands": ["Gist"],
         \ }}
NeoBundleLazy "gregsexton/gitv", {
         \ "depends": ["tpope/vim-fugitive"],
         \ "autoload": {
         \   "commands": ["Gitv"],
         \ }}
NeoBundle 'rhysd/git-messenger.vim', {
         \ 'lazy': 1,
         \ 'mappings': '<Plug>',
         \ }

" C/C++
" NeoBundle 'Rip-Rip/clang_complete'

" Japanese Document
NeoBundle 'vim-jp/vimdoc-ja'

" ColorScheme
NeoBundle 'tomasr/molokai'

" エラー箇所をハイライト
NeoBundle 'cohama/vim-hier'
" エラーの原因をコマンドウィンドウに出力
NeoBundle 'dannyob/quickfixstatus'

" Application
NeoBundle 'itchyny/calendar.vim'

" Others
" ~(=^･ω･^) 'Miaow miaow.'
NeoBundle 'rtakasuke/vim-neko'
NeoBundle 'rbtnn/game_engine.vim'
NeoBundle 'rbtnn/puyo.vim'
" NeoBundle 'supermomonga/thingspast.vim'
" NeoBundle 'basyura/J6uil.vim'

" Twitter on Vim
NeoBundle 'basyura/TweetVim'
let g:tweetvim_display_icon = 1
let g:tweetvim_tweet_per_page = 60

NeoBundle 'basyura/twibill.vim'
" Gmail on Vim
NeoBundle 'yuratomo/gmail.vim'

" neobundle.vimの設定終了
call neobundle#end()
" 読み込んだプラグインも含め,ファイルタイプの検出,
" ファイルタイプ別プラグイン/インデントを有効にする
filetype plugin indent on
" プラグインがインストールされているかチェック
NeoBundleCheck
if !has('vim_starting')
   " .vimrcを読み込み直した時のための設定
   call neobundle#call_hook('on_source')
endif



" Settings

" Vi互換モードをオフ（Vimの拡張機能を有効）
set nocompatible
" マウス
set mouse=a
"標準の文字コードをUTF-8に指定
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8

" 行番号を表示
set number
" タイトルをウインドウ枠に表示
set title
" ルーラーを表示
set ruler
" タブや改行を表示しない
set nolist
" 入力中のコマンドをステータスに表示
set showcmd
" 括弧入力時の対応する括弧を表示
set showmatch
" " 補完候補をリスト表示
set wildmenu
" コマンドラインの表示行数
set cmdheight=3
" コマンドウィンドウの表示行数
set cmdwinheight=5
" タブページを常に表示
set showtabline=2
" ステータスラインを常に表示
set laststatus=2
" ステータスライン表示モード
" "0"  一番下のウィンドウはステータスラインを表示しない
" "1"  ウィンドウが1つの時はステータスラインを表示しない
" "2"  常にステータスラインを表示する
" ステータスラインの設定
:set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

function! GetQuickFixCount() abort
   return len(filter(getqflist(), 'v:val.valid != 0'))
endfunction

" コマンドライン補完
set wildmenu wildmode=list:full
" コマンドの履歴の保存数
set history=2000

" 改行時に前の行のインデントを継続
set autoindent
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減
set smartindent
" タブ入力を複数の空白入力に置き換える
set expandtab
" 自動インデントでずれる幅
set shiftwidth=3
" タブキーでカーソルが動く幅
set softtabstop=3
" 画面上でタブ文字が占める幅
set tabstop=3
" Tabを打ち込むと,shiftwidthの数だけインデント
set smarttab
" 折り返しの際にインデントを考慮
if exists('+breakindent')
   set breakindent
endif
" 外部でファイルが変更されたら自動で読みなおす
set autoread
" 編集情報の記録ファイルを作成
set swapfile
" バックアップファイルを作成しない
set nobackup
set nowritebackup
" インデント、改行、挿入モード開始位置を超えて削除
"   indent        : 行頭の空白の削除を許す
"   eol           : 改行の削除を許す
"   start         : 挿入モードの開始位置での削除を許す
set backspace=indent,eol,start
" 行頭行末の左右移動で行をまたぐ
set whichwrap=b,s,<,>,[,],~
" マッピングの受付時間
set timeout
set timeoutlen=1000
" キーコードの受付時間
set ttimeoutlen=100
" 行連結 "J" で間にスペースを入れない
set nojoinspaces

" Colorscheme
if has('vim_starting')
   syntax enable
   set background=dark
   set t_Co=256
   if &t_Co < 256
      colorscheme default
   else
      try
         colorscheme molokai
      catch
         colorscheme desert
      endtry
   endif
endif


" にゃーん
map <silent> neko :Neko<CR>
