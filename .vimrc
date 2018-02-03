
" vim-plug
call plug#begin('~/.vim/plugged')


Plug 'rust-lang/rust.vim'
Plug 'vim-syntastic/syntastic'
Plug 'SirVer/ultisnips'
Plug 'd0c-s4vage/vim-morph'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --go-completer --js-completer --rust-completer' }
Plug 'ervandew/supertab'
Plug 'nvie/vim-flake8'
Plug 'tpope/vim-fugitive'
Plug 'Lokaltog/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'fatih/vim-go'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline', { 'do': ':AirlineTheme luna'}
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'nanotech/jellybeans.vim'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

call plug#end()


let mapleader = ","

set laststatus=2

" Folder in which script resides: (not safe for symlinks)
let s:this_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let s:vim_scripts = s:this_dir."/vim-scripts"
for f in split(glob(s:vim_scripts."/*.vim"), '\n')
    exe 'source' f
endfor
