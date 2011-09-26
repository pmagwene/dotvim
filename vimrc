" Use pathogen to autoload bundles
call pathogen#infect()
call pathogen#helptags()

set nocompatible

" Set title of window according to filename.
set title
" Set line numbering on by default
set number
" Show line and column position of cursor, with percentage.
set ruler
" Status line
set laststatus=2
" Remove splash screen
set shortmess+=I


" Set leader to comma.
let mapleader = ","


" Don't redraw screen while executing macros.
set nolazyredraw

" Behave intelligently for type of file.
filetype plugin indent on

" Syntax highlighting.
function! SyntaxToggle()
  execute "syntax" exists("g:syntax_on") ? "off" : "on"
endfunction
nmap <leader>s :call SyntaxToggle()<cr><C-l><cr>
syntax enable


set expandtab
set softtabstop=4
set smarttab
set shiftwidth=4
set shiftround
set showtabline=1

set wrap linebreak textwidth=0


if has('gui_running')
    set guifont=DejaVu\ Sans\ Mono\:h14 
    colorscheme desert256
else
    colorscheme default
endif


" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd        " Show (partial) command in status line.
set showmatch        " Show matching brackets.
set ignorecase        " Do case insensitive matching
set smartcase        " Do smart case matching
set incsearch        " Incremental search
set autowrite        " Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set mouse=a        " Enable mouse usage (all modes) in terminals

augroup CPT
 au!
 au BufReadPre *.cpt set bin
 au BufReadPre *.cpt set viminfo=
 au BufReadPre *.cpt set noswapfile
 au BufReadPost *.cpt let $vimpass = inputsecret("Password: ")
 au BufReadPost *.cpt silent '[,']!/usr/local/bin/ccrypt -cb -E vimpass
 au BufReadPost *.cpt set nobin
 au BufWritePre *.cpt set bin
 au BufWritePre *.cpt '[,']!/usr/local/bin/ccrypt -e -E vimpass
 au BufWritePost *.cpt u
 au BufWritePost *.cpt set nobin
 au BufNewFile *.cpt let $vimpass = inputsecret("ccrypt password for this file: ")
 au BufRead,BufNewFile *.cpt set ft=cpt 
augroup END


" Use <Leader>g to go to a url under cursor in UTL format <url:blah>
:map <Leader>g :Utl<cr>
:let g:utl_opt_highlight_urls='yes'
:let g:utl_cfg_hdl_mt_generic = 'silent !open "%p"&'

" s skips whitespace and puts cursor on next non-whitespace char
:map s :call search('\S','ceW')<cr>
" S skips preceding whitespace and puts cursor on last non-whitespace char
:map S :call search('\S','bceW')<cr>

" If for aesthetic reasons you want a left margin in writing text...
function! GutterLeft()
  set number
  highlight LineNr ctermfg=Black
endfunction


" Use space and backspace for quick navigation forward/back.
noremap <Space> <PageDown>
noremap <BS> <PageUp>


" No audible bell.
set visualbell


" Encoding and line breaks.
set encoding=utf-8
set ffs=unix,dos

set grepprg=grep\ -nH\ $*

" Completion for file open etc.
set wildmenu
set wildmode=list:longest
set wildignore+=*.git,*.log,*.pdf,*.swp,*.o,*.hi,*.py[co],*~

" Flexible backspace: allow backspacing over autoindent, line breaks, start of
" insert.
set backspace=indent,eol,start

" Buffer movement (C-n - next, C-p - previous).
map <C-n> :bn<cr>
map <C-p> :bp<cr>


" Use zl to list buffers, and go to matching buffer
" Type part of bufname after prompt.
nmap zl :ls!<CR>:buf 


" Quickly create a new tab
map <leader>t <Esc>:tabnew<CR>


" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
" map <leader>e :e! ~/.vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc


" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
" get rid of search highlighting by hitting return
nnoremap <CR> :noh<CR><CR>

" Directories for swp files
set backupdir=~/.backuptmp
set directory=~/.backuptmp


function! s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

function! s:setupMarkup()
  set ft=markdown
  colorscheme inkpot
  call s:setupWrapping()
endfunction


" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" empty tex files default to latex
let g:tex_flavor='latex'
let g:Tex_ViewRule_ps = 'Preview'
let g:Tex_ViewRule_pdf = 'Skim'
let g:Tex_CompileRule_pdf = 'xelatex -shell-escape -synctex=1 --interaction=nonstopmode $*'
let g:Tex_DefaultTargetFormat = 'pdf'

" For Asymptote files
au BufRead,BufNewFile *.asy setf asy
