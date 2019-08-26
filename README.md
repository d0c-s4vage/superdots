
# superdots

Super dot files.

* Organized
* Usable
* Extendable

- [Usage](#usage)
- [Features](#features)
  * [Home folder organization](#home-folder-organization)
  * [Main Commands](#main-commands)
  * [Super-local usr directory](#super-local-usr-directory)
  * [Tmux](#tmux)
  * [Bash](#bash)
  * [Vim](#vim)
  * [Screen](#screen)
- [Experimental/Silly](#experimentalsilly)
- [TODO](#todo)

## Usage

Run the `bin/install` script to install superdots. Installing superdots hooks
your:

* .bashrc
* .tmux.conf
* .vimrc
* .screenrc

## Features

### Home folder organization

After installing superdots with `bin/install`, superdots creates a directory
structure in `$HOME` that looks like:

```bash
$> tree -a -I .rbenv
.
|-- .bash_completion
|-- .bash_logout
|-- .bashrc
|-- .gitconfig
|-- .profile
|-- .screenrc
|-- .rbenv/
|-- .ssh
|   |-- config
|   `-- environment
|-- .superdots/
|-- .tmux.conf
|-- .vim
|   `-- autoload
|-- .vimrc
|-- usr
|   |-- bin
|   `-- lib
`-- ws
    |-- dev
    |-- docs
    |-- meetings
    |-- rd
    `-- src
```

### Main Commands

| Command   | Example            | Note                                                                                                                |
|-----------|--------------------|---------------------------------------------------------------------------------------------------------------------|
| `work`    | `work new_project` | Creates or reattaches to an existing tmux session named `new_project`                                               |
| `fn_edit` | `fn_edit python`   | Open the `${SUPERDOTS}/bash-sources/python.sh` file for editing in vim                                              |
| `fn_new`  | `fn_edit python`   | Open the `${SUPERDOTS}/bash-sources/python.sh` file, and expand a few UltiSnips for defining new bash functions     |
| `fn_new`  | `fn_edit new_file` | Create the `${SUPERDOTS}/bash-sources/new_file.sh` file, and expand a few UltiSnips for defining new bash functions |
| `fn`      | `fn a_function`    | Basically a proxy to support tab-completion with superdots functions                                                |

All functions above work with tab completion.

### Super-local usr directory

Superdots' `bin/install` creates a `$HOME/usr` directory and places it on your
PATH.

### Tmux

A core aspect to superdots is the `work` function, which makes creating,
switching, and reattaching to tmux sessions easy. Works with tab-completion!

### Bash

Makes defining and tracking new bash snippets easy with the `fn_new`, `fn_edit`,
and `fn` functions. See the "Main Commands" section above.

### Vim

Uses [vim-plug](https://github.com/junegunn/vim-plug) for vim plugin management,
including UltiSnips, language server, and more.

See `${SUPERDOTS}/{.vimrc,vim-scripts/}` for all defined/categorized settings
and customizations.

Of special note is that all custom UltiSnips plugins are defined *within* the
superdots source folder, which makes them easy to save and persist back into
your superdots git repository.

Plugins as of 2019-08-25 installed automatically with vim-plug:

* [autozimu/LanguageClient-neovim](https://github.com/autozimu/LanguageClient-neovim)
* [junegunn/fzf](https://github.com/junegunn/fzf)
* [vim-ruby/vim-ruby](https://github.com/vim-ruby/vim-ruby)
* [tpope/vim-rails](https://github.com/tpope/vim-rails)
* [vim-scripts/SyntaxRange](https://github.com/vim-scripts/SyntaxRange)
* [vim-syntastic/syntastic](https://github.com/vim-syntastic/syntastic)
* [SirVer/ultisnips](https://github.com/SirVer/ultisnips)
* [honza/vim-snippets](https://github.com/honza/vim-snippets)
* [d0c-s4vage/vim-morph](https://github.com/d0c-s4vage/vim-morph)
* [rhysd/vim-grammarous](https://github.com/rhysd/vim-grammarous)
* [Shougo/deoplete.nvim](https://github.com/Shougo/deoplete.nvim)
* [Shougo/deoplete.nvim](https://github.com/Shougo/deoplete.nvim)
* [roxma/nvim-yarp](https://github.com/roxma/nvim-yarp)
* [roxma/vim-hug-neovim-rpc](https://github.com/roxma/vim-hug-neovim-rpc)
* [kien/ctrlp.vim](https://github.com/kien/ctrlp.vim)
* [ervandew/supertab](https://github.com/ervandew/supertab)
* [nvie/vim-flake8](https://github.com/nvie/vim-flake8)
* [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)
* [tpope/vim-markdown](https://github.com/tpope/vim-markdown)
* [Lokaltog/vim-easymotion](https://github.com/Lokaltog/vim-easymotion)
* [scrooloose/nerdtree](https://github.com/scrooloose/nerdtree)
* [fatih/vim-go](https://github.com/fatih/vim-go)
* [majutsushi/tagbar](https://github.com/majutsushi/tagbar)
* [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline)
* [vim-airline/vim-airline-themes](https://github.com/vim-airline/vim-airline-themes)
* [airblade/vim-gitgutter](https://github.com/airblade/vim-gitgutter)
* [nanotech/jellybeans.vim](https://github.com/nanotech/jellybeans.vim)
* [vim-scripts/AfterColors.vim](https://github.com/vim-scripts/AfterColors.vim)
* [d0c-s4vage/pct-vim](https://github.com/d0c-s4vage/pct-vim)
* [godlygeek/tabular](https://github.com/godlygeek/tabular)
* [dhruvasagar/vim-table-mode](https://github.com/dhruvasagar/vim-table-mode)

A few other ones are commented out that I use on occasion. See
[superdot's .vimrc](https://github.com/d0c-s4vage/superdots/blob/master/.vimrc)
for more info.

### Screen

Not really used anymore, but sets up a few keybindings and statusline
customizations. At one point I was using some trickery to merge the screen and
vim clipboards.

## Experimental/Silly

Docker container with most common dependencies and superdot installed. The
experimental part is using the `bin/login` script as your login shell!

(really, it's just for fun, I don't seriously use this right now.)

## TODO

See the issues on this project
