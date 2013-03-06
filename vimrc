" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

set bg=dark

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Don't allow backspace over line breaks or autoidents.
" This is to encourage 'proper' commands for joining lines and such.
set backspace=start

set autoindent		" always set autoindenting on
set expandtab
set nobackup
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set number

map Q gq

map <F2> <Esc>:set paste<CR>:set mouse=<CR>i
map <F3> <Esc>:set nopaste<CR>:set mouse=a<CR>i
map - <Esc>/

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set number
    autocmd WinLeave * set nonumber
augroup END

cnoreabbrev Q qa

set cinoptions={.5s,:.5s,+.5s,t0,g0,^-2,e-2,n-2,p2s,(0,=.5s formatoptions=croql cindent shiftwidth=4 tabstop=4

