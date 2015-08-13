" set vi compatibility off
set nocompatible
map Q gq

" enable pathogen
runtime autoload/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

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

" set font
if has('win32')
  set guifont=consolas:h11
endif

" highlight the 80th column and the 120th onwards
let &colorcolumn="80,".join(range(120,999),",")

" set textwidth=80 for python files
augroup filetype_python
    autocmd!
    autocmd Filetype python set textwidth=80
augroup END

" set supertab to default to OmniCompletion
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabLongestEnhanced = 1

" let Gd open a git diff of the whole repo
command Gd Gsplit! diff
