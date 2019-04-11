" backspace over everything in insert mode
" aka       set backspace=2
set backspace=indent,eol,start

set updatetime=250

"set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
"set smartindent
"set smarttab
set smartcase
set pastetoggle=<F12>
set nowrap
set incsearch
set cmdheight=2
set colorcolumn=80

colors jellybeans

function! MaybeSetRelative()
    if &number
        set relativenumber
    endif
endfunction
function! MaybeClearRelative()
    if &number
        set norelativenumber
    endif
endfunction
au WinEnter * :call MaybeSetRelative()
au WinLeave * :call MaybeClearRelative()

syntax enable
set number
set relativenumber

set clipboard+=unnamed

"filetype plugin on

" open file under the cursor in a new tab
nmap <leader>o <C-W>f<C-W>L


function! ReplaceWord()
    let curr_word = expand('<cword>')
    let view = winsaveview()
    set hlsearch
    execute 'normal! /'.curr_word."\<CR>"
    let new_word = input("Replace '".curr_word."' with: ")
    execute '%s/\<'.curr_word.'\>/'.new_word.'/g'
    set nohlsearch
    call winrestview(view)
endfunction
map <leader>R :call ReplaceWord()<CR>

map <leader>c :tabc<CR>



function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv
