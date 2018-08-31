# VIM/NEOVIM Configuration Files

Clone and begin using. This vim setup is primarily targeted for NEOVIM.

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
ln -s ~/.vim/syntax ~/.config/nvim/
ln -s ~/.vim/vimrc ~/.config/nvim/init.vim
```

## Project Specific NeoVim/Vim Configuration
If using VIM, create a `.vimrc` or `.exrc` file in the root directory of the project with the desired additional configurations.
If using NEOVIM, create a `.nvimrc` file in the root directory of the project with the desired additional configurations.

## Complete vim Bindings
https://hea-www.harvard.edu/~fine/Tech/vi.html

## Modifications and Useful Commands
* Ctrl + s (NeoVim Only): Open Terminal
* F2: toggle paste on/off
* \ + j (Only if YouCompleteMe is installed): YcmCompleter GoTo keyboard shortcut
* Key command for reindenting file: `gg=G`

## Notes on Unexpected Characters in NVIM
If you see strange characters in other terminals such as lxterminal, add the following line to ~/.bashrc.
```bash
export VTE_VERSION="100"
```
## deoplete.nvim
deoplete is an autocomplete/code suggestions plugin. To use, make sure to install NEOVIM. After that, make sure you have Python3 installed. From here, install the neovim python bindings with the following command:
```bash
pip3 install neovim
```
See (https://github.com/Shougo/deoplete.nvim) for how to configure.

