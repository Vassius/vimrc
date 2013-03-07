" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

let mapleader = ","


"""""""""""
" Options "
"""""""""""

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Don't allow backspace over line breaks or autoidents.
" This is to encourage 'proper' commands for joining lines and such.
set backspace=start

set bg=dark
set autoindent		" always set autoindenting on
set expandtab
set nobackup
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set number
set cinoptions={.5s,:.5s,+.5s,t0,g0,^-2,e-2,n-2,p2s,(0,=.5s formatoptions=croql cindent shiftwidth=4 tabstop=4


""""""""""""""""""""
" General mappings "
""""""""""""""""""""

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


""""""""""""""""""""""""
" Normal mode mappings "
""""""""""""""""""""""""

" Mappings for quickly inserting blank lines and returning to normal mode
nnoremap <leader>o o<Esc><Up>
nnoremap <leader>O O<Esc><Down>


""""""""""""""""""""""""
" Insert mode mappings "
""""""""""""""""""""""""

inoremap {<CR> {<CR>}<Up><Esc>o  " Automatically insert matching bracket

let bracketStack = []

function TabMagic()
    let c = g:bracketStack[-1]
    let g:bracketStack = g:bracketStack[:-2]
    normal f]<Right>
    if len(g:bracketStack) == 0
        iunmap <Tab>
    endif
endfunction

function PushBracket(c) 
    call add(g:bracketStack, a:c)
    inoremap <Tab> <Esc>:call TabMagic()<CR>a
endfunction

inoremap [ []<Left><Esc>:call PushBracket("]")<CR>a

""""""""""""""""
" Autocommands "
""""""""""""""""

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

" Disable line numbering in inactive windows. This is convenient
" for quickly identifying which window is active. 
augroup HighlightActive
    autocmd!
    autocmd WinEnter * set number
    autocmd WinLeave * set nonumber
augroup END

" Remap :Q to :qa. Convenient since I often use multiple windows.
cnoreabbrev Q qa


