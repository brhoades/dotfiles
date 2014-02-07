set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
let g:airline_powerline_fonts = 1
let g:airline_theme = 'solarized'
let g:airline#extensions#tabline#enabled = 1

" Tab Control: alt+#
map <A-1> 1gt
map <A-2> 2gt
map <A-3> 3gt
map <A-4> 4gt
map <A-5> 5gt
map <A-6> 6gt
map <A-7> 7gt
map <A-8> 8gt
map <A-9> 9gt

" Tab Control: Alt+L / Alt+R 
map <A-Left> :tabl
map <A-Right> :tabn


" Indentation
set autoindent
set smartindent

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'bling/vim-airline'

Bundle 'git://git.wincent.com/command-t.git'
filetype plugin indent on     " required!
