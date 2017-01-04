call pathogen#infect()

let mapleader = ","

" todo:
" ctrlp
" nerdtree
" a.vim - switch from 
" marks.vim
" easy motion

" make YCM compatible with UltiSnips (using supertab)
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"let g:ycm_filetype_whitelist = {
""	\ 'cpp'    : 1,
""	\ 'c'      : 1,
""	\ 'python' : 1,
""	\ 'java'   : 1,
""	\ 'bash'   : 1,
""	\ 'ruby'   : 1,
""	\ 'sh'     : 1,
""	\ 'json'   : 1,
"\ }
"let g:ycm_filetype_blacklist = {
""	\ '*.enc.*'    : 1,
"\ }



autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 1
let g:jedi#auto_vim_configuration = 1

function! JediVimTabDefinition()
	let g:jedi#use_tabs_not_buffers = 1
	call jedi#goto()
	let g:jedi#use_tabs_not_buffers = 0
endfunction
nnoremap <leader>D :call JediVimTabDefinition()<CR>

"let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
" alternative pattern: '\h\w*\|[^. \t]\.\w*'


"
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:SuperTabContextTextMemberPatterns = ['\.', '>\?::', '->']
 
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:ultisnips_python_style="v_sphinx"
let g:UltiSnipsEditSplit="vertical"


" backspace over everything in insert mode
" aka       set backspace=2
set backspace=indent,eol,start


autocmd BufRead,BufNewFile *.md setlocal spell | setlocal complete+=kspell
autocmd BufReadPost *.smt,*.smt2 setlocal syntax=scheme | setlocal filetype=scheme


" -----------------------------------
"  TABULARIZE
" -----------------------------------
vmap <C-y> :/^\s*[^#]/Tabularize /=.*<CR>
vmap & :/^\s*[^#]/Tabularize /\:.*<CR>
vmap <C-k> :/^\s*/Tabularize /\#.*<CR>


"
" ----------------------
" if no files are specified, open nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-O> :NERDTreeToggle<CR>
" ----------------------
"

nmap s <Plug>(easymotion-s)

"au WinEnter * :set relativenumber
"au WinLeave * :set norelativenumber

syntax enable
set number
set relativenumber
nnoremap <F10> :set norelativenumber!<CR>

function! CscopeRefresh()
	echo 
	silent !bash -ic g__cscope_refresh
	silent cs reset
endfunction
nnoremap <F5> :call CscopeRefresh()<CR>
set autoindent
" set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
set smarttab
set smartcase
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
	setlocal tabstop=4
	setlocal shiftwidth=4
	setlocal expandtab
endfunction
autocmd Filetype python call SetupPython()

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
	" find the project root
	let max = 10
	let c = 0
	let dots = ""
	while c <= max
		if filereadable(dots . "cscope.out")
			break
		else
			let dots = dots . "../"
		endif
		let c += 1
	endwhile

	tabnew

	" if we found the project root (cscope.out), then search from there
	if filereadable(dots . "cscope.out")
		execute "silent! !ag -R --ignore '*test*' --ignore '*tests*' --ignore '*cscope*' --ignore 'tags' --nogroup --nocolor " join(a:000, " ") " " . dots . " >/tmp/lgrep.txt"
	else
		execute "silent! !ag -R --ignore '*test*' --ignore '*tests*' --ignore '*cscope*' --ignore 'tags' --nogroup --nocolor " join(a:000, " ") " . >/tmp/lgrep.txt"
	endif
	"!ag -R -l --nocolor " a:000 " * >/tmp/lgrep.txt"
	"
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

"map <C-H> :vertical resize -1<CR>
"map <C-J> :resize +1<CR>
"map <C-K> :resize -1<CR>
"map <C-L> :vertical resize +1<CR>
map <C-S-I> @a

map ,c :tabc<CR>

" sync to git (add and commit)
" sync only the current file
map ,ss :w<CR>:!git add % ; git commit -m "syncing" %<CR>

" surround the current line in matching dashes for a title
map ,p yypVr-yykPj

let g:ctrlp_root_markers = ['cscope.out', 'pct.sqlite', 'ctags']



" -------------------------------------------------------
"  pymode
" -------------------------------------------------------

let g:pymode_breakpoint = 0
let g:pymode_lint_on_fly = 0
let g:pymode_lint_on_write = 1
let g:pymode_rope = 0
let g:pymode_folding = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_completion = 0


" ----------------------------------
" HTML TAG COMPLETION
" ----------------------------------

" iabbrev <// </<C-X><C-O>
imap <C-Space> </<C-X><C-O>


" ----------------------------------
" vim-morph settings
" ----------------------------------

let g:Morph_PostMorphRestore = 1


function! PythonAddImportInsertLeave(insert_mode)
	execute "normal! V/import.*$\\n\\s*\\n\<CR>"
	execute "normal! !sort|uniq\<CR>"
	execute "normal! `mzz"

	" remove import auto-cmd
	autocmd! PythonAddImport *

	if a:insert_mode
		call feedkeys("a")
	endif
endfunction

function! PythonAddImport(insert_mode)
	if &filetype != "python"
		return
	endif

	execute "normal! mmgg/^import\<CR>Oimport\<space>"

	augroup PythonAddImport
		execute "autocmd InsertLeave <buffer> :call PythonAddImportInsertLeave(". a:insert_mode .")"
	augroup end

	startinsert!
endfunction
nnoremap <C-j> :call PythonAddImport(0)<CR>
inoremap <C-j> <ESC>:call PythonAddImport(1)<CR>
