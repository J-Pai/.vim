syntax on
set t_Co=256
set conceallevel=0
" Color Scheme

colorscheme molokai
au BufNewFile,BufRead *.ejs set filetype=html

" Basic Setup
set showcmd
set showmatch
set showmode
set number
set ruler
set mouse=a
set formatoptions+=o
set textwidth=0
set expandtab
set tabstop=4
set shiftwidth=4

set splitbelow
set splitright

set colorcolumn=80

if !&scrolloff
    set scrolloff=3
endif
if !&sidescrolloff
    set sidescrolloff=5
endif

if exists(':tnoremap')
    tnoremap <Esc> <C-\><C-n>
endif

if exists(':terminal')
    map <C-s> :terminal <CR>
endif

" Show Invisibles
set listchars=tab:▸\ ,trail:·,eol:¬
set list

" For some unknown reason, quotation marks are hidden in json files.
" This ensures that they are shown.
set conceallevel=0

set pastetoggle=<F2>

" Plugin Manager
call plug#begin('~/.vim/plugins')
" Add Plugins here...
Plug 'tpope/vim-sensible'
Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine'
call plug#end()
