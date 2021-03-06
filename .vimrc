" set vi compatibility off
set nocompatible
map Q gq

" Add the virtualenv's site-packages to vim path
if has('python')
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif

" setup help for packages
packloadall
silent! helptags ALL

" enable syntax highlighting
syntax enable

" show line numbers
set number

" set tabs to 4 space
set ts=4

" indent when moving to the next line while writing code
set autoindent

" expand tabs into spaces set tabs to 4 spaces
set expandtab shiftwidth=4 softtabstop=4

" show a visual line under the cursor's current line
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" show ruler, command and mode
set ruler
set showcmd
set showmode

" set vim to smart-match searches
set ignorecase
set smartcase

" highlight searches and partial searches
set hlsearch
set incsearch

" hide the backup and temp files in the .vim directory
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.

" remap <CR> to turn off search highlighting
nnoremap <CR> :noh<CR><CR>

" enable all Python syntax highlighting features
let python_highlight_all = 1

" set colour to solarized
syntax enable
let g:solarized_hitrail=1
set background=dark
colorscheme solarized
highlight Search gui=standout

filetype plugin indent on

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" enable Tagbar
nnoremap <F8> :TagbarToggle<CR>
let g:tagbar_left=1

" turn on folding
set foldmethod=indent
set foldlevel=99

" allow backspacing linebreaks and past the start of the edit/insert
set backspace=2

" Windows vs Linux commands
if has('win32')
    set guifont=consolas:h11
else
    autocmd GUIEnter * call system('wmctrl -i -b add,maximized_vert,maximized_horz -r '.v:windowid)
endif

" highlight the 80th column and the 120th onwards
let &colorcolumn="80,".join(range(120,999),",")

" set textwidth=79 for python files
augroup filetype_python
    autocmd!
    autocmd Filetype python setlocal textwidth=79
augroup END

" set supertab to default to OmniCompletion
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabLongestEnhanced = 1

" let Gd open a git diff of the whole repo
if !exists(":Gd")
    command -nargs=* Gd Gsplit! diff <args>
endif
" delete fugitive buffers on close
augroup fugitive
    autocmd!
    autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END

" force .md files to be recognised as markdown not Modula-2
" set textwidth=80 for markdown files
augroup filetype_markdown
    autocmd!
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    autocmd Filetype markdown setlocal textwidth=80
augroup END

" Set smartcase off for HTML (stuffs up HTML autocomplete)
" Set tabspace = 2 for HTML
" turn off linewrap for HTML
augroup filetype_html
    autocmd!
    autocmd Filetype html,htmldjango setlocal noignorecase
    autocmd Filetype html,htmldjango setlocal nosmartcase
    autocmd Filetype html,htmldjango setlocal ts=2 expandtab shiftwidth=2 softtabstop=2
    autocmd Filetype html,htmldjango setlocal textwidth=0
augroup END

" Set tabspace = 2 for javascript
augroup filetype_js
    autocmd!
    autocmd Filetype javascript setlocal ts=2 expandtab shiftwidth=2 softtabstop=2
augroup END

" Set CTRL-Tab to change recent buffer in normal mode
nnoremap <c-tab> :b#<cr>

" Use <C-motion> to navigate windows
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" Stop jedi poping up on dot
let g:jedi#popup_on_dot = 0

" Switch zA and za, more often I want zA
nnoremap zA za
nnoremap za zA

" Set Y to yank to the end of the line, like D, C, etc
nnoremap Y y$

" Make diffs split the screen vertically, not horizontally
set diffopt+=vertical

" Use Relative numbering
set relativenumber

" ALE settings
"let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 1
let g:ale_fixers = { 'javascript': ['prettier'] }
nnoremap <F11> :ALEFix<cr>

" vim -b : edit binary using xxd-format!
augroup Binary
    au!
    au BufReadPre  *.bin let &bin=1
    au BufReadPost *.bin if &bin | %!xxd
    au BufReadPost *.bin set ft=xxd | endif
    au BufWritePre *.bin if &bin | %!xxd -r
    au BufWritePre *.bin endif
    au BufWritePost *.bin if &bin | %!xxd
    au BufWritePost *.bin set nomod | endif
augroup END

