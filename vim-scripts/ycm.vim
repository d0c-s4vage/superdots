let g:ycm_server_use_vim_stdout = 0
let g:ycm_server_keep_logfiles = 1
let g:ycm_path_to_python_interpreter = "/usr/bin/python"

nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>r :YcmCompleter GoToReferences<CR>
