" 起動メッセージ
augroup InitialMessage
  autocmd!
  autocmd VimEnter * echo "(U^w^) < enjoy vimming!"
augroup END

" 行番号表示
set number
" タイトル表示
set title
" ルーラーを表示
set ruler
" タブや改行を表示しない
set nolist
" 対応するカッコのハイライト
set showmatch

" 入力中のコマンドをステータスに表示
set showcmd
" コマンドウィンドウの表示行数
set cmdwinheight=4
" コマンドの履歴の保存数
set history=2000

" マウス操作も許してあげる
set mouse=a
" クリップボードをWindowsと連携
if has('nvim')
  set clipboard+=unnamedplus
else
  set clipboard=unnamed,autoselect
endif

" ステータスラインを常に表示
set laststatus=2
" タブページを常に表示
set showtabline=2

" 自動インデント
set autoindent
set smarttab
" タブをスペースに変える
set expandtab
" タブ幅の設定
set tabstop=2
set softtabstop=2
" \tの幅
set shiftwidth=2
" 折り返しの際にインデントを考慮
if exists('+breakindent')
   set breakindent
endif

" backspaceの有効化
set backspace=indent,eol,start

" 外部でファイルが変更されたら自動で読みなおす
set autoread
" 編集情報の記録ファイルを作成しない
set noswapfile
" バックアップファイルを作成しない
set nobackup
set nowritebackup

" 貼り付けモードとの切り替え
set pastetoggle=<C-E>
" カーソルが端まで来たら次の行に飛ばす
set whichwrap=b,s,h,l,<,>,[,],~
" マッピング受付時間
set timeout
set timeoutlen=1000
" キーコード受付時間
set ttimeoutlen=300

" 不要なデフォルトプラグインを停止
let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1

let g:loaded_rrhelper          = 1
let g:loaded_2html_plugin      = 1

let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1

let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1
