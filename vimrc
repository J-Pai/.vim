let ssh = $SSH_TTY

" Plugin Manager
call plug#begin('~/.vim/plugins')
Plug 'itchyny/lightline.vim' " vim statusbar
Plug 'tpope/vim-fugitive' " git plugin
call plug#end()

" Common Settings and Functions
set t_Co=256
set background=dark
colorscheme pablo
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE
set encoding=utf-8
set mouse=a " Enable mouse usage
set number " Show line numbers
set cmdheight=2 " Use 2 rows for cmd window
set list listchars=tab:>\ ,trail:·,eol:¬ " Show Invisibles Charaters
set synmaxcol=256 " Keep big files loading fast by limiting syntax highlighting

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

function! UseTabDefault()
  set tabstop=2
  set shiftwidth=2
  set expandtab
endfunction

command! -nargs=1 TabChar call UseTabChar(<f-args>)
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
