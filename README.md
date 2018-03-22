# VIM/NEOVIM Configuration Files

Clone and begin using.

Delete original .vimrc file (if you have one), open up Vim/NeoVim and type:
```bash
:PlugInstall
```
Add new plugins to vimrc file's plugin manager section. Specify github page.

If using NeoVim, use following commands after completing setup:
```bash
mkdir -p ~/.config/nvim/
ln -s ~/.vim/autoload/ ~/.config/nvim/
ln -s ~/.vim/colors ~/.config/nvim/
ln -s ~/.vim/vimrc ~/.config/nvim/init.vim
```
The plugin YouCompleteMe requires some more configuration prior to use. You may see some errors when starting up your vim instance. If you do not want to use YouCompleteMe, simply edit the vimrc file and remove the following line:
```bash
Plug 'Valloric/YouCompleteMe'
```
Open vim again and issue the following command to remove YouCompleteMe:
```bash
:PlugClean
```
## Complete vim Bindings
https://hea-www.harvard.edu/~fine/Tech/vi.html
## Modifications and Useful Commands
* Ctrl + s (NeoVim Only): Open Terminal
* F2: toggle paste on/off
* \ + j (Only if YouCompleteMe is installed): YcmCompleter GoTo keyboard shortcut
* Key command for reindenting file:
                                        ```
                                        gg=G
                                        ```
## Notes on Unexpected Characters in NVIM
If you see strange characters in other terminals such as lxterminal, add the following line to ~/.profile.
```bash
export VTE_VERSION="100"
```
## vim-airline Notes
vim-airline is a plugin that provides a nicer looking status line, similarily to how powerline works for standard shells. If the statusline looks weird after installation or if you do not have powerline fonts installed, simply set the variable g:airline_powerline_fonts to 0.

This variable can be found (already set to 1) in the vimrc file.

If you have the rights to do so, you can also install the fonts for powerline.
```bash
sudo apt-get install fonts-powerline
```
