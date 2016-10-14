" turysaz' .vimrc file
" 2016 - 10 - 13

runtime! debian.vim

" enable syntax highlighting
if has("syntax")
	syntax on
endif

" source global configuration file, if available
if filereadable("/etc/vim/vimrc.local")
	source /etc/vim/vimrc.local
endif

"======= BASIC SETTINGS ===================
set background=dark		" dark background
colorscheme darkblue

set showmode			" show current mode (insert, ...)
set showcmd				" show (partial) commands in status line
set showmatch			" highlight matching brackets
set number				" line numbers
set ruler				" show ruler
set wrap				" wrapping too long lines
set linebreak			" don't wrap in the middle of a word

set autoindent			" autoindentation
set tabstop=4			" tabwidth
set shiftwidth=4		" ?
set expandtab			" make tab become spaces

" statusline
" ----------
set statusline=%t\ 		"tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'},	"file encoding
set statusline+=%{&ff}]\ 	"file format
set statusline+=[%H		"help file flag
set statusline+=%M		"modified flag
set statusline+=%R]		"read only flag
set statusline+=%=		"left/right separator
set statusline+=%y\ 		"filetype
set statusline+=[ASC:\%03.3b,	"ASCII-value of the symbol under the cursor
set statusline+=HEX:\%02.2B]\ 	"HEX-value of the symbol under the cursor
set statusline+=[C:%c\ 		"cursor column
set statusline+=L:%l/%L	"cursor line / total line
set statusline+=\ %P]	"percent through file

set laststatus=2		"show statusline: 0-never, 1-split, 2-always

"====== END BASIC SETTINGS ================

"--- Git ----------------------------------
let g:git_branch_status_head_current = 1
let g:git_branch_status_text = ""
let g:git_branch_status_nogit = ""
let g:git_branch_status_around = ""
let g:git_branch_check_write = "branch changed"


"--- Airline / Powerline "-----------------
set t_Co=256			" use 256 colors, important for airline

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline configuration
let g:airline_detect_modifier = 1
let g:airline_detect_paste = 1
let g:airline_detect_crypt = 1
let g:airline_detect_spell = 1
let g:airline_detect_iminsert = 0
let g:airline_inactive_collapse = 1
let g:airline_theme = 'badwolf'

" airline customization
"let g:airline_section_a = '%y'
let g:airline_section_b = '%{GitBranchInfoString()}'
"let g:airline_section_c = '%y'
"let g:airline_section_gutter = '%y'
"let g:airline_section_x = '%y'
"let g:airline_section_y = '%y'
"let g:airline_section_z = '%y'
"let g:airline_section_error = 'E' "Error field deactivated

