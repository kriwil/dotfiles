set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/Vundle.vim' " let vundle manage vundle
Plugin 'w0ng/vim-hybrid' " colorscheme

Plugin 'kien/ctrlp.vim' " file finder
Plugin 'airblade/vim-gitgutter' " show what's changed in vcs
Plugin 'bling/vim-airline' " cool statusbar
Plugin 'epeli/slimux' " tmux integration
Plugin 'gregsexton/MatchTag' " highlight matching html tag
Plugin 'mattn/gist-vim' " gist integration
Plugin 'mattn/webapi-vim' " used by gist-vim
Plugin 'scrooloose/syntastic' " syntax thing
Plugin 'tpope/vim-commentary' " easy way to comment the code
Plugin 'tpope/vim-fugitive' " git integration

" " syntax
" Plugin 'digitaltoad/vim-jade'
" Plugin 'groenewege/vim-less'
" Plugin 'hdima/vim-scripts'
" Plugin 'kchmck/vim-coffee-script'
" Plugin 'othree/html5.vim'
" Plugin 'othree/xml.vim'
" Plugin 'saltstack/salt-vim'
" Plugin 'tpope/vim-markdown'

" Plugin 'klen/python-mode'
" Plugin 'majutsushi/tagbar'
" Plugin 'matchit.zip'
" Plugin 'mileszs/ack.vim'
" Plugin 'nathanaelkane/vim-indent-guides'
" Plugin 'python.vim--Vasiliev'
" Plugin 'scrooloose/nerdtree'

call vundle#end()
filetype plugin indent on

set background=dark
set encoding=utf-8
set mouse=a
set noshowmode
set t_Co=256
set laststatus=2

colorscheme hybrid
syntax on

map <down> <nop>
map <left> <nop>
map <right> <nop>
map <up> <nop>

imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
imap <up> <nop>

inoremap <esc> <nop>

set colorcolumn=80 " sets a color mjrker in col 80
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
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.class,static/,env/,media/

" let &colorcolumn=join(range(80,999),",")

" allows to use :w!! if we forgot to use sudo vim file
cmap w!! %!sudo tee > /dev/null %

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" buffer
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprevious<CR>

autocmd FileType coffee setlocal shiftwidth=2 tabstop=2
autocmd FileType cpp setlocal noexpandtab
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2
autocmd FileType java setlocal noexpandtab
autocmd FileType xhtml setlocal shiftwidth=2 tabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

let g:airline_powerline_fonts = 1

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

" " airline

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
