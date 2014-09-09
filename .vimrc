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

call pathogen#infect()


" -----------------------------------------------------------------------------
" General
" -----------------------------------------------------------------------------

let mapleader=","

syntax on
filetype plugin indent on
syntax enable

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

" Strip trailing whitespace on save for specified file types.
autocmd BufWritePre *.css,*.html,*.js,*.json,*.md,*.py,*.rb,*.sh,*.txt
    \ :call StripTrailingWhitespace()

" Use tabs in Makefile
autocmd filetype make setlocal noexpandtab

" Auto reload vimrc when editing it.
autocmd! bufwritepost .vimrc source ~/.vimrc

" -----------------------------------------------------------------------------
" Key Mappings
" -----------------------------------------------------------------------------

" Strip trailing whitespace (,$)
noremap <leader>$ :call StripTrailingWhitespace()<CR>

" Map :W to :w and :Q to :q, etc.
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('q'))
cnoreabbrev <expr> X ((getcmdtype() is# ':' && getcmdline() is# 'X')?('x'):('x'))

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

