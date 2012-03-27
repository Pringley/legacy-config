" Auto reload vimrc when changed
au BufWritePost .vimrc so ~/.vimrc
au BufWritePost vimrc so ~/.vimrc

"""""""""""""""""""""
"" EDITOR SETTINGS ""
"""""""""""""""""""""

" Backspace through everything
set backspace=indent,eol,start

" Use normal tab-completion (not automatically use first one)
set wildmode=longest:full
set wildmenu

" Tab settings
set tabstop=4 shiftwidth=4       " tab width of 4
set expandtab                    " use spaces instead of tabs
set smarttab                     " backspace deletes full 4 spaces

" Search tweaks
set incsearch                    " search as you type
set ignorecase                   " don't be case sensitive
set smartcase                    " ... unless there's a capital letter

" Use utf-8 encoding
set encoding=utf-8

" Show incomplete commands.
set showcmd

" Use strong encryption on :X
set cm=blowfish

" Automatic code indentation.
set autoindent
set smartindent

" Activate syntax highlighting.
syntax enable

" Add mouse support in xterms.
set mouse=a

" Show how far through the file we are.
set ruler

" Use buffers
set hidden

"""""""""""""""""""""
"" PERSONAL TWEAKS ""
"""""""""""""""""""""

" Remap the leader to ,
let mapleader = ","

" Use simultaneous JK to return to normal mode
" instead of escape.
inoremap jk <esc>
inoremap kj <esc>

" Back up after closing tags
inoremap <C-b> <C-o>O

" Check off todo items ( ) --> (X) with <C-space>
nmap <C-@> 0f(lrX

" Window/split management
function! WinMove(key)
    let t:curwin = winnr()

    " try to move
    exec "wincmd ".a:key

    " if that doesn't work, we're at the edge
    if(t:curwin == winnr())
        if(match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction
map <leader>h :call WinMove('h')<cr>
map <leader>k :call WinMove('k')<cr>
map <leader>l :call WinMove('l')<cr>
map <leader>j :call WinMove('j')<cr>

"""""""""""""
"" PLUGINS ""
"""""""""""""

" Turn off filetype for Vundle
filetype off

" Enable Vundle
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'

" Access personal wiki with with <leader>ww
Bundle 'vimwiki'
let g:vimwiki_list = [{'path':'~/Dropbox/vimwiki/','ext':'.wiki'},{'path':'~/Dropbox/rp/psi/', 'path_html':'~/Dropbox/rp/psi_html/', 'ext':'.wiki'}]

" Git shortcuts so good, they should be illegal
Bundle "fugitive.vim"

" Filetype-based autoindenting.
filetype plugin indent on
