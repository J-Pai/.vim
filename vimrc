" Plugin Manager
call plug#begin('~/.vim/plugins')
" vim and nvim Common Plugins
Plug 'itchyny/lightline.vim' " vim statusbar
Plug 'tpope/vim-fugitive' " git plugin

if has('nvim')
  " nvim Only Plugins

  " Completion Plugins
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

  " Terminal Plugin
  Plug 'kassio/neoterm'

  " Explorer
  Plug 'francoiscabrol/ranger.vim'
  Plug 'rbgrouleff/bclose.vim'
endif
call plug#end()

if has('nvim')
  " nvim Only Settings

  " Terminal Settings
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-w> <C-\><C-n><C-w>
  tnoremap <LeftRelease> <LeftRelease>a
  let g:neoterm_autoinsert = 1
  let g:neoterm_default_mod = 'rightbelow'
  let g:neoterm_autoscroll = 1
  map <C-s> :Tnew <CR>
  " Set terminal options
  autocmd BufWinEnter,WinEnter term://* startinsert
  if has('nvim')
    autocmd TermEnter * setlocal nonumber norelativenumber
  endif

  " Special configuration for neovim-remote
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
  let $HGEDITOR = 'nvr -cc split --remote-wait'
  let $EDITOR = 'nvr -cc split --remote-wait'
  autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
  autocmd FileType hgcommit,hgrebase,hgconfig set bufhidden=delete

  " PLUGIN(coc.nvim)
  if filereadable(expand('~/.vim/plugins/coc.nvim/Readme.md'))
    let g:coc_disable_startup_warning = 1
    let g:coc_global_extensions = [
          \   'coc-json',
          \   'coc-vimlsp',
          \   'coc-cmake',
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
            \         'c',
            \         'cc',
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

  " PLUGIN(ranger) Settings
  if filereadable(expand('~/.vim/plugins/ranger.vim/README.md')) && has('nvim')
    let g:ranger_replace_netrw = 1
  endif
endif

" Common Settings and Functions
set encoding=utf-8
set mouse=a " Enable mouse usage
set number " Show line numbers
set cmdheight=2 " Use 2 rows for cmd window
set list listchars=tab:>\ ,trail:·,eol:¬ " Show Invisibles Charaters

" Popup Menu Settings
highlight Pmenu ctermbg=0 ctermfg=white

" Disable Yank after Paste
vnoremap p "_dP

" EoL Marker
set colorcolumn=80
highlight ColorColumn ctermbg=0

" Standard Tabbing (2 spaces)
set tabstop=2
set shiftwidth=2
set expandtab " Use spaces for tabs.

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


" Yank to SSH/System
" Credits go to: https://sunaku.github.io/tmux-yank-osc52.html
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
