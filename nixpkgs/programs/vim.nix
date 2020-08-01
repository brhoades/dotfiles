{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      YouCompleteMe syntastic fugitive airline ctrlp vim-nix
    ];

    extraConfig = ''
set hidden
set colorcolumn=80
set mouse=
set backspace=indent,eol,start
" set ttymouse= not in nvim

set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set nocindent

set incsearch  " Displays search matches as you type
set hlsearch   " Highlights all search terms
set ignorecase " Default to ignoring case
set smartcase  " However if there's a capital it's case sensitve

silent !mkdir $HOME/.vim > /dev/null 2>&1
silent !mkdir $HOME/.vim/backups > /dev/null 2>&1
silent !mkdir $HOME/.vim/undo > /dev/null 2>&1
silent !mkdir $HOME/.vim/swaps > /dev/null 2>&1

" Swapfile and enable backups
set backup
set dir=$HOME/.vim/swaps//
set backupdir=$HOME/.vim/backups//

" undo storage
set undofile
set undodir=$HOME/.vim/undo//
set undolevels=5000
set undoreload=50000
let myvar = "set backupext=_". strftime("--%y%m%d--%Hh%M")
execute myvar
  '';
  };
}
