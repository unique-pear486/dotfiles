"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-unimpaired')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
  call dein#add('deoplete-plugins/deoplete-jedi')
  call dein#add('ervandew/supertab')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

" Enable deoplete at startup
let g:deoplete#enable_at_startup = 1

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

" remap <CR> to turn off search highlighting
nnoremap <CR> :noh<CR><CR>

" enable all Python syntax highlighting features
let python_highlight_all = 1

filetype plugin indent on

" turn on folding
set foldmethod=indent
set foldlevel=99

" allow backspacing linebreaks and past the start of the edit/insert
set backspace=2

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
nnoremap <C-Tab> :b#<CR>

" Use <C-motion> to navigate windows
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" Switch zA and za, more often I want zA
nnoremap zA za
nnoremap za zA

" Set Y to yank to the end of the line, like D, C, etc
nnoremap Y y$

" Make diffs split the screen vertically, not horizontally
set diffopt+=vertical

" Use Relative numbering
set relativenumber

" enable mouse support
set mouse=a

" set colour to solarized
syntax enable
let g:solarized_hitrail=1
set background=dark
colorscheme solarized
highlight Search gui=standout

" setup help for packages (must be at end)
packloadall
silent! helptags ALL

