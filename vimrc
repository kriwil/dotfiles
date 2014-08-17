set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/vundle'

Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'digitaltoad/vim-jade'
Plugin 'epeli/slimux'
Plugin 'groenewege/vim-less'
Plugin 'hdima/vim-scripts'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'klen/python-mode'
Plugin 'majutsushi/tagbar'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'mileszs/ack.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'othree/html5.vim'
Plugin 'othree/xml.vim'
Plugin 'saltstack/salt-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
" colorscheme
Plugin 'w0ng/vim-hybrid'

" vim-scripts
Plugin 'MatchTag'
Plugin 'matchit.zip'
Plugin 'python.vim--Vasiliev'

call vundle#end()
filetype plugin indent on

set background=dark
set encoding=utf-8
set laststatus=2
set mouse=a
set noshowmode
set t_Co=256

colorscheme hybrid
syntax on

let mapleader = ","

map <down> <nop>
map <left> <nop>
map <right> <nop>
map <up> <nop>

" buffer
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprevious<CR>

imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
imap <up> <nop>

inoremap <esc> <nop>

nmap <leader>f :CtrlP<CR>
nmap <leader>a :CtrlPMixed<CR>
nmap <leader>b :CtrlPBuffer<CR>
nmap <silent> <leader>n :silent :nohlsearch<CR>

vnoremap <leader>s :sort<CR>

" set clipboard+=unnamed
" set number                          " line number
" set relativenumber
set colorcolumn=80                  " sets a color marker in col 80
set cursorline                      " cursor line color background
set expandtab                       " converts tab to space
set exrc                            " enable per-directory .vimrc files
set hidden
set hlsearch                        " highlight the search
set ignorecase                      " ignore case search
set incsearch
set list                            " whitespace sign
set listchars=tab:▸\ ,trail:·,eol:¬
set nobackup                        " doesn't create backup
set ruler
set scrolloff=3                     " scroll 3 lines before border
set secure                          " disable unsafe commands in local .vimrc files
set shiftwidth=4                    " column count when doing reindent << >>
set smartcase                       " search upper case when given
set tabstop=4                       " column each tab pressed
set title                           " set terminal title
set wildmenu                        " show completion options
set wildmode=list:longest

" numbers
set rnu
au BufEnter * :set rnu
au BufLeave * :set nu
au FocusGained * :set rnu
au FocusLost * :set nu
au InsertEnter * :set nu
au InsertLeave * :set rnu
au WinEnter * :set rnu
au WinLeave * :set nu

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.class,static/,env/,media/
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|^env$\|media$\|static$'

" allows to use :w!! if we forgot to use sudo vim file
cmap w!! %!sudo tee > /dev/null %

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

autocmd FileType coffee setlocal shiftwidth=2 tabstop=2
autocmd FileType cpp setlocal noexpandtab
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2
autocmd FileType java setlocal noexpandtab
autocmd FileType xhtml setlocal shiftwidth=2 tabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

" auto reload vimrc after save
:au! BufWritePost $MYVIMRC source $MYVIMRC

" ctrl-p
let g:ctrlp_open_new_file = 't'

" python-mode
let g:pymode_lint = 1
let g:pymode_rope = 0
let g:pymode_lint_checker = "pyflakes,pep8,mccabe"
let g:pymode_lint_ignore = "E251,E501,E128,E261,C901"

" indent guides
let g:indent_guides_guide_size = 1

" gitgutter
let g:gitgutter_highlight_lines = 0
let g:gitgutter_sign_column_always= 1

" slimux
map <leader>sp :SlimuxShellPrompt<cr>
map <leader>sl :SlimuxShellLast<cr>

" nerdtree
let NERDTreeIgnore = ['\.pyc$']

" airline
let g:airline_powerline_fonts = 1

" gist
" let g:gist_clip_command = 'xclip -selection clipboard'
" let g:gist_open_browser_after_post = 1
