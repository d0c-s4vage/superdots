

"call deoplete#custom#option('omni_patterns', {
"\ 'python': '[^. *\t]\.\w*',
"\})
"
call deoplete#custom#option('keyword_patterns', {
    \ '_': '[a-zA-Z_]\k*',
    \ 'tex': '\\?[a-zA-Z_]\w*',
    \ 'ruby': '[a-zA-Z_]\w*[!?]?',
\})
