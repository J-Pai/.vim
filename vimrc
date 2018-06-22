scriptencoding utf-8
set encoding=utf-8
syntax on
set t_Co=256
set conceallevel=0

" Color Scheme
colorscheme molokai
hi Normal guibg=NONE ctermbg=NONE

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

" Generic tabbing.
set tabstop=4
set shiftwidth=4

" File type specific tabbing
autocmd BufNewFile,BufRead *.jsx setlocal tabstop=2 shiftwidth=2
" Comment line above and uncomment line below to set all JS type files to
" tabbing of 2 spaces.
" autocmd FileType javascript setlocal tabstop=2 shiftwidth=2

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
    map <C-s> :split <bar> :set nonumber <bar> terminal <CR> <Insert>
endif

" Show Invisibles
set list listchars=tab:>\ ,trail:·,eol:¬

set pastetoggle=<F2>
let g:python_host_prog = '/usr/bin/python'

" Remove trailing whitespace on save
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Plugin Manager
call plug#begin('~/.vim/plugins')
" Add Plugins here...
Plug 'tpope/vim-sensible'
Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-fugitive'
Plug 'idanarye/vim-merginal'
Plug 'vim-airline/vim-airline'

" JavaScript Plugins
Plug 'alvan/vim-closetag'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'jparise/vim-graphql'

" Completion Plugins
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()

if filereadable(expand('~/.vim/plugins/vim-airline/README.md'))
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
endif

if filereadable(expand('~/.vim/plugins/vim-closetag/README.md'))
    let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb,*.jsx,*.js"
    let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.erb,*.js'
    let g:closetag_emptyTags_caseSensitive = 1
    let g:closetag_shortcut = '>'
    let g:closetag_close_shortcut = '<leader>>'
endif

if filereadable(expand('~/.vim/plugins/deoplete.nvim/README.md'))
    let g:deoplete#enable_at_startup = 1
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
endif

function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

set exrc
set secure
