setlocal spell spelllang=en_us
set colorcolumn =0
set wrap
set wrapmargin  =0

let g:vim_markdown_folding_disabled = 1

let g:vim_markdown_no_default_key_mappings = 1

let g:vim_markdown_toc_autofit = 1

" See https://github.com/plasticboy/vim-markdown/issues/232
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0

let g:vim_markdown_fenced_languages = ['php', 'py=python', 'js=javascript', 'bash=sh', 'viml=vim']

let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_frontmatter = 1

" Format strike-through text (wrapped in `~~`).
let g:vim_markdown_strikethrough = 1
