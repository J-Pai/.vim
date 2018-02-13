scriptencoding utf-8
set encoding=utf-8
syntax on
set t_Co=256
set conceallevel=0

" Color Scheme
colorscheme molokai
hi Normal guibg=NONE ctermbg=NONE
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
set list listchars=tab:>\ ,trail:·,eol:¬

set pastetoggle=<F2>
let g:python_host_prog = '/usr/bin/python'

" Plugin Manager
call plug#begin('~/.vim/plugins')
" Add Plugins here...
Plug 'tpope/vim-sensible'
Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine'
Plug 'rust-lang/rust.vim'
Plug 'leafgarland/typescript-vim'
Plug 'alvan/vim-closetag'
" Plug 'Valloric/YouCompleteMe'

call plug#end()

if filereadable(expand('~/.vim/plugins/YouCompleteMe/README.md'))
    nnoremap <leader>j :split <bar> YcmCompleter GoTo<CR>
endif

if filereadable(expand('~/.vim/plugins/vim-closetag/README.md'))
    let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb,*.jsx"
    let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.erb'
    let g:closetag_emptyTags_caseSensitive = 1
    let g:closetag_shortcut = '>'
    let g:closetag_close_shortcut = '<leader>>'
endif
