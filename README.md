# VIM/NEOVIM Configuration Files

Clone and begin using.

Delete original .vimrc file (if you have one), open up Vim/NeoVim and type:
```
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

# Complete vim Bindings
https://hea-www.harvard.edu/~fine/Tech/vi.html
## Modifications
* Ctrl + s (NeoVim Only): Open Terminal
* F2: toggle paste on/off
