let ssh = $SSH_TTY

" Plugin Manager
call plug#begin('~/.vim/plugins')
" vim and nvim Common Plugins
Plug 'itchyny/lightline.vim' " vim statusbar
Plug 'tpope/vim-fugitive' " git plugin
Plug 'jremmen/vim-ripgrep' " RG plugin
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " File search plugin
Plug 'junegunn/fzf.vim'

if has('nvim')
  " nvim Only Plugins

  " Completion Plugins
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Terminal Plugin
  Plug 'kassio/neoterm'

  " Explorer
  Plug 'francoiscabrol/ranger.vim'
  Plug 'rbgrouleff/bclose.vim'
endif
call plug#end()

if has('nvim')
  " nvim Only Settings

  " Terminal Settings (neoterm + vanilla)
  if filereadable(expand('~/.vim/plugins/neoterm/README.md'))
    let g:neoterm_autoinsert = 1
    let g:neoterm_default_mod = ':belowright'
    let g:neoterm_autoscroll = 1
  endif

  " Map Esc to exit term mode
  tnoremap <Esc> <C-\><C-n>
  " Map move buffer cmd to exit term mode
  tnoremap <C-w> <C-\><C-n><C-w>
  " Make clicking a term buffer startinsert
  tnoremap <LeftRelease> <LeftRelease>a
  " Open new terminal in same directory as current file.
  nnoremap <silent><C-s> :lcd %:h \| Tnew <CR>
  "
  autocmd BufWinEnter,WinEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
  autocmd TermEnter term://* setlocal nonumber norelativenumber

  " Special configuration for neovim-remote
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  let $HGEDITOR = 'nvr -cc split --remote-wait'
  let $EDITOR = 'nvr -cc split --remote-wait'
  autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
  autocmd FileType hgcommit,hgrebase,hgconfig set bufhidden=delete

  " PLUGIN(coc.nvim)
  if filereadable(expand('~/.vim/plugins/coc.nvim/Readme.md'))
    " TextEdit might fail if hidden is not set.
    set hidden

    let g:coc_disable_startup_warning = 1
    let g:coc_global_extensions = [
          \   'coc-json',
          \   'coc-vimlsp',
          \   'coc-cmake',
          \   'coc-clangd',
          \   'coc-go',
          \   'coc-rust-analyzer',
          \ ]

    " coc-settings.json
    if getcwd() =~ '^/google'
      let g:coc_user_config = {
            \   'languageserver': {
            \     'google': {
            \       'command': '/google/bin/releases/cider/ciderlsp/ciderlsp',
            \       'args': [
            \         '--tooltag=coc-nvim',
            \         '--noforward_sync_responses',
            \       ],
            \       'filetypes': [
            \         'c',
            \         'cc',
            \         'cpp',
            \         'go',
            \         'java',
            \         'proto',
            \         'python',
            \         'textproto',
            \         'bzl',
            \         'borg',
            \         'starlark',
            \         'js',
            \       ],
            \     },
            \   },
            \ }
    else
      let g:coc_user_config = {
            \   'languageserver': {
            \     'python': {
            \       'command': '~/.local/bin/pyls',
            \       'filetypes': ['python'],
            \     },
            \   },
            \   'rust-analyzer.checkOnSave.allTargets': v:false,
            \   'rust-analyzer.checkOnSave.extraArgs': [
            \       '--bins',
            \   ]
            \ }
    endif
    let g:coc_user_config['diagnostic.errorSign'] = '>'
    let g:coc_user_config['diagnostic.warningSign'] = '!'
    let g:coc_user_config['diagnostic.infoSign'] = '>'
    let g:coc_user_config['diagnostic.hintSign'] = '>'

    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    inoremap <silent><expr> <c-space> coc#refresh()

    if exists('*complete_info')
      inoremap <expr> <cr> complete_info()['selected'] != '-1' ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    nnoremap <silent> gd :split<CR><Plug>(coc-definition)
    nnoremap <silent> ]g <Plug>(coc-diagnostic-next)
    nnoremap <silent> [g <Plug>(coc-diagnostic-prev)

    command! Def call CocActionAsync('jumpDefinition', 'split')
    command! Ref call CocActionAsync('jumpReferences')
    command! HdrSrc CocCommand clangd.switchSourceHeader
    command! DiagToggle call CocActionAsync('diagnosticToggle')

    command! Doc call <SID>ShowDocumentation()
    function! s:ShowDocumentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocActionAsync('doHover')
      endif
    endfunction
  endif

  " PLUGIN(ranger) Settings
  if filereadable(expand('~/.vim/plugins/ranger.vim/README.md')) && has('nvim')
    let g:ranger_replace_netrw = 1
  endif
endif

" Common Settings and Functions
colorscheme pablo
set encoding=utf-8
set mouse=a " Enable mouse usage
if !has('nvim')
  set ttymouse=sgr
endif
set number " Show line numbers
set cmdheight=2 " Use 2 rows for cmd window
set list listchars=tab:>\ ,trail:·,eol:¬ " Show Invisibles Charaters
set synmaxcol=256 " Keep big files loading fast by limiting syntax highlighting

" Mainly for coc.nvim, but also helpful for systems with limited storage.
set nobackup
set nowritebackup

" Popup Menu Settings
highlight Pmenu ctermbg=0 ctermfg=white

" Disable Yank after Paste
vnoremap p "_dP

" EoL Marker
set colorcolumn=80
highlight ColorColumn ctermbg=DarkGray

" Standard Tabbing (2 spaces)
set tabstop=2
set shiftwidth=2
set expandtab " Use spaces for tabs.

autocmd BufNewFile,BufRead BUILD,*.bzl setlocal tabstop=4 shiftwidth=4 expandtab

" Split Control
set splitbelow
set splitright

" Rules for specific file extensions

" Common Functions
" PLUGIN(lightline) Settings
set noshowmode " Turn off showmode since lightline does it automatically.
set laststatus=2 " Need this for vanilla vim
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

" PLUGIN(lightline) Function for obtaining CITC Client
function! CtClient()
  let client = matchstr(getcwd(), $GOOG.$USER.'/\zs.\{-}\ze/')
  if !empty(client)
    return client
  endif
  return ''
endfunction

" AutoCmd for stripping whitespace on close.
autocmd BufWritePre * call <SID>StripTrailingWhitespaces()
" Function for stripping whitespace
function! s:StripTrailingWhitespaces()
  let l = line('.')
  let c = col('.')
  %s/\s\+$//e
  call cursor(l, c)
endfun

function! UseTabChar(width)
  let &tabstop=a:width
  let &shiftwidth=a:width
  set noexpandtab
endfunction

function! UseTabSpace(width)
  let &tabstop=a:width
  let &shiftwidth=a:width
  set expandtab
endfunction

function! UseTabDefault()
  set tabstop=2
  set shiftwidth=2
  set expandtab
endfunction

command! -nargs=1 TabChar call UseTabChar(<f-args>)
command! -nargs=1 TabSpace call UseTabSpace(<f-args>)
command! TabDef call UseTabDefault()

" Combine system clipboard
if empty(ssh)
  set clipboard+=unnamedplus
else
  " Credits go to: https://sunaku.github.io/tmux-yank-osc52.html
  " Yank to SSH/System
  " copy to attached terminal using the yank(1) script:
  " https://github.com/sunaku/home/blob/master/bin/yank
  function! Yank(text) abort
    let escape = system('~/.vim/yank', a:text)
    if v:shell_error
      echoerr escape
    else
      call writefile([escape], '/dev/tty', 'b')
    endif
  endfunction
  noremap <silent> <Leader>y y:<C-U>call Yank(@0)<CR>

  " automatically run yank(1) whenever yanking in Vim
  " (this snippet was contributed by Larry Sanderson)
  function! CopyYank() abort
    call Yank(join(v:event.regcontents, "\n"))
  endfunction
  autocmd TextYankPost * call CopyYank()
endif
