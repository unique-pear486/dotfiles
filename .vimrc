" set vi compatibility off
set nocompatible
map Q gq

" enable pathogen
runtime autoload/pathogen/pathogen.vim
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

" expand tabs into spaces
set expandtab

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show a visual line under the cursor's current line
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" show ruler, command and mode
set ruler
set showcmd
set showmode

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

