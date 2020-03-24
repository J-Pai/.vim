" Plugin Manager
call plug#begin('~/.vim/plugins')
" Add Plugins here...
Plug 'tpope/vim-sensible'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'idanarye/vim-merginal'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdtree'
Plug 'editorconfig/editorconfig-vim'
Plug 'shime/vim-livedown'
Plug 'elzr/vim-json'
Plug 'Yggdroot/indentLine'

" Color Themes
Plug 'flazz/vim-colorschemes'

" Completion Plugins
if has('nvim')
    Plug 'autozimu/LanguageClient-neovim', {
                \ 'branch': 'next',
                \ 'do': 'bash install.sh',
                \ }

    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

" FZF Fuzzy Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language Plugins
Plug 'alvan/vim-closetag'
Plug 'sheerun/vim-polyglot'
Plug 'duganchen/vim-soy'

" Terminal Plugin
Plug 'kassio/neoterm'
call plug#end()

scriptencoding utf-8
set encoding=utf-8
syntax enable
set conceallevel=0
" Shared System Clipboard
set clipboard=unnamedplus

" Color Scheme
set t_Co=256
colorscheme molokai
let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'ct', 'gitbranch', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head',
            \   'ct': 'CtClient'
            \ },
            \ }
if has("termguicolors")
    set termguicolors
endif
let &t_ut=''
set hlsearch
if has('nvim')
    set inccommand=nosplit
endif

" Sessions
set sessionoptions=buffers

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
set tabstop=2
set shiftwidth=2

" File type specific tabbing
" autocmd BufNewFile,BufRead *.jsx setlocal tabstop=2 shiftwidth=2
" Comment line above and uncomment line below to set all JS type files to
" tabbing of 2 spaces.
" autocmd FileType javascript setlocal tabstop=2 shiftwidth=2

" Special File Indenting
au FileType markdown setlocal tabstop=3 shiftwidth=3 tw=80
au BufNewFile,BufRead *.go setlocal noexpandtab
au BufNewFile,BufRead *.mk setlocal expandtab
au FileType vim setlocal tabstop=4 shiftwidth=4
" Special Syntax Highlighting
au BufNewFile,BufRead *.gstol set syntax=stol "noexpandtab
au BufNewFile,BufRead Jenkinsfile setf groovy
au BufNewFile,BufReadPost *.{yaml,yml,j2} set filetype=yaml
au BufNewFile,BufRead BUILD setlocal tabstop=4 shiftwidth=4
au BufNewFile,BufRead *Makefile* set syntax=make noexpandtab

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
    tnoremap <C-w> <C-\><C-n><C-w>
    tnoremap <LeftRelease> <LeftRelease>a
endif

if exists(':terminal')
    let g:neoterm_autoinsert = 1
    let g:neoterm_default_mod = "rightbelow"
    let g:neoterm_autoscroll = 1
    let g:neoterm_term_per_tab = 1
    map <C-s> :Tnew <CR>
    " Set terminal options
    autocmd BufWinEnter,WinEnter term://* startinsert
endif

" Show Invisibles
set list listchars=tab:>\ ,trail:·,eol:¬

let g:python_host_prog = '/usr/bin/python'

" Remove trailing whitespace on save
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

if filereadable(expand('~/.vim/plugins/vim-closetag/README.md'))
    let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb,*.jsx,*.js,*.soy'
    let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.erb,*.js,.*.soy'
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

    let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
    let g:deoplete#sources#clang#clang_header = '/usr/include/clang/'
    let g:deoplete#sources#rust#racer_binary = '/usr/bin/racer'
    let g:deoplete#sources#rust#rust_source_path = '/usr/src/rust/src/'

    if !exists('g:deoplete#omni#input_patterns')
        let g:deoplete#omni#input_patterns = {}
    endif

    set completeopt-=preview
endif

if filereadable(expand('~/.vim/plugins/LanguageClient-neovim/README.md'))
    let g:LanguageClient_autoStart = 1

    if getcwd() =~ "^/google"
        let g:LanguageClient_serverCommands = {
            \ 'go': [$LSP, '--tooltag=vim-lsc', '--noforward_sync_responses'],
            \ 'proto': [$LSP, '--tooltag=vim-lsc', '--noforward_sync_responses'],
            \ 'cpp': [$LSP, '--tooltag=vim-lsc', '--noforward_sync_responses'],
            \ 'java': [$LSP, '--tooltag=vim-lsc', '--noforward_sync_responses'],
            \ 'javascript': [$LSP, '--tooltag=vim-lsc', '--noforward_sync_responses'],
            \ }
    else
        let g:LanguageClient_serverCommands = {}
    endif
    let g:LanguageClient_diagnosticsDisplay = {
        \   1: { 'signText': 'X' },
        \   2: { 'signText': '!' },
        \   3: { 'signText': 'i' },
        \   4: { 'signText': '>' },
        \}
    command Def execute "call LanguageClient#textDocument_definition({'gotoCmd': 'split'})"
    set signcolumn=yes
endif

if filereadable(expand('~/.vim/plugins/nerdtree/README.markdown'))
    map <C-p> :NERDTreeToggle<CR>
    let g:NERDTreeNodeDelimiter = "\u00a0"
    let NERDTreeShowHidden=1
endif

if filereadable(expand('~/.vim/plugins/vim-jsx/README.md'))
    let g:jsx_ext_required = 0
endif

if filereadable(expand('~/.vim/plugins/indentLine/README.md'))
    let g:indentLine_fileTypeExclude = ['json', 'markdown']
endif

if filereadable(expand('~/.vim/plugins/fzf.vim/README.md'))
    command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
    command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
endif

" Function for stripping whitespace
function! <SID>StripTrailingWhitespaces()
    let l = line('.')
    let c = col('.')
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Function for obtaining CITC Client
function CtClient()
    let client = matchstr(getcwd(), $GOOG.$USER.'/\zs.\{-}\ze/')
    if !empty(client)
        return client
    endif
    return ''
endfunction

" Disable Yank after Paste
vnoremap p "_dP

set exrc
set secure
