" Plugin Manager
call plug#begin('~/.vim/plugins')
" Add Plugins here...
Plug 'tpope/vim-sensible'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'idanarye/vim-merginal'
Plug 'itchyny/lightline.vim'
Plug '/usr/local/opt/fzf'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdtree'
Plug 'editorconfig/editorconfig-vim'
Plug 'shime/vim-livedown'
Plug 'elzr/vim-json'
Plug 'Yggdroot/indentLine'

" Color Themes
Plug 'chriskempson/base16-vim'

" Completion Plugins
if has('nvim')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

" Python Plugins
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-clang'

" JavaScript Plugins
" Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
" Plug 'alvan/vim-closetag'
" Plug 'pangloss/vim-javascript'
" Plug 'mxw/vim-jsx'
" Plug 'jparise/vim-graphql'

"Plant UML Plugin
Plug 'aklt/plantuml-syntax'

call plug#end()

scriptencoding utf-8
set encoding=utf-8
syntax enable
set conceallevel=0
" Shared System Clipboard
set clipboard+=unnamedplus

" Color Sche
colorscheme base16-default-dark
let g:lightline = {
    \ 'colorscheme': 'base16-default',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \ }
set termguicolors

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
" autocmd BufNewFile,BufRead *.jsx setlocal tabstop=2 shiftwidth=2
" Comment line above and uncomment line below to set all JS type files to
" tabbing of 2 spaces.
" autocmd FileType javascript setlocal tabstop=2 shiftwidth=2

" Special File Indenting
autocmd FileType markdown setlocal tabstop=3 shiftwidth=3 tw=80
" Special Syntax Highlighting
autocmd BufNewFile,BufRead *.gstol set syntax=stol "noexpandtab
au BufNewFile,BufRead Jenkinsfile setf groovy
au BufNewFile,BufReadPost *.{yaml,yml,j2} set filetype=yaml

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

if filereadable(expand('~/.vim/plugins/vim-closetag/README.md'))
    let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb,*.jsx,*.js"
    let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.erb,*.js'
    let g:closetag_emptyTags_caseSensitive = 1
    let g:closetag_shortcut = '>'
    let g:closetag_close_shortcut = '<leader>>'
endif

if filereadable(expand('~/.vim/plugins/deoplete.nvim/README.md'))
    inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

    inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    let $RUST_SRC_PATH='/usr/src/rust/src'

    " Use deoplete.
    let g:deoplete#enable_at_startup = 1

    let g:deoplete#sources#clang#libclang_path = "/usr/lib/libclang.so"
    let g:deoplete#sources#clang#clang_header ="/usr/include/clang/"
    let g:deoplete#sources#rust#racer_binary="/usr/bin/racer"
    let g:deoplete#sources#rust#rust_source_path="/usr/src/rust/src/"

    if !exists('g:deoplete#omni#input_patterns')
      let g:deoplete#omni#input_patterns = {}
      endif

    set completeopt-=preview
endif

if filereadable(expand('~/.vim/plugins/nerdtree/README.markdown'))
    map <C-o> :NERDTreeToggle<CR>
endif

if filereadable(expand('~/.vim/plugins/vim-json/readme.md'))
    let g:vim_json_syntax_conceal = 0
endif

function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

set exrc
set secure
