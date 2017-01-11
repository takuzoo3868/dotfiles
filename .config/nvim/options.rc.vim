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
" 補完候補をリスト表示
set wildmenu
" コマンドラインの表示行数
set cmdheight=2
" コマンドウィンドウの表示行数
set cmdwinheight=4

" マウス操作も許してあげる
set mouse=a

" ステータスラインを常に表示
set laststatus=2

" タブ幅の設定
set tabstop=2
" \tの幅
set shiftwidth=2
" 自動インデント
set autoindent
set smarttab
" タブをスペースに変える
set expandtab
" 貼り付けモードとの切り替え
set pastetoggle=<C-E>
" カーソルが端まで来たら次の行に飛ばす
set whichwrap=b,s,h,l,<,>,[,],~
" マッピング受付時間
set timeout
set timeoutlen=1000
" キーコード受付時間
set ttimeoutlen=300
" backspaceの有効化
set backspace=indent,eol,start
