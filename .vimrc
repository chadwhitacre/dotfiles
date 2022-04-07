cab e tabe
cab h tab help
cab ve VdebugEval
filetype on
filetype plugin on
filetype indent on
syntax enable

" http://items.sjbach.com/319/configuring-vim-right
set hidden
set history=1000
set title
set encoding=utf-8
set number

set autowrite
set noswapfile      " http://unix.derkeiler.com/Mailing-Lists/FreeBSD/questions/2004-09/0892.html

set backspace=indent,eol,start
set cursorline      " http://vim.wikia.com/wiki/Highlight_current_line
set ruler
set scrolloff=100   " http://vim.wikia.com/wiki/Keep_your_cursor_centered_vertically_on_the_screen
set statusline=[%{&fo}]

" Colors
set background=dark " vs. default of light - https://unix.stackexchange.com/a/88892
set t_Co=256        " vs. default of 16 - http://www.vim.org/scripts/script.php?script_id=1558
"hi Comment ctermfg=cyan

" Tabs (vs. Windows)
set showtabline=2
nmap <C-t> :tabnew<cr>
nmap <C-e> :tabclose<cr>


" Stay the Hell Out of Insert Mode
" ================================
" http://cloudhead.io/2010/04/24/staying-the-hell-out-of-insert-mode/

inoremap <Left>  <NOP>
inoremap <Right> <NOP>
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>


" Ctrl-S for Write
" ================
" http://vim.wikia.com/wiki/Map_Ctrl-S_to_save_current_or_new_files

nmap <C-S> :w<CR>


" Let Screen Have Ctrl-A
" ======================

nmap <S-X> <C-A>


" Highlight text in col 100 and beyond.
" =====================================
" http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns/235962#235962

"autocmd BufWinEnter * silent match ErrorMsg /\%100v.\+/


" ALE
" ===
let g:ale_lint_on_text_changed="never"


" Search
" ======

set incsearch " incremental search

" ... and replace - http://stackoverflow.com/questions/676600/
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" ag
" --
" https://github.com/mileszs/ack.vim#can-i-use-ag-the-silver-searcher-with-this
" https://github.com/mileszs/ack.vim/commit/d97090fb502d40229e6976dfec0e06636ba227d5#commitcomment-38623068
" https://vi.stackexchange.com/a/20585

let g:ackprg = 'ag --vimgrep'
let g:ack_autoclose = 1
command! -bang -nargs=* Search Ack<bang> <args>
command! -bang -nargs=* SearchFile AckFile<bang> <args>
cnoreabbrev S Search!
cnoreabbrev f SearchFile!


" Whitespace
" ==========

" "Secrets of tabs in vim" http://tedlogan.com/techblog3.html
set expandtab
set shiftwidth=2
set tabstop=2 " not softtabstop!

" https://www.linuxquestions.org/questions/programming-9/how-to-turn-off-expandtab-for-editing-makefiles-922519/
autocmd FileType make,go setlocal noexpandtab

" http://vim.wikia.com/wiki/Remove_unwanted_spaces#Automatically_removing_all_trailing_whitespace
autocmd FileType go,python,html,javascript,css,scss,vim,rb,c,js,sql,beancount autocmd BufWritePre <buffer> :%s/\s\+$//e

" https://stackoverflow.com/questions/1050640/vim-disable-automatic-newline-at-end-of-file
autocmd FileType php setlocal nofixendofline

" http://vim.wikia.com/wiki/See_the_tabs_in_your_file
" TODO - only for filetypes that don't use tabs by default (Go, Makefile)
"set list
" https://www.reddit.com/r/vim/comments/4hoa6e/what_do_you_use_for_your_listchars/?st=j8uaizxh&sh=746946e4
"set listchars=tab:·\ ,extends:›,precedes:‹,nbsp:·,trail:·
"set listchars=extends:›,precedes:‹,nbsp:·,trail:·
" http://tedlogan.com/techblog3.html
"hi Tab gui=underline guifg=blue ctermbg=blue


" Misc
" ====

" ht Dusty Phillips for teaching me 'abbreviate'
abbreviate ip import ipdb; ipdb.set_trace()
abbreviate pdb import pdb; pdb.set_trace()
abbreviate xb xdebug_break();
abbreviate pry require 'pry'; binding.pry
abbreviate rbk runtime.Breakpoint()
abbreviate enc # -*- coding: utf-8 -*-
abbreviate #! #!/usr/bin/env bash
abbreviate fut from __future__ import absolute_import, division, print_function, unicode_literals

imap <C-d> <Esc>:r!date +\%Y-\%m-\%d<Enter>i<BS><End><Enter>
imap <C-t> <Esc>:r!date +\%H:\%M<Enter>i<BS><End>
imap <C-M-t> <Esc>:r!date +\%H:\%M<Enter>i<BS><End><Enter>
" why is this borked? http://rails.blog.hu/2007/07/04/gvim_with_rails

" http://vim.wikia.com/wiki/Display_line_numbers
nmap <C-N><C-N> :set invnumber<Enter>
nmap <C-P><C-P> :set invpaste<Enter>i

" http://www.vim.org/htmldoc/options.html#'wildmode'
" http://www.linuxjournal.com/article/3805
"set wildmenu
"set wildmode=longest:full
set wildignore=*.pyc
set wildmode=longest,list " like bash's default


" Filetypes
" =========

" Python
" ------

let g:python_highlight_space_errors=0
let g:python_highlight_all=1
let g:python_slow_sync=1
let g:syntastic_python_python_exec = '/usr/bin/python3'


" ini
" ---
" http://www.vim.org/scripts/script.php?script_id=2475

au BufNewFile,BufRead *.conf,*.ini,*/.hgrc,*/.hg/hgrc setf ini
au BufNewFile,BufRead *.j setf objj " TODO - ?


" Markdown
" --------
" Instead of Modula-2 for *.md
" https://github.com/tpope/vim-markdown

autocmd BufNewFile,BufReadPost *.md set filetype=markdown


" Per-Project vimrc
" =================
" http://andrew.stwrt.ca/posts/project-specific-vimrc/

set exrc
set secure
