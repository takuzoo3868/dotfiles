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
" Last Modified: 30 Apl 2016.
"
"=====================================================================

" Start up settings {{{===============================================

" release autogroup in MyAutoCmd
augroup MyAutoCmd
   autocmd!
augroup END
" }}}


" Plugin Bundles {{{==================================================

" NeoBundle {{{=======================================================
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

" Synthesis {{{
" Unite {{{
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
" }}}
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
" }}}

" IDE {{{
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
" }}}
" END Synthesis}}}

" Writing {{{
if has('lua') && v:version >= 703
   NeoBundle 'Shougo/neocomplete.vim'
else
   NeoBundle 'Shougo/neocomplcache.vim'
endif
" }}}

" Library {{{
NeoBundle 'Shougo/vimproc', {
         \ 'build' : {
         \   'windows' : 'make -f make_mingw32.mak',
         \   'cygwin' : 'make -f make_cygwin.mak',
         \   'mac' : 'make -f make_mac.mak',
         \   'unix' : 'make -f make_unix.mak',
         \ },
         \ }
NeoBundle 'mattn/webapi-vim'
" }}}

" Development {{{
NeoBundle 'thinca/vim-quickrun'
let g:quickrun_config={'*': {'split': ''}}
let g:quickrun_config._={ 'runner':'vimproc',
         \       "runner/vimproc/updatetime" : 10,
         \       "outputter/buffer/close_on_empty" : 1,
         \ }
" }}}

" Git {{{
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
" }}}

" C/C++ {{{
" NeoBundle 'Rip-Rip/clang_complete'
" }}}

" Java {{{
" }}}

" Python {{{
" }}}

" Japanese {{{
NeoBundle 'vim-jp/vimdoc-ja'
" }}}

" ColorScheme {{{
NeoBundle 'junegunn/seoul256.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'vim-scripts/Wombat'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'vim-scripts/twilight'
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'vim-scripts/rdark'
NeoBundle 'djjcast/mirodark'
NeoBundle 'sjl/badwolf'
NeoBundle 'cocopon/iceberg.vim'
NeoBundle 'reedes/vim-colors-pencil'

" エラー箇所をハイライトする
NeoBundle 'cohama/vim-hier'
" エラーの原因をコマンドウィンドウに出力
NeoBundle 'dannyob/quickfixstatus'
" }}}

" Utility {{{
NeoBundle 'tyru/open-browser.vim'
"}}}

" Application {{{
NeoBundle 'itchyny/calendar.vim'
" }}}

" Others {{{
NeoBundle 'thinca/vim-scouter'
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
" }}}

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
" END NeoBundle }}}


" Vim Setup  {{{======================================

" Basic options {{{===================================

" Vi互換モードをオフ（Vimの拡張機能を有効）
set nocompatible
" マウス
set mouse=a
"標準の文字コードをUTF-8に指定
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8

" }}}

" Vim opptions {{{====================================

" === View === {{{

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
:set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

function! GetQuickFixCount() abort
   return len(filter(getqflist(), 'v:val.valid != 0'))
endfunction

" }}}

" === Command === {{{

" コマンドライン補完
set wildmenu wildmode=list:full
" コマンドの履歴の保存数
set history=2000

" }}}

" === Search === {{{

" incremental search
set incsearch
" 検索文字列が小文字の場合は大文字小文字を区別なく検索
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索
set smartcase
set hlsearch | nohlsearch

" }}}

" === Indent === {{{

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

" }}}

" === Buffer === {{{

" 外部でファイルが変更されたら自動で読みなおす
set autoread
" 編集情報の記録ファイルを作成
set swapfile
" バックアップファイルを作成しない
set nobackup
set nowritebackup

" }}}

" === Input === {{{

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

" }}}

" === Colorscheme === {{{

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

"}}}

" END Vim opptions }}}


" Mappings {{{=======================================================================
"
"==================================================================================="
" コマンド        | ノーマル | 挿入 | コマンドライン | ビジュアル| 選択 | 演算待ち |
" map  / noremap  |    @     |  -   |       -        |     @     |  @   |    @     |
" nmap / nnoremap |    @     |  -   |       -        |     -     |  -   |    -     |
" vmap / vnoremap |    -     |  -   |       -        |     @     |  @   |    -     |
" omap / onoremap |    -     |  -   |       -        |     -     |  -   |    @     |
" xmap / xnoremap |    -     |  -   |       -        |     @     |  -   |    -     |
" smap / snoremap |    -     |  -   |       -        |           |  @   |    -     |
" map! / noremap! |    -     |  @   |       @        |     -     |  -   |    -     |
" imap / inoremap |    -     |  @   |       -        |     -     |  -   |    -     |
" cmap / cnoremap |    -     |  -   |       @        |     -     |  -   |    -     |
"==================================================================================="
"
" [[n/v/c/i][nore]map] <options> 入力する操作 Vimが解釈する操作
"
"====================================================================================

" Useful Keymaps {{{
" Thunks to haya14busa, cohama

" Breakline with Enter {{{
nnoremap <CR> o<ESC>
" }}}

" For Undo Revision, Break Undo Sequence {{{
inoremap <CR> <C-]><C-G>u<CR>

inoremap <C-h> <C-g>u<C-h>
inoremap <BS> <C-g>u<BS>
inoremap <Del> <C-g>u<Del>
inoremap <C-d> <C-g>u<Del>
inoremap <C-w> <C-g>u<C-w>
inoremap <C-u> <C-g>u<C-u>
" }}}

" Motion {{{

" Normal Mode {{{
nnoremap j gj
vnoremap j gj
nnoremap gj j
vnoremap gj j

nnoremap k gk
vnoremap k gk
nnoremap gk k
vnoremap gk k

nnoremap - $
" }}}

" Insert & Comandline Mode {{{
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>

cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>

" Word Motion in Insert Mode
" inoremap <M-w> <S-Right>
" inoremap <M-b> <S-Left>
" }}}

" Scroll {{{
nnoremap <C-e> <C-e>j
nnoremap <C-y> <C-y>k
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz

nnoremap <Down> <C-e><C-e><C-e><C-e><C-e><C-e><C-e><C-e><C-e><C-e>
nnoremap <Up>   <C-y><C-y><C-y><C-y><C-y><C-y><C-y><C-y><C-y><C-y>
vnoremap <Down> <C-e><C-e><C-e><C-e><C-e><C-e><C-e><C-e><C-e><C-e>
vnoremap <Up>   <C-y><C-y><C-y><C-y><C-y><C-y><C-y><C-y><C-y><C-y>

nnoremap <Space>j <C-f>zz
nnoremap <Space>k <C-b>zz
vnoremap <Space>j <C-f>zz
vnoremap <Space>k <C-b>zz
" }}}

" comaha's smooth scroll
let s:scroll_time_ms = 100
let s:scroll_precision = 8
function! CohamaSmoothScroll(dir, windiv, factor)
   let cl = &cursorline
   let cc = &cursorcolumn
   set nocursorline nocursorcolumn
   let height = winheight(0) / a:windiv
   let n = height / s:scroll_precision
   if n <= 0
      let n = 1
   endif
   let wait_per_one_move_ms = s:scroll_time_ms / s:scroll_precision * a:factor
   let i = 0
   let scroll_command = a:dir == "down" ?
            \ "normal! " . n . "\<C-E>" . n ."j" :
            \ "normal! " . n . "\<C-Y>" . n ."k"
   while i < s:scroll_precision
      let i = i + 1
      execute scroll_command
      execute "sleep " . wait_per_one_move_ms . "m"
      redraw
   endwhile
   let &cursorline = cl
   let &cursorcolumn = cc
endfunction
nnoremap <silent> <C-d> :call CohamaSmoothScroll("down", 2, 1)<CR>
nnoremap <silent> <C-u> :call CohamaSmoothScroll("up", 2, 1)<CR>
nnoremap <silent> <C-f> :call CohamaSmoothScroll("down", 1, 2)<CR>
nnoremap <silent> <C-b> :call CohamaSmoothScroll("up", 1, 2)<CR>

" END Motion }}}


" Paste in insert and Command-line mode"{{{
inoremap <C-y><C-y> <C-r>+
cnoremap <C-y><C-y> <C-r>+
" }}}

" Vertical Paste"{{{
vnoremap <C-p> I<C-r>+<ESC><ESC>
" }}}

" Select pasted text {{{
" nnoremap <expr>gp '`['.strpart(getregtype(),0,1).'`]'
" }}}

" Command line History {{{
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" }}}

" Save as root"{{{
cnoremap w!! w !sudo tee > /dev/null %
" }}}


" Show invisibles {{{

" Shortcut to rapidly toggle `set list`
nnoremap <silent> <Leader>l :<C-u>set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

"Invisible character colors
hi NonText guifg=#4a4a59
hi SpecialKey guifg=#4a4a59

" Highlight End-of-Line & Zenkaku Whitespace {{{
function! s:hl_trailing_spaces() "{{{
   " Test
   highlight! link TrailingSpaces Error
   syntax match TrailingSpaces containedin=ALL /\s\+$/
endfunction "}}}
function! s:hl_zenkaku() "{{{
   highlight link ZenkakuSpace Error
   syntax match ZenkakuSpace containedin=ALL /　/
endfunction "}}}

" Autocmd BufWinEnter,ColorScheme * call s:hl_trailing_spaces()
" Autocmd BufWinEnter,ColorScheme * call s:hl_zenkaku()
" }}}

" Remove sapaces not wanted {{{
function! RemoveUnwantedSpaces()
   let pos_save = getpos('.')
   try
      keeppatterns %s/\s\+$//e
      while 1
         let lastline = getline('$')
         if lastline =~ '^\s*$' && line('$') != 1
            $delete
         else
            break
         endif
      endwhile
   finally
      call setpos('.', pos_save)
   endtry
endfunction
command! -nargs=0 RemoveUnwantedSpaces call RemoveUnwantedSpaces()
" }}}

" END invisibles }}}


" Tab {{{

" Tab KeyMaps {{{
nnoremap t; t
nmap t <nop>
nnoremap tl gt
nnoremap th gT
nnoremap to :<C-u>edit<Space>
nnoremap tt :<C-u>tabnew<Space>
nnoremap <silent> td :<C-u>tabclose<CR>

nnoremap <silent> t] :<C-u>buffer<CR>
nnoremap <silent> tn :<C-u>bnext<CR>
nnoremap <silent> tp :<C-u>bprevious<CR>
nnoremap <silent> tD :<C-u>bdelete<CR>
nnoremap <silent> tL :<C-u>buffers<CR>
" }}}

" Tab jump {{{
for n in range(1, 9)
   execute 'nnoremap <silent> t'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" }}}

" MoveToNewTab {{{
" http://www.sopht.jp/blog/index.php?/archives/445-vim.html
nnoremap <silent> tm :<C-u>call <SID>MoveToNewTab()<CR>
function! s:MoveToNewTab()
   tab split
   tabprevious

   if winnr('$') > 1
      close
   elseif bufnr('$') > 1
      buffer #
   endif

   tabnext
endfunction
"}}}

" Tab Help {{{
command! -nargs=? Ht  tab help <args>
command! -nargs=? Hv  vertical belowright help <args>
nnoremap <Space>t :<C-u>tab help<Space>
nnoremap <Space>v :<C-u>vertical belowright help<Space>
" }}}

" TabLine {{{
set tabline=%!MakeTabLine()

function! MakeTabLine()
   let s = ''

   for n in range(1, tabpagenr('$'))
      if n == tabpagenr()
         let s .= '%#TabLineSel#'
      else
         let s .= '%#TabLine#'
      endif

      let s .= '%' . n . 'T'

      let s .= ' %{MakeTabLabel(' . n . ')} '

      let s .= '%#TabLineFill#%T'
      let s .= '|'
   endfor

   let s .= '%#TabLineFill#%T'
   let s .= '%=%#TabLine#'
   let s .= '%{fnamemodify(getcwd(), ":~:h")}%<'
   return s
endfunction

function! MakeTabLabel(n)
   let bufnrs = tabpagebuflist(a:n)
   let bufnr = bufnrs[tabpagewinnr(a:n) - 1]

   let bufname = bufname(bufnr)
   if bufname == ''
      let bufname = '[No Name]'
   else
      let bufname = fnamemodify(bufname, ":t")
   endif

   let no = len(bufnrs)
   if no == 1
      let no = ''
   endif

   let mod = len(filter(bufnrs, 'getbufvar(v:val, "&modified")')) ? '+' : ''
   let sp = (no . mod) == '' ? '' : ' '

   let s = no . mod . sp . bufname
   return s
endfunction " }}}

" Close all right tabs.
function! CloseAllRightTabs()
   let current_tabnr = tabpagenr()
   let last_tabnr = tabpagenr("$")
   let num_close = last_tabnr - current_tabnr
   let i = 0
   while i < num_close
      execute "tabclose " . (current_tabnr + 1)
      let i = i + 1
   endwhile
endfunction
nnoremap <silent> <C-t>dl :<C-u>call CloseAllRightTabs()<CR>

" Close all left tabs.
function! CloseAllLeftTabs()
   let current_tabnr = tabpagenr()
   let num_close = current_tabnr - 1
   let i = 0
   while i < num_close
      execute "tabclose 1"
      let i = i + 1
   endwhile
endfunction
nnoremap <silent> <C-t>dh :<C-u>call CloseAllLeftTabs()<CR>

" END Tabs }}}



" Search highlight off
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>:call Cancel()<CR>
nnoremap <silent> <C-n> :<C-u>nohlsearch<CR>:call Cancel()<CR>

" File rename command
function! RenameMe(newFileName)
   let currentFileName = expand('%')
   execute 'saveas ' . a:newFileName
   call delete(currentFileName)
endfunction
command! -nargs=1 RenameMe call RenameMe(<q-args>)

" にゃーん ~(=^･ω･^)
map <silent> neko :Neko<CR>

" 戦闘力
command! MyScouter Scouter ~/.vim/.vimrc ~/.vim/.gvimrc

" END Mappings }}}


" Plugin Settings {{{===============================================================
" unite.vim

" fugitive
" Space × 2 is :Git
nnoremap [Git] <Nop>
nmap <Space> [Git]
nnoremap [Git]<Space> :<C-u>Git<Space>
nnoremap [Git]<CR> :<C-u>Git<Space>

nnoremap [Git]s :<C-u>Gstatus<CR>
nnoremap [Git]d :<C-u>Gdiff<CR>
nnoremap [Git]a :<C-u>Gwrite<CR>
nnoremap [Git]A :<C-u>Git add -A<CR>
nnoremap [Git]c :<C-u>Gcommit -v<CR>
nnoremap [Git]C :<C-u>Gcommit --amend<Space>
nnoremap [Git]p :<C-u>Git push<CR>
nnoremap [Git]f :<C-u>Git fetch<CR>
nnoremap [Git]F :<C-u>Git pull --rebase<CR>
nnoremap [Git]b :<C-u>Gblame<CR>
