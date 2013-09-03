set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim

" if has("unix")
"     let s:uname = system("uname")
"     if s:uname == "Darwin\n"
"         " Do Mac stuff here
"         set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim
"         " set clipboard=unnamed
"     endif
" endif


" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'aaronbieber/quicktask'
Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline'
Bundle 'epeli/slimux'
Bundle 'groenewege/vim-less'
Bundle 'hdima/vim-scripts'
Bundle 'kien/ctrlp.vim'
Bundle 'klen/python-mode'
Bundle 'majutsushi/tagbar'
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
Bundle 'mikewest/vimroom'
Bundle 'mileszs/ack.vim'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'othree/html5.vim'
Bundle 'peterhoeg/vim-qml'
Bundle 'puppetlabs/puppet-syntax-vim'
Bundle 'saltstack/salt-vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tejr/sahara'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tsaleh/vim-matchit'

" vim-scripts
Bundle 'MatchTag'
Bundle 'python.vim--Vasiliev'

if has("gui_running")
    set guioptions-=T
    set guioptions-=r
    set guifont=Envy\ Code\ R\ for\ Powerline:h11
endif

filetype plugin indent on

set background=dark
set encoding=utf-8
set laststatus=2
set mouse=a
set noshowmode
set t_Co=256

colorscheme sahara
syntax on

let mapleader = ","

map <down> <nop>
map <left> <nop>
map <right> <nop>
map <up> <nop>

map tc :tabclose<CR>
map tl :tabnext<CR>
map th :tabprev<CR>
map tw :tabnew<CR>

" map <C-c> :tabnew<CR>
" map <C-h> :tabprev<CR>
" map <C-l> :tabprev<CR>
" map <C-x> :tabclose<CR>

imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
imap <up> <nop>

inoremap <esc> <nop>
inoremap jk <esc>

nmap <leader>f :CtrlP<CR>
nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>l :set list!<CR>
nmap <silent> <leader>n :silent :nohlsearch<CR>

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

" tmp dir
" set backupdir=~/.vimtmp,~/.tmp,~/tmp,/tmp
" set directory=~/.vimtmp,~/.tmp,~/tmp,/tmp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.class,static/,env/,media/
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$\|env\|media$'

" allows to use :w!! if we forgot to use sudo vim file
cmap w!! %!sudo tee > /dev/null %

nnoremap <C-e> 3<C-e>
nnoremap <F3> :call NumberToggle()<cr>
nnoremap <C-y> 3<C-y>

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" sort
vnoremap <leader>s :sort<cr>
au FocusLost * :wa
au BufNewFile,BufRead *.less set filetype=less

" sets python file to convert tab to space
"autocmd FileType python setlocal expandtab

" auto converts less file to css by running lessc command against the file
" autocmd BufWritePost *.less :silent exe '!lessc ' . shellescape(expand('<afile>')) . ' ' . shellescape(expand('<afile>:r')) . '.css'

" html uses 2 tabs
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2
autocmd FileType xhtml setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
autocmd FileType java setlocal noexpandtab
autocmd FileType cpp setlocal noexpandtab

" auto reload vimrc after save
:au! BufWritePost $MYVIMRC source $MYVIMRC

" ctrl-p
let g:ctrlp_open_new_file = 't'

" python-mode
" let g:pymode = 1
" let g:pymode_lint = 1
let g:pymode_rope = 0
let g:pymode_lint_checker = "pyflakes,pep8,mccabe"
let g:pymode_lint_ignore = "E251,E501"

" indent guides
let g:indent_guides_guide_size = 1

" gitgutter
let g:gitgutter_highlight_lines = 1

" slimux
map <leader>sp :SlimuxShellPrompt<cr>
map <leader>sl :SlimuxShellLast<cr>

" nerdtree
let NERDTreeIgnore = ['\.pyc$']

" numbers.vim
nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>

" lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" function! NumberToggle()
"     if(&relativenumber == 1)
"         set number
"     else
"         set relativenumber
"     endif
" endfunc

" airline
let g:airline_powerline_fonts = 1
