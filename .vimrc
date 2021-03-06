" -----------------------------------------------------------------------------
" Table of Contents:
"
" - Setup
" - General
" - UI/UX
" - Key Mappings
" - Plugin Settings
" - Functions
"
" -----------------------------------------------------------------------------


" -----------------------------------------------------------------------------
" Setup
" -----------------------------------------------------------------------------

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()


" -----------------------------------------------------------------------------
" General
" -----------------------------------------------------------------------------

let mapleader=","

syntax on
filetype plugin indent on
syntax enable

" Remove most autoindentation for HTML files.
autocmd FileType html setlocal nocindent nosmartindent indentexpr=

set hidden

" Centralize backups, swapfiles and undo history
set backupdir=$HOME/.vim/backups
set directory=$HOME/.vim/swaps
if exists("&undodir")
    set undodir=$HOME/.vim/undo
endif
set viminfo+=n$HOME/.vim/.viminfo


" -----------------------------------------------------------------------------
" UI/UX
" -----------------------------------------------------------------------------

set ruler
set cursorline
set number

set textwidth=78
set colorcolumn=80

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=4
set list lcs=trail:·,tab:»·

" Start scrolling seven lines before the horizontal window border
set scrolloff=7

" Strip trailing whitespace on save for specified file types.
autocmd BufWritePre *.css,*.html,*.js,*.json,*.md,*.py,*.rb,*.sh,*.txt
    \ :call StripTrailingWhitespace()

" Use tabs in Makefile
autocmd filetype make setlocal noexpandtab

" Auto reload vimrc when editing it.
autocmd! bufwritepost .vimrc source ~/.vimrc

" Set to auto read when a file is changed from the outside.
set autoread

" Enable the mouse (if you want it).
set mouse=a

"Always show current position
set ruler

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" Yank to the system register (*) by default.
set clipboard=unnamed

" -----------------------------------------------------------------------------
" Key Mappings
" -----------------------------------------------------------------------------

" Strip trailing whitespace (,$)
noremap <leader>$ :call StripTrailingWhitespace()<CR>

" Map :W to :w and :Q to :q, etc.
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('q'))
cnoreabbrev <expr> X ((getcmdtype() is# ':' && getcmdline() is# 'X')?('x'):('x'))

" Toggle spell checking on and off.
map <leader>ss :setlocal spell!<cr>

" Toggle paste mode on and off.
map <leader>pp :setlocal paste!<cr>

" Toggle comments.
map <leader>/ :Commentary<cr>

" -----------------------------------------------------------------------------
" Plugin Settings
" -----------------------------------------------------------------------------

" vim-colors-solarized
" --------------------
let g:solarized_termtrans = 1
set background=dark
colorscheme solarized

" nerdtree
" --------
map <Leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 &&
    \ exists("b:NERDTreeType") &&
    \ b:NERDTreeType == "primary") | q | endif

" vim-easymotion
" --------------
let g:EasyMotion_do_mapping = 0 " Disable default mappings
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" vim-markdown
" ------------
let g:vim_markdown_folding_disabled=1

" git-gutter
" ---------
" Fix a color conflict with solarized.
" https://github.com/airblade/vim-gitgutter/issues/164
hi clear SignColumn

" -----------------------------------------------------------------------------
" Functions
" -----------------------------------------------------------------------------

" Use the Tab key for autocompletion.
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"

" Strip trailing whitespace.
func! StripTrailingWhitespace()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfun

