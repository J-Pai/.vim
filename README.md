# VIM/NEOVIM Configuration Files

Clone and begin using. This vim setup is primarily targeted for NEOVIM.

Delete original .vimrc file (if you have one), open up Vim/NeoVim and type:

```bash
:PlugInstall
```

Add new plugins to vimrc file's plugin manager section. Specify github page.

If using NeoVim, use following commands after completing setup:
```bash
sudo apt install ranger ripgrep fzf
sudo apt install nodejs npm
python3 -m pip install --user pynvim neovim-remote

ln -s ~/.vim/tmux.conf ~/.tmux.conf

mkdir -p ~/.config/nvim/
ln -s ~/.vim/autoload/ ~/.config/nvim/
ln -s ~/.vim/colors ~/.config/nvim/
ln -s ~/.vim/syntax ~/.config/nvim/
ln -s ~/.vim/vimrc ~/.config/nvim/init.vim
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

## Project Specific NeoVim/Vim Configuration
If using VIM, create a `.vimrc` or `.exrc` file in the root directory of the project with the desired additional configurations.
If using NEOVIM, create a `.nvimrc` file in the root directory of the project with the desired additional configurations.

## Complete vim Bindings
https://hea-www.harvard.edu/~fine/Tech/vi.html

## Modifications and Useful Commands
* Ctrl + s (NeoVim Only): Open Terminal (uses neoterm)
* F2: toggle paste on/off
* \ + j (Only if YouCompleteMe is installed): YcmCompleter GoTo keyboard shortcut
* Key command for reindenting file: `gg=G`

### Opening Files in Terminal
Use [neovim-remote](https://github.com/mhinz/neovim-remote).

```bash
python3 -m pip install neovim-remote
```

Add the following to `~/.bashrc`:

```bash
if [ -n "${NVIM_LISTEN_ADDRESS+x}" ]; then
  alias vims='nvr -o' # Open file in horizontal split
  alias vimvs='nvr -O' # Open file in vertical split
  alias vim='nvr --remote-tab' # Open file in new tab
fi
```

## Notes on Unexpected Characters in NVIM
If you see strange characters in other terminals such as lxterminal, add the following line to ~/.bashrc.

```bash
export VTE_VERSION="100"
```

## deoplete.nvim
deoplete is an autocomplete/code suggestions plugin. To use, make sure to install NEOVIM. After that, make sure you have Python3 installed. From here, install the neovim python bindings with the following command:

```bash
pip3 install --user pynvim
```

See (https://github.com/Shougo/deoplete.nvim) for how to configure.

## Language Completion Setups
### Python

```bash
python3 -m pip install python-language-server
```

### Clang C/C++

```
sudo apt install clangd
# or
sudo apt install clang-tools
```

#### CMake Projects
During initial cmake generation include the following flag:

```
-DCMAKE_EXPORT_COMPILE_COMMANDS=1
```

Link the `compile_commands.json` file to the root of the project.

```
ln -sfn ~/myproject/cmake/build/compile_commands.json ~/myproject/
```

### General Makefile/Non-Clang Projects

Use `bear` to generate the `compile_commands.json` file.

```bash
sudo apt install bear
bear -- <BUILD_COMMAND>
```

## Fuzzy Finding
Following is the preferred fuzzy-finders:

```bash
sudo apt install ripgrep
sudo apt install fzf
```

Create `~/.fzf.bash` and use the following as it's contents:

```bash
# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/share/doc/fzf/examples/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/usr/share/doc/fzf/examples/key-bindings.bash"
```

Add the following the `~/.bashrc`.

```
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
```

## Ranger Filesystem to replace netrw

```bash
sudo apt install ranger
```
