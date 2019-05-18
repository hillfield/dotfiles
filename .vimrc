
" Vim configuration
" Rev A, 2019-01-19
" Lars B.
"

set nocompatible            " required
set clipboard=unnamed		" Global clipboard
filetype off                " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
"-----------------------------------------------------------
"----------------- Custom plugins  -------------------------
"-----------------------------------------------------------

"------- Vundle ---------
Plugin 'VundleVim/Vundle.vim'
"--------- YCM ----------
Plugin 'rdnetto/YCM-Generator'
Plugin 'Valloric/YouCompleteMe'
"------- THEMES ---------
" Gruvbox theme
Plugin 'morhetz/gruvbox'
"" Dracula theme
Plugin 'dracula/vim'
"" Pale night
Plugin 'drewtempelmeyer/palenight.vim'
"-----------------------
" C++ Syntax highlightning
Plugin 'scrooloose/syntastic'
" Vim-LaTeX
Plugin 'vim-latex/vim-latex'
Plugin 'xuhdev/vim-latex-live-preview', {'for': 'tex'}
" Simply fold
Plugin 'tmhedberg/SimpylFold'
" Auto-indentation
Plugin 'vim-scripts/indentpython.vim'
" Pep8 support
Plugin 'nvie/vim-flake8'
" Powerline
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" Conda environments
Plugin 'cjrh/vim-conda'


call vundle#end()            " required
filetype plugin indent on    " required
"-----------------------------------------------------------
"----------------- Custom binds  ---------------------------
"-----------------------------------------------------------

" Misc options
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set relativenumber
set number
set autowrite
syntax on

" To move between windows efficiently
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l

" Format files
map <F10> mzgg=G`z

" Code folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" Apply YCM FixIt
" ----------------------------------------------------------
map <F9> :YcmCompleter FixIt<CR>

" Vim-LaTeX Preview window
" ----------------------------------------------------------
nnoremap <F12> :LLPStartPreview<CR>

" Applying themes
" ----------------------------------------------------------
colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark='hard'

"You complete me
" ----------------------------------------------------------
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

" C++ options
" ----------------------------------------------------------
let g:syntastic_cpp_checkers = ['clang_check', 'clang_tidy', 'gcc']
let g:syntastic_cpp_compiler = 'gcc'
let g:syntastic_cpp_compiler_options = '-std=c++14'

" Run code
au BufEnter,BufNew *.py map <C-c> :!g++ -std=c++14 % -Wall -g -o %.out && ./%.out<CR>
" nnoremap <C-c> :!g++ -std=c++14 % -Wall -g -o %.out && ./%.out<CR> 

augroup project
	autocmd!
	autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
augroup END

" Vim-Latex
" ----------------------------------------------------------
let g:livepreview_previewer = 'zathura'

" Syntastic
" ----------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Python options
" ----------------------------------------------------------
let g:ycm_python_interpreter_path = '/usr/bin/python3'
let g:ycm_python_sys_path = []
let g:powerline_pycmd="py3"
let python_highlight_all=1
" Suppress startup messages
let g:conda_startup_msg_suppress=1

let g:ycm_extra_conf_vim_data = [
			\  'g:ycm_python_interpreter_path',
			\  'g:ycm_python_sys_path'
			\]
" Python Pep8
au BufNewFile,BufRead *.py
			\set tabstop=4
			\set softtabstop=4
			\set shiftwidth=4
			\set textwidth=79
			\set expandtab
			\set autoindent
			\set fileformat=unix

" Python white space flagging
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Run code
"au BufEnter,BufNew *.py map <C-c> :exec '!python' shellescape(@%, 1) <CR>.
au BufEnter,BufNew *.py map <C-c> :exec '!python %' <CR>
au BufEnter,BufNew *.py map <F4> :CondaChangeEnv<CR>


"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
