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
" syntax enable

" Add mouse support in xterms.
set mouse=a

" Show how far through the file we are.
set ruler

" Filetype-based autoindenting.
" filetype plugin indent on

" Timeout quickly for key bindings.
set timeoutlen=250

"""""""""""""""""""""
"" PERSONAL TWEAKS ""
"""""""""""""""""""""

" Remap the leader to ,
let mapleader = ","

" Use simultaneous JK to return to normal mode
" instead of escape.
inoremap jk <esc>
inoremap kj <esc>
vnoremap jk <esc>
vnoremap kj <esc>

" Use semicolon to enter command mode.
map ; :

" Check off todo items ( ) --> (X) with <C-space>
map <leader><space> 0f(lrX

map <leader>sp ggO#!/usr/bin/env python<cr><esc>j
map <leader>sb ggO#!/bin/bash<cr><esc>j

function! SetShebang()
    if(match(getline(1) , '^\#!') == 0)
        execute("let b:interpreter = getline(1)[2:]")
    endif
endfunction

function! CallInterpreter()
    call SetShebang()
    if exists("b:interpreter")
         exec ("w|!".b:interpreter." %")
    endif
endfunction

map <leader>e :call CallInterpreter()<cr>

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
let g:vimwiki_list = [{'path':'~/Dropbox/vimwiki/','ext':'.wiki'},{'path':'~/Dropbox/rp/psi/', 'path_html':'~/Dropbox/rp/psi/html/', 'ext':'.wiki'}]

" Git shortcuts so good, they should be illegal
Bundle 'fugitive.vim'

" Syntax checking!
Bundle 'scrooloose/syntastic'

" CtrlP file finding
Bundle 'ctrlp.vim'

let g:ctrlp_working_path_mode = 2

let g:path_to_matcher = "~/bin/matcher"

let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files . -co --exclude-standard']

let g:ctrlp_match_func = { 'match': 'GoodMatch' }

function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)

  " Create a cache file if not yet exists
  let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
  if !( filereadable(cachefile) && a:items == readfile(cachefile) )
    call writefile(a:items, cachefile)
  endif
  if !filereadable(cachefile)
    return []
  endif

  " a:mmode is currently ignored. In the future, we should probably do
  " something about that. the matcher behaves like "full-line".
  let cmd = g:path_to_matcher.' --limit '.a:limit.' --manifest '.cachefile.' '
  if !( exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles )
    let cmd = cmd.'--no-dotfiles '
  endif
  let cmd = cmd.a:str

  return split(system(cmd), "\n")

endfunction

" Re-enable filetype
" filetype plugin indent on
