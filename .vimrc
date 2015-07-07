call pathogen#infect()

let mapleader = ","

" todo:
" ctrlp
" nerdtree
" a.vim - switch from 
" marks.vim
" easy motion
"

" backspace over everything in insert mode
" aka       set backspace=2
set backspace=indent,eol,start

"
" ----------------------
" if no files are specified, open nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-O> :NERDTreeToggle<CR>
" ----------------------
"

nmap s <Plug>(easymotion-s)

if has("mouse")
	set mouse=a
	set ttymouse=xterm2
endif

au WinEnter * :set relativenumber
au WinLeave * :set norelativenumber

syntax enable
set number
set relativenumber
nnoremap <F10> :set norelativenumber!<CR>
set autoindent
" set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
set pastetoggle=<F12>
set nowrap
set incsearch
set cmdheight=2
colors james

set clipboard+=unnamed

filetype plugin on
set omnifunc=syntaxcomplete#Complete

" open file under the cursor in a new tab
nmap ,o <C-W>f<C-W>L

nmap ,g :tabnew<bar>:lgrep -R

" use silver searcher instead of grep
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  "let g:ctrlp_use_caching = 0
endif
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_follow_symlinks=1
let g:ctrlp_working_path_mode=''

function! SetupPython()
	set tabstop=4
	set shiftwidth=4
	set noexpandtab
endfunction

function! LExCmd(...)
	"!ag -R -l --nocolor " a:000 " * >/tmp/lgrep.txt"
	execute "silent! !" join(a:000, " ") " >/tmp/ex_cmd.txt"
	execute "silent! !sed -e 's/$/:0:\ /' -i /tmp/ex_cmd.txt"
	tabf /tmp/ex_cmd.txt
	execute "normal! ggVG:norm $a:0: \<CR>:w\<CR>"
	lf /tmp/ex_cmd.txt
	lop
	redraw!
endfunction
command! -nargs=+ -complete=file LlExCmd call LExCmd(<f-args>)
map ,A :LlExCmd 

function! LGrep(...)
	tabnew
	"!ag -R -l --nocolor " a:000 " * >/tmp/lgrep.txt"
	execute "silent! !ag -R --ignore '*test*' --ignore '*tests*' --ignore '*cscope*' --ignore 'tags' --nogroup --nocolor " join(a:000, " ") " . >/tmp/lgrep.txt"
	lf /tmp/lgrep.txt
	lop
	redraw!
endfunction
command! -nargs=+ -complete=file Llgrep call LGrep(<f-args>)
map ,s :Llgrep 
map ,S :execute 'Llgrep '.expand('<cword>')<CR>

" -----------------------------
" cscope
" -----------------------------
if has('cscope')
	set cscopetag cscopeverbose
	if has('quickfix')
		"set cscopequickfix=s-,c-,d-,i-,t-,e-
		set cscopequickfix=s-,g-,c-,d-,i-,t-,e-
	endif

	" 0 == check cscope first, 1 == check ctags first
	set csto=0

	nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
	nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
	
	nmap <PageUp> :lprev<CR>zz
	nmap <PageDown> :lnext<CR>zz
	nmap ,< :lprev<CR>zz
	nmap ,> :lnext<CR>zz
	
	nmap <C-n>s :tabnew<bar>:tab lcs find s <C-R>=expand("<cword>")<CR><CR>:lop<CR><C-w>k
	nmap <C-n>g :tabnew<bar>:tab lcs find g <C-R>=expand("<cword>")<CR><CR>:lop<CR><C-w>k
	nmap <C-n>c :tabnew<bar>:tab lcs find c <C-R>=expand("<cword>")<CR><CR>:lop<CR><C-w>k
	nmap <C-n>t :tabnew<bar>:tab lcs find t <C-R>=expand("<cword>")<CR><CR>:lop<CR><C-w>k
	nmap <C-n>e :tabnew<bar>:tab lcs find e <C-R>=expand("<cword>")<CR><CR>:lop<CR><C-w>k
	nmap <C-n>f :tabnew<bar>:tab lcs find f <C-R>=expand("<cfile>")<CR><CR>:lop<CR><C-w>k
	nmap <C-n>i :tabnew<bar>:tab lcs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:lop<CR><C-w>k
	nmap <C-n>d :tabnew<bar>:tab lcs find d <C-R>=expand("<cword>")<CR><CR>:lop<CR><C-w>k

	nmap <C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>	
	nmap <C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
	nmap <C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


	" find the first cscope.out file in parent directories (recursively)
	let max = 10
	let c = 0
	let dots = ""
	while c <= max
		if filereadable(dots . "cscope.out")
			execute "cs add ".dots."cscope.out"." ".dots
			break
		else
			let dots = dots . "../"
		endif
		let c += 1
	endwhile
endif
" -----------------------------


" -----------------------------
" ctags
" -----------------------------

" could also just set tags=./tags;/
" this would search all the way back to root until it found a tags file
" but... I like being able to limit how far up it goes
"
" find the first tags file in parent directories (recursively)
let max = 10
let c = 0
let dots = ""
while c <= max
	if filereadable(dots . "tags")
		execute "set tags=".dots."tags"
		break
	else
		let dots = dots . "../"
	endif
	let c += 1
endwhile

nnoremap <silent> ,b :TagbarToggle<CR>

" -----------------------------

map <C-H> :vertical resize -1<CR>
map <C-J> :resize +1<CR>
map <C-K> :resize -1<CR>
map <C-L> :vertical resize +1<CR>
map <C-S-I> @a

map ,c :tabc<CR>

" sync to git (add and commit)
" sync only the current file
map ,ss :w<CR>:!git add % ; git commit -m "syncing" %<CR>

" surround the current line in matching dashes for a title
map ,p yypVr-yykPj

let g:ctrlp_root_markers = ['cscope.out', 'pct.sqlite', 'ctags']
