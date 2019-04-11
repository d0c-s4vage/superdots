let s:this_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:ultisnips_python_style="v_sphinx"
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsSnippetsDir=s:this_dir."/ultisnippets"
let g:UltiSnipsSnippetDirectories=["UltiSnips", s:this_dir."/ultisnippets"]
