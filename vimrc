" vim and nvim Common Plugins
call plug#begin('~/.vim/plugins')
call plug#end()

if has('nvim')
	" nvim Only plugins
	call plug#begin('~/.vim/plugins')
	call plug#end()

	" nvim Only Settings
endif

" Common Settings
set encoding=utf-8
syntax enable

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
