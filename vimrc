set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter' " show what's changed in vcs
Plug 'arrufat/vala.vim'  " vala syntax
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': './install.sh'}
Plug 'dart-lang/dart-vim-plugin'
Plug 'editorconfig/editorconfig-vim'
Plug 'elixir-editors/vim-elixir'
Plug 'elmcast/elm-vim'
Plug 'epeli/slimux' " tmux integration
Plug 'gruvbox-community/gruvbox' " theme
Plug 'huyvohcmc/atlas.vim'
Plug 'itchyny/lightline.vim'
Plug 'leafgarland/typescript-vim'
Plug 'mattn/gist-vim' " gist integration
Plug 'mattn/webapi-vim' " used by gist-vim
Plug 'mengelbrecht/lightline-bufferline'
Plug 'mhinz/vim-mix-format'  " mix format wrapper
Plug 'mileszs/ack.vim' " ack in vim
Plug 'mklabs/split-term.vim' " :terminal utility
Plug 'ntpeters/vim-better-whitespace' " highlight extra whitespace
Plug 'posva/vim-vue' " vue
Plug 'reasonml-editor/vim-reason-plus' " reason for vim
Plug 'rhysd/git-messenger.vim'
Plug 'scrooloose/nerdtree' " simple tree file manager
Plug 'smallwat3r/vim-simplicity'
Plug 'tpope/vim-commentary' " easy way to comment the code
Plug 'tpope/vim-fugitive' " git integration
Plug 'w0rp/ale'
Plug 'wakatime/vim-wakatime'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" ncm2 stuff
Plug 'roxma/nvim-yarp' " required by ncm2/ncm2
Plug 'ncm2/ncm2'  " formerly nvim-completion-manager
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'


" " syntax
" Plug 'bling/vim-airline' " working statusline
" Plug 'davidhalter/jedi-vim' " autocomplete
" Plug 'digitaltoad/vim-jade'
" Plug 'hdima/vim-scripts'
" Plug 'othree/html5.vim'
" Plug 'othree/xml.vim'
" Plug 'saltstack/salt-vim'
" Plug 'szw/vim-ctrlspace' " workspace thing
" Plug 'mattn/emmet-vim' " html

" Plug 'tpope/vim-markdown' " markdown syntax
" Plug 'tpope/vim-unimpaired' " pairs of handy bracket mappings
" Plug 'scrooloose/syntastic' " syntax thing
" Plug 'tmhedberg/matchit' " html match %
" Plug 'majutsushi/tagbar'
" Plug 'matchit.zip'
" Plug 'nathanaelkane/vim-indent-guides'
" Plug 'python.vim--Vasiliev'
" Plug 'gregsexton/MatchTag' " highlight matching html tag
" Plug 'groenewege/vim-less' " less syntax
" Plug 'kballard/vim-swift' " swift syntax, used by syntastic
" Plug 'kchmck/vim-coffee-script' " coffee syntax
" Plug 'klen/python-mode' " the python complete stuff
" Plug 'tmhedberg/SimpylFold' " python fold

call plug#end()

filetype plugin indent on

set background=dark
set encoding=utf-8
set mouse=a
set noshowmode
set t_Co=256
set laststatus=2

if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes
    " work properly when Vim is used inside tmux and GNU screen.
    set t_ut=
endif

colorscheme simplicity  " atlas gruvbox
syntax on

set clipboard=unnamed " osx clipboard
set colorcolumn=100 " sets a color marker in col 80
set cursorline " cursor line color background
set expandtab " converts tab to space
set exrc " enable per-directory .vimrc files
set hidden
set hlsearch " highlight the search
set ignorecase " ignore case search
set incsearch
" set list " whitespace sign
" set listchars=tab:▸\ ,trail:·,eol:¬
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set nobackup " doesn't create backup
set number relativenumber " line number and relative line number
set ruler
set scrolloff=3 " scroll 3 lines before border
set secure " disable unsafe commands in local .vimrc files
set shiftwidth=4 " column count when doing reindent << >>
set smartcase " search upper case when given
set tabstop=4 " column each tab pressed
" set termguicolors
set title " set terminal title
set wildmenu " show completion options
set wildmode=list:longest
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.class,*.pdf,static/,env/,media/,venv/,*/CACHE/,*/node_modules/,*/__pycache__/*,*.db,_build/
set wrap

" vimr
if has("gui_vimr")
    " set guifont=Monoid:h9
    set title
endif

let mapleader = ","

" fzf
map <C-p> :Files<CR>

" ack
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" allows to use :w!! if we forgot to use sudo vim file
cmap w!! %!sudo tee > /dev/null %

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" buffer
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprevious<CR>
nnoremap <leader>bd :1,100bd<CR>

" slimux
map <leader>$ :SlimuxShellPrompt<CR>
map <leader># :SlimuxShellLast<CR>

" terminal
highlight TermCursor ctermfg=red guifg=red
tnoremap <Leader><ESC> <C-\><C-n>

autocmd FileType cpp setlocal noexpandtab
autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2
autocmd FileType java setlocal noexpandtab
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType reason setlocal shiftwidth=2 tabstop=2
autocmd FileType scss setlocal shiftwidth=2 tabstop=2
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2
autocmd FileType xml setlocal shiftwidth=4 tabstop=4
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

" enable ncm2 for all buffer
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" language server
nnoremap <leader>fm :call LanguageClient_textDocument_formatting()<cr>

" set python bin for neovim
let NERDTreeIgnore = ['\.pyc$', '\.pdf$', '__pycache__']

let g:ale_fixers = {
    \ 'css': ['prettier'],
    \ 'javascript': ['prettier'],
    \ 'python': ['black'],
    \ }
let g:ale_linters = {
    \ 'python': ['flake8'],
    \ }
let g:ale_fix_on_save = 1
let g:ale_virtualenv_dir_names = ['.env', '.venv', 'env', 'venv']
let g:ale_python_black_options = '--safe'
let g:ale_python_flake8_options = '--ignore=E501'
let g:ale_javascript_prettier_options = '--single-quote'
let g:ale_javascript_prettier_use_local_config = 1

" elm
autocmd FileType elm nmap <leader>m <Plug>(elm-make)
let g:elm_browser_command = ""
let g:elm_detailed_complete = 0
let g:elm_format_autosave = 1
let g:elm_format_fail_silently = 0
let g:elm_jump_to_error = 0
let g:elm_make_output_file = "elm.js"
let g:elm_make_show_warnings = 0
let g:elm_setup_keybindings = 1

" fold
set foldmethod=syntax " syntax highlighting items specify folds
set foldcolumn=1 " defines 1 col at window left, to indicate folding
set foldlevelstart=99 " start file with all folds opened
set showtabline=2

let javaScript_fold=1 " activate folding by JS syntax

" let g:mix_format_on_save = 1

" gist
let g:gist_open_browser_after_post = 1
let g:gist_post_private = 1

let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }

let g:lightline#bufferline#show_number = 1
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#unnamed = '[No Name]'

" let g:lightline = {}
let g:lightline.tabline = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type = {'buffers': 'tabsel'}

" language client
let g:LanguageClient_serverCommands = {
    \ 'reason': ['~/bin/reason-language-server'],
    \ }
" let g:LanguageClient_serverCommands = {
"     \ 'reason': ['ocaml-language-server', '--stdio'],
"     \ 'ocaml': ['ocaml-language-server', '--stdio'],
"     \ }

" python
" pdb
nnoremap <leader>p Oimport pdb; pdb.set_trace()<Esc>

" pre save
" autocmd BufWritePre * %s/\s\+$//e
" autocmd BufWritePre * :%s/\s+$//e

source ~/.vimrc.python

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

" " gitgutter
" let g:gitgutter_highlight_lines = 0
" let g:gitgutter_sign_column_always = 1

" " gist
" let g:gist_open_browser_after_post = 1

" set clipboard+=unnamed
" set number                          " line number
" set relativenumber

" " disable arrow navigation
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>
" map <up> <nop>

" imap <down> <nop>
" imap <left> <nop>
" imap <right> <nop>
" imap <up> <nop>

" inoremap <esc> <nop>
