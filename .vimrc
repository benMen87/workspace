set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" Dynamic ctags
"Bundle 'craigemery/vim-autotag'

"Git
Plugin 'tpope/vim-fugitive'

" Fuzy
Plugin 'junegunn/fzf.vim'
set rtp+=~/.fzf

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" ...

" highlight syntax 
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'

"YCM
Bundle 'Valloric/YouCompleteMe'

let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_server_python_interpreter='/usr/bin/python3.6'
map ,g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"PEP8 indentation
Plugin 'vim-scripts/indentpython.vim'

"status line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" split to the right
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J> 
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Indentation
au BufNewFile,BufRead *.py,*.cpp,*.c,*.h
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab | 
    \ set autoindent |
    \ set fileformat=unix

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

let python_highlight_all=1
syntax on

" Ctags
" set tags=./tags,tags,$HOME/tags

" open file in curr dir
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map ,x :split <C-R>=expand("%:p:h") . "/" <CR>
map ,v :vsplit <C-R>=expand("%:p:h") . "/" <CR>

" remape :wa to ,w
nnoremap ,w :wa<CR>

"" save and load sessions
fu! SaveSess()
    "if !isdirectory("~/.vim/sessions")
    "    execute 'call mkdir(~/.vim/sessions)'
    "endif
    execute 'mksession! ~/.vim/sessions/'.fnamemodify(getcwd(), ':t').'.vim'
endfunction

fu! RestoreSess()
    execute 'so  ~/.vim/sessions/'.fnamemodify(getcwd(), ':t').'.vim'
    if bufexists(1)
        for l in range(1, bufnr('$'))
            if bufwinnr(l) == -1
               exec 'sbuffer ' . l
            endif
         endfor
       endif
endfunction

nnoremap ,s : call SaveSess()<CR>
nnoremap ,r : call RestoreSess()<CR>

"map vimgrep to pfind
map <C-F> :execute "vimgrep /" . expand("<cword>") . "/gj **" <Bar> cw<CR>
command -nargs=1 VG vimgrep /<args>/gj ./**<CR>

"spell check
nmap <leader>W :setlocal spell! spell?<CR>

" map F5 to remove leading and trainlin white spaces
:nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

"autocmd VimLeave * call SaveSess()
"autocmd VimEnter * call RestoreSess()
