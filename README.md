# VIM/NEOVIM Configuration Files

Clone and begin using.

Open up Vim/NeoVim and type:
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
# Complete vim Bindings
https://hea-www.harvard.edu/~fine/Tech/vi.html
## Modifications
* Ctrl + s (NeoVim Only): Open Terminal
* F2: toggle paste on/off
