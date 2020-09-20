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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

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
if has('termguicolors')
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
au BufNewFile,BufRead *.gstol setlocal syntax=stol "noexpandtab
au BufNewFile,BufRead Jenkinsfile setf groovy
au BufNewFile,BufReadPost *.{yaml,yml,j2} setf yaml
au BufNewFile,BufRead *.{BUILD,bzl} setlocal tabstop=4 shiftwidth=4
au BufNewFile,BufRead *Makefile* setlocal syntax=make noexpandtab

set splitbelow
set splitright

set cmdheight=2
set updatetime=300
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
set shortmess+=c
set pumwidth=30

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
    let g:neoterm_default_mod = 'rightbelow'
    let g:neoterm_autoscroll = 1
    map <C-s> :Tnew <CR>
    " Set terminal options
    autocmd BufWinEnter,WinEnter term://* startinsert
endif

" Show Invisibles
set list listchars=tab:>\ ,trail:·,eol:¬

let g:python_host_prog = '/usr/bin/python'

" Remove trailing whitespace on save
autocmd BufWritePre * call <SID>StripTrailingWhitespaces()

if filereadable(expand('~/.vim/plugins/vim-closetag/README.md'))
    let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb,*.jsx,*.js,*.soy'
    let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.erb,*.js,.*.soy'
    let g:closetag_emptyTags_caseSensitive = 1
    let g:closetag_shortcut = '>'
    let g:closetag_close_shortcut = '<leader>>'
endif

if filereadable(expand('~/.vim/plugins/coc.nvim/Readme.md'))
    let g:coc_global_extensions = [
        \   'coc-json',
        \   'coc-vimlsp',
        \   'coc-cmake',
        \   'coc-sh'
        \ ]

    " coc-settings.json
    if getcwd() =~ '^/google'
        let g:coc_user_config = {
        \   'languageserver': {
        \     'google': {
        \       'command': '/google/bin/releases/editor-devtools/ciderlsp',
        \       'args': [
        \         '--tooltag=coc-nvim',
        \         '--noforward_sync_responses'
        \       ],
        \       'filetypes': [
        \         'borg',
        \         'c',
        \         'cpp',
        \         'go',
        \         'java',
        \         'proto',
        \         'python',
        \         'textproto',
        \         'bzl'
        \       ]
        \     }
        \   }
        \ }
    else
        let g:coc_user_config = {
        \   'languageserver': {
        \     'python': {
        \       'command': '~/.local/bin/pyls',
        \       'filetypes': ['python']
        \     },
        \     'clangd': {
        \       'command': 'clangd',
        \       'rootPatterns' : ['compile_commands.json'],
        \       'filetypes': ['c', 'cc', 'c++', 'cpp']
        \     }
        \   }
        \ }
    endif

    set signcolumn=number
    inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    if has('nvim')
        inoremap <silent><expr> <c-space> coc#refresh()
    else
        inoremap <silent><expr> <c-@> coc#refresh()
    endif

    if exists('*complete_info')
        inoremap <expr> <cr> complete_info()['selected'] != '-1' ? "\<C-y>" : "\<C-g>u\<CR>"
    else
        inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    nmap <silent> gd :split<CR><Plug>(coc-definition)
    command! Def call CocActionAsync('jumpDefinition', 'split')
    command! Ref call CocActionAsync('jumpReferences')

    command! Doc call <SID>ShowDocumentation()
    function! s:ShowDocumentation()
        if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
        else
            call CocActionAsync('doHover')
        endif
    endfunction
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
    command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
endif

" Function for stripping whitespace
function! s:StripTrailingWhitespaces()
    let l = line('.')
    let c = col('.')
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Function for obtaining CITC Client
function! CtClient()
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
