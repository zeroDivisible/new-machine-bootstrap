set nocompatible

" vundle settings.
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" original repos on GitHub
Bundle 'kien/ctrlp.vim'
Bundle 'Shougo/neocomplete.vim'
Bundle 'derekprior/vim-colorpack'
Bundle 'flazz/vim-colorschemes'
Bundle 'scrooloose/syntastic'
Bundle 'zeroDivisible/gocode-vim'
Bundle 'mhinz/vim-startify'
Bundle 'dgryski/vim-godef'
Bundle 'bling/vim-airline'
Bundle 'Pychimp/vim-luna'
Bundle 'reedes/vim-colors-pencil'
Bundle 'nanotech/jellybeans.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'Raimondi/delimitMate'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'godlygeek/tabular'
Bundle 'mhinz/vim-signify'
Bundle 'ekalinin/Dockerfile.vim'
Bundle 'guns/vim-clojure-static'
Bundle 'tpope/vim-fireplace'
Bundle 'tpope/vim-leiningen'
Bundle 'rizzatti/dash.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'majutsushi/tagbar'

" not always needed
" ruby / rails
"Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'

" node / js
" Bundle 'ahayman/vim-nodejs-complete'

" javascript
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'


filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim

" required for vundle and go plugins and a nice settings to have.
filetype plugin indent on
syntax on

set mouse=a

" basic options
set encoding=utf-8
set fileformat=unix
set modelines=0

set backupdir=~/.cache/vim/,/tmp
set directory=~/.cache/vim/,/tmp

" indent stuff
set autoindent
set smartindent

set cmdheight=2

set showmode
set showcmd
set hidden

" turning off bell signs
set noerrorbells
set visualbell
set t_vb=
autocmd VimEnter * set t_vb=
autocmd! GuiEnter * set t_vb=

set cursorline
set ttyfast
set ruler
set backspace=eol,start,indent
set number
set relativenumber
set laststatus=2
set undofile
set history=10000
set undoreload=10000
set shell=/bin/zsh
set lazyredraw
set matchtime=3
set splitbelow splitright
set ttimeout
set notimeout
set autowrite autoread
set shiftround
set formatoptions=crql
set title
set foldmethod=marker
set dictionary=/usr/share/dict/words

set completeopt+=menuone
set completeopt-=preview

" wild menu
set wildmenu
set wildmode=list:longest,full

set wildignore+=*/.hg/*,*/.git/*,*/.svn/*
set wildignore+=.pyc
set wildignore+=.class
set wildignore+=.jpg
set wildignore+=.png
set wildignore+=.gif
set wildignore+=.jar
set wildignore+=.swp
set wildignore+=*/build/*
set wildignore+=*/node_modules/*

" Toggle search highlighting
nmap <silent> <C-l> :set invhlsearch<CR>

" immproved indenting
vnoremap < <gv
vnoremap > >gv

" allows using the repeat operator with visual selection
vnoremap . :normal .<CR>

" tabs and spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set wrap
set formatoptions=qrnl

" highlight 120th character in given line
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%120v', 100)

let mapleader=","
let maplocalleader="\\"

au VimResized * exe "normal! \<c-w>="

set complete=.,w,b,u,U,t,i,d

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault

set scrolloff=3
set sidescroll=1
set sidescrolloff=10
set virtualedit+=block

" repeat last macro with capital Q
map Q @@

" automatically cd into the directory that the file is in
autocmd BufEnter * execute "cd ".escape(expand("%:p:h"), ' ')

"Use [RO] for [readonly]
set shortmess-=atI
set shortmess+=r

let xml_use_xhtml=1

"cursor options
set gcr=a:blinkwait500-blinkon9300-blinkoff150

"keyboard shortcuts
noremap j gj
noremap k gk

inoremap jj <Esc>

" 256 colours
set t_Co=256

color osx_like
" different font from gvim
if has("gui_running")
  set mousefocus " focus follows mouse
  set guioptions-=T
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L

  set guifont=PT\ Mono:h12
endif

" =============================================================================
" Filetypes and Custom Autocmds
"
" =============================================================================
"
" Some file types use real tabs
au FileType {make,gitconfig} set noexpandtab sw=4

" Treat JSON files like JavaScript
au BufNewFile,BufRead *.json setf javascript

" Make Python follow PEP8
au FileType python set sts=4 ts=4 sw=4 tw=79

" Make sure all markdown files have the correct filetype
au BufRead,BufNewFile *.md setf markdown
au BufRead,BufNewFile *.markdown setf markdown
au BufRead,BufNewFile *.dockerfile setf Dockerfile

" MultiMarkdown requires 4-space tabs
au FileType markdown set sts=4 ts=4 sw=4

" Use 4-space tabs for apache
au FileType apache set sts=4 ts=4 sw=4

" autoformat xml with xmllint and gg=G
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" Associate groove as the language for gradle build files
au BufNewFile,BufRead *.gradle setf groovy

" spellcheck commit message
au BufRead COMMIT_EDITMSG setlocal spell!

" remove trailing whitespace on save and save cursor position
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

au FileType c,cpp,java,php,ruby,python,.vimrc,md,markdown autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" make sure vim returns to the same line once you reopen the file
augroup line_return
  au!
  au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" lets deal with large files
" Protect large files from sourcing and other overhead.
" " Files become read only
if !exists("large_file_fix_shit")
  let large_file_fix_shit = 1
  " Large files are > 50M
  " Set options:
  " eventignore+=FileType (no syntax highlighting etc
  " assumes FileType always on)
  " noswapfile (save copy of file)
  " bufhidden=unload (save memory when other file is viewed)
  " buftype=nowritefile (is read-only)
  " undolevels=-1 (no undo possible)
  let g:LargeFile = 1024 * 1024 * 50
  augroup LargeFile
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
  augroup END
endif

" plugins
" neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#force_overwrite_completefunc = 1

let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
      \ }

if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif

let g:neocomplete#keyword_patterns['default'] = '\h\w*'

noremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
inoremap <expr><C-g>  neocomplete#undo_completion()
inoremap <expr><C-l>  neocomplete#complete_common_string()

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

function! s:my_cr_function()
  return neocomplete#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "   "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType go setlocal omnifunc=gocomplete#Complete
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

autocmd FileType ruby let g:rubycomplete_buffer_loading=1
autocmd FileType ruby let g:rubycomplete_classes_in_global=1

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.go = '\h\w*'
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

" build with F5
au Filetype go set makeprg=go\ build\ ./...
nmap <F5> :make<CR>:copen<CR>


" CtrlP
map <Leader>e :CtrlPMRU<CR>
nmap <Leader>t :CtrlP .<CR>
nmap <Leader>r :CtrlP
nmap ; :CtrlPBuffer<CR>

" remap default ctrlp setting to leader t
let g:ctrlp_working_path_mode='ra'
let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_show_hidden=1
let g:ctrlp_mruf_max=500

let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0

let g:ctrlp_mruf_exclude='/tmp/.*\|/temp/.*'
let g:ctrlp_mruf_exclude+='/build/tmp/*'
let g:ctrlp_mruf_exclude+='.*.un~'

let g:ctrlp_user_command={
      \ 'types': {
      \ 1: ['.git', 'cd %s && git ls-files'],
      \ 2: ['.hg', 'hg --cwd %s locate -I .'],
      \ },
      \ 'fallback': 'find %s -type f'
      \ }

let g:ctrlp_reuse_window = 'startify'

let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|class|pyc|wav|un~|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0

" godef
" open definitions in new tab
let g:godef_split=2
" .. but reuse the same window for things in the same file
let g:godef_same_file_in_same_window=1

" startify
" custom indices
let g:startify_custom_indices = ['a', 'd', 'f', 'g', 'h', 'n']

let g:startify_custom_header = [
      \ '.: vim',
      \ '' ]

autocmd FileType startify setlocal nocursorline

let g:startify_skiplist = [
      \ 'COMMIT_EDITMSG',
      \ '^/tmp',
      \ '.*.un\~',
      \ '.+/MERGE_MSG$',
      \ '.+/COMMIT_EDITMSG$',
      \ $VIMRUNTIME .'/doc',
      \ 'bundle/.*/doc',
      \ '\.DS_Store'
      \ ]

" use F1 to start startify
:nmap <F1> :Startify<CR>

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='powerlineish'              " airline users use the powerline theme
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" syntastic
let g:syntastic_javascript_checkers = ['jshint']

let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" dash
map <Leader>b :Dash<CR>

" tagbar
nmap <F8> :TagbarOpen jf<CR>
nmap <F2> :TagbarToggle<CR>

let g:tagbar_type_go = {  
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" clojure
let g:clojure_syntax_keywords = {
    \ 'clojureMacro': ["defproject", "defcustom"],
    \ 'clojureFunc': ["string/join", "string/replace"]
    \ }

let g:clojure_maxlines = 100

let g:clojure_align_multiline_strings = 1
