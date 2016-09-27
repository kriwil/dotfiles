set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter' " show what's changed in vcs
Plug 'bling/vim-airline' " working statusline
Plug 'ctrlpvim/ctrlp.vim' " file finder
Plug 'epeli/slimux' " tmux integration
Plug 'gregsexton/MatchTag' " highlight matching html tag
Plug 'groenewege/vim-less' " less syntax
Plug 'kballard/vim-swift' " swift syntax, used by syntastic
Plug 'kchmck/vim-coffee-script' " coffee syntax
Plug 'klen/python-mode' " the python complete stuff
Plug 'mattn/gist-vim' " gist integration
Plug 'mattn/webapi-vim' " used by gist-vim
Plug 'mileszs/ack.vim' " ack in vim
Plug 'morhetz/gruvbox' " theme
Plug 'scrooloose/nerdtree' " simple tree file manager
Plug 'scrooloose/syntastic' " syntax thing
Plug 'tpope/vim-commentary' " easy way to comment the code
Plug 'tpope/vim-fugitive' " git integration
Plug 'tpope/vim-markdown' " markdown syntax
Plug 'tpope/vim-unimpaired' " pairs of handy bracket mappings
Plug 'wakatime/vim-wakatime'

" " syntax
" Plug 'digitaltoad/vim-jade'
" Plug 'hdima/vim-scripts'
" Plug 'othree/html5.vim'
" Plug 'othree/xml.vim'
" Plug 'saltstack/salt-vim'
" Plug 'szw/vim-ctrlspace' " workspace thing

" Plug 'majutsushi/tagbar'
" Plug 'matchit.zip'
" Plug 'nathanaelkane/vim-indent-guides'
" Plug 'python.vim--Vasiliev'

call plug#end()

filetype plugin indent on

set background=dark
set encoding=utf-8
set mouse=a
set noshowmode
set t_Co=256
set laststatus=2

colorscheme gruvbox
syntax on

map <down> <nop>
map <left> <nop>
map <right> <nop>
map <up> <nop>

imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
imap <up> <nop>

" inoremap <esc> <nop>

set clipboard=unnamed " osx clipboard
set colorcolumn=100 " sets a color marker in col 80
set cursorline " cursor line color background
set expandtab " converts tab to space
set exrc " enable per-directory .vimrc files
set hidden
set hlsearch " highlight the search
set ignorecase " ignore case search
set incsearch
set list " whitespace sign
set listchars=tab:▸\ ,trail:·,eol:¬
set nobackup " doesn't create backup
set relativenumber " relative number
set ruler
set scrolloff=3 " scroll 3 lines before border
set secure " disable unsafe commands in local .vimrc files
set shiftwidth=4 " column count when doing reindent << >>
set smartcase " search upper case when given
set tabstop=4 " column each tab pressed
set title " set terminal title
set wildmenu " show completion options
set wildmode=list:longest
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.class,*.pdf,static/,env/,media/,venv/,*/CACHE/,*/node_modules/,*/__pycache__/*,*.db
set wrap

" let &colorcolumn=join(range(80,999),",")

let mapleader = ","

" allows to use :w!! if we forgot to use sudo vim file
cmap w!! %!sudo tee > /dev/null %

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" buffer
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprevious<CR>

" slimux
map <leader>$ :SlimuxShellPrompt<CR>
map <leader># :SlimuxShellLast<CR>

autocmd FileType coffee setlocal shiftwidth=4 tabstop=4
autocmd FileType cpp setlocal noexpandtab
autocmd FileType html setlocal shiftwidth=4 tabstop=4
autocmd FileType htmldjango setlocal shiftwidth=4 tabstop=4
autocmd FileType java setlocal noexpandtab
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType xhtml setlocal shiftwidth=4 tabstop=4
autocmd FileType xml setlocal shiftwidth=4 tabstop=4
autocmd FileType yaml setlocal shiftwidth=4 tabstop=4

let NERDTreeIgnore = ['\.pyc$', '\.pdf$', '__pycache__']
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" python
let g:pymode_doc = 0
let g:pymode_lint = 0
let g:pymode_rope = 0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--ignore=E501'

" javascript
let g:syntastic_javascript_checkers = ['eslint']

" nmap <silent> <leader>n :silent :nohlsearch<CR>
" vnoremap <leader>s :sort<CR>

" " numbers
" set rnu
" au BufEnter * :set rnu
" au BufLeave * :set nu
" au FocusGained * :set rnu
" au FocusLost * :set nu
" au InsertEnter * :set nu
" au InsertLeave * :set rnu
" au WinEnter * :set rnu
" au WinLeave * :set nu

" nmap <leader>f :CtrlP<CR>
" nmap <leader>a :CtrlPMixed<CR>
" nmap <leader>b :CtrlPBuffer<CR>

" " gitgutter
" let g:gitgutter_highlight_lines = 0
" let g:gitgutter_sign_column_always = 1

" " gist
" let g:gist_open_browser_after_post = 1

" " ctrl-p
" let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|^env$\|media$'
" let g:ctrlp_open_new_file = 't'

" " python-mode
" let g:pymode_lint = 1
" let g:pymode_rope = 0
" let g:pymode_lint_checker = "pyflakes,pep8,mccabe"
" let g:pymode_lint_ignore = "E251,E501,E128,E261,C901"

" " indent guides
" let g:indent_guides_guide_size = 1

" " slimux
" map <leader>sp :SlimuxShellPrompt<cr>
" map <leader>sl :SlimuxShellLast<cr>

" " nerdtree
" let NERDTreeIgnore = ['\.pyc$']

" " set clipboard+=unnamed
" " set number                          " line number
" " set relativenumber
