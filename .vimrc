" 基本設定
syntax on   " シンタックスハイライトを有効化
filetype plugin indent on   " ファイルタイプに基づいたインデントを有効科
set fenc=utf-8  " 文字コードをUTF-8に設定
colorscheme elflord   " カラースキームを変更
set directory=$HOME/.vim/swap// " すべてのswapファイルが同じディレクトリに置かれるようにする
let g:ctrlp_working_path_mode = 'ra'   " CtrlpがGitのルートをワーキングディレクトリとして使うようにする
set tags=tags;  " 親ディレクトリにあるtagsファイルを再帰的に探す
set title  " タイトルを表示
set history=10000 " コマンドラインの履歴を10000件保存

" すべてのファイルについてUndoを永続化し、Undoファイルを一つのディレクトリにまとめる
set undofile
if !isdirectory(expand("$HOME/.vim/undodir"))
    call mkdir(expand("$HOME/.vim/undodir"), "p")
endif
set undodir=$HOME/.vim/undodir

" エディタ
set autoindent  " 新しい行を始めるときに自動でインデント
set expandtab   " タブをスペースに変換
set tabstop=2   " タブをスペース4文字とカウント
set shiftwidth=2    " 自動インデントに使われるスペースの数
set backspace=2 " 多くのターミナルでバックスペースの挙動を修正
set background=dark    " テーマをdarkに変更
set foldmethod=indent   " 折り畳みをindentで設定
" ファイルを開いたときに折り畳みを開いた状態にする
autocmd BufRead * normal zR 
set number    " 行番号を表示する
set clipboard=unnamed,unnamedplus   " システムのクリップボードにコピー
set laststatus=2    " 常にステータスラインを表示する
set showcmd " 最後に実行したコマンドをステータスラインに表示する
set cursorline    " カーソル行をハイライトする
set cursorcolumn    " カーソル列をハイライトする
set ruler   " ルーラーを表示
set linebreak   " 行を折り返す
set display+=lastline    "長い行を整形
set virtualedit=onemore " 行末の1文字先までカーソルを移動可能にする
set visualbell  " ピープ音を可視化
set showmatch   " カッコを入力時に対応するカッコを表示する
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-

" 検索
set ignorecase  " 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase   " 検索文字列に大文字が含まれている場合は区別して検索する
set hlsearch    " 検索結果のマッチをハイライトする
set incsearch   " タイプするたびに動的な最初のマッチに移動する
set wrapscan    " 検索時に最後まで行ったら最初に戻る

" 言語設定
"" Python
autocmd BufWritePost *.cpp,*.h silent! !ctags -R &  " Pythonファイルを保存するたびにctags -Rを実行

" パッケージ
packloadall " すべてのプラグインをロードする
silent! helptags ALL    " すべてのプラグイン用にヘルプファイルをロードする

" キーマップ
"" split / vsplit
"" コントロールキーとhjklで分割されたウインドウ間を移動する
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>

"" コロンをセミコロンに変更
nnoremap ; :
vnoremap ; :

" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>

" ファイルツリーの移動
set wildmenu    " タブによる自動補完を有効にする
set wildmode=list:longest,full  " 最長マッチまで保管してから自動補完メニューを開く
let NERDTreeShowBookmarks = 1   " 起動時にブックマークを自動表示
autocmd VimEnter * NERDTree " Vim起動時にNERDTreeを開く
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
            \b:NERDTree.isTabTree()) | q | endif    " NERFTreeのウインドウしか開かれていないときは自動で閉じる

" vim-plugでプラグインを管理
call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-vinegar'
Plug 'kien/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'junegunn/vim-plug'
let g:plug_timeout = 300    " YouCompleteMeはコンパイルに時間がかかるため、タイムアウトを設定
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
Plug 'sjl/gundo.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-dispatch'
Plug 'vim-test/vim-test'
Plug 'vim-syntastic/syntastic'
Plug 'NLKNguyen/papercolor-theme'

" Git
Plug 'airblade/vim-gitgutter'

" Ruby
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'w0rp/ale'

" HTML
Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'

" Terraform
Plug 'hashivim/vim-terraform'
Plug 'vim-syntastic/syntastic'
Plug 'juliosueiras/vim-terraform-completion'

call plug#end()

" vim-plugがまだインストールされていなければインストールする
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

packloadall " すべてのプラグインをロードする
silent! helptags ALL    " すべてのヘルプをロードする

" YouCompleteMe
noremap <leader>] :YcmCompleter GoTo<cr>

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_python_pylint_exe = 'pylint3'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Powerline
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

" RSense
let g:rsenseHome = expand("/Users/$USER/.rbenv/shims/rsense")
let g:rsenseUseOmniFunc = 1

" Terraform
let g:terraform_fmt_on_save = 1 " ファイル保存時の自動フォーマットを有効にする

