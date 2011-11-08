"   __plugin__ https://github.com/kevinw/pyflakes-vim.git
"   __plugin__ https://github.com/mattn/zencoding-vim.git
"   __plugin__ https://github.com/mhz/vim-matchit.git
"   __plugin__ https://github.com/nanotech/jellybeans.vim.git
"   __plugin__ https://github.com/scrooloose/nerdtree.git
"   __plugin__ https://github.com/vim-scripts/python.vim--Vasiliev.git

call pathogen#infect()
call pathogen#helptags()

colorscheme jellybeans
filetype plugin indent on
syntax on                           " syntax hightlighting

" gvim
if has('gui_gtk2')
    set guifont=Envy\ Code\ R\ 11   " the coolest font. ever.
    set guioptions-=r               " removes right-hand scroll bar
    set guioptions-=l               " removes left-hand scroll bar
    set guioptions-=R               " removes right-hand scroll bar when splitted
    set guioptions-=L               " removes left-hand scroll bar when splitted
    set guioptions-=m               " removes menu bar
    set guioptions-=T               " removes toolbar
endif

map <down> <nop>                    " disable down
map <left> <nop>                    " disable left
map <right> <nop>                   " disable right
map <up> <nop>                      " disable up 

imap <down> <nop>                   " disable down in insert mode
imap <left> <nop>                   " disable left in insert mode
imap <right> <nop>                  " disable right in insert mode
imap <up> <nop>                     " disable up  in insert mode

map tn :tabnext<CR>                 " tab next shortcut
map tp :tabprev<CR>                 " tab prev shortcut
map tc :tabclose<CR>                " tab close shortcut
map tw :tabnew<CR>                  " tab new shortcut

" FuzzyFinder
nmap ,f :FufFileWithCurrentBufferDir<CR>
nmap ,b :FufBuffer<CR>
nmap ,t :FufTaggedFile<CR>

" lcd
map lcdt lcd ~/Temp<CR>
map lcdw lcd ~/Workspace<CR>

set background=dark                 " dark background
set colorcolumn=80                  " sets a color marker in col 80
set expandtab                       " converts tab to space
set number                          " line number
set hlsearch                        " highlight the search
set list                            " whitespace sign
set nobackup                        " doesn't create backup
set shiftwidth=4                    " column count when doing reindent << >>
set tabstop=4                       " column each tab pressed

" Save when losing focus
au FocusLost * :wa

"" sets python file to convert tab to space
"autocmd FileType python setlocal expandtab

" toggles set list
nmap <leader>l :set list!<CR>

" Uses the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" allows to use :w!! if we forgot to use sudo vim file
cmap w!! %!sudo tee > /dev/null %

" auto converts less file to css by running lessc command against the file
au BufNewFile,BufRead *.less set filetype=less
autocmd BufWritePost *.less :silent exe '!lessc ' . shellescape(expand('<afile>')) . ' ' . shellescape(expand('<afile>:r')) . '.css'

" surrounds a word in double quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

" exits insert mode
inoremap jk <esc>

" disables normal exit
inoremap <esc> <nop>

" commands the current line
autocmd FileType javascript nnoremap <buffer> <localleader>c I//
autocmd FileType python     nnoremap <buffer> <localleader>c I#


com Hescardev lcd /home/aldi/Workspace/hescar_django/development/

" vim
"autocmd VimEnter * NERDTree
autocmd BufEnter * NERDTreeMirror
