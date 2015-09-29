syntax on
set expandtab
set smarttab
set autoindent
set showmatch
set encoding=utf-8
set nobackup
set ttyfast
set ttymouse=xterm2
set mouse=a
set shiftwidth=2
set nowrap
set hlsearch
set number
set guicursor+=a:blinkon0
set spelllang=sv,en
set runtimepath^=~/.vim/bundle/ctrlp.vim
colorscheme github

"filetype indent on
filetype plugin indent on
let g:rainbow_activate = 1

autocmd FileType haskell nmap <C-c><C-l> :GhciRange<CR>
autocmd FileType haskell vmap <C-c><C-l> :GhciRange<CR>
autocmd FileType haskell nmap <C-c><C-f> :GhciFile<CR>



augroup Makefiles
  au!
  au BufEnter *Makefile.* setf make
  au BufEnter *Makefile.* set noexpandtab 
augroup end

noremap Q :

noremap T n
noremap t j
noremap n k
noremap s l

noremap K S
noremap k s

noremap N n
noremap T N

noremap w %

map - o<ESC>
map _ O<ESC>

 call pathogen#infect()
