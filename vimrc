call pathogen#infect()
call pathogen#helptags()

colorscheme jellybeans
filetype plugin indent on
syntax on                           " syntax hightlighting

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

set background=dark                 " dark background
set colorcolumn=80                  " sets a color marker in col 80
set expandtab                       " converts tab to space
set number                          " line number
set hlsearch                        " highlight the search
set nobackup                        " doesn't create backup
set shiftwidth=4                    " column count when doing reindent << >>
set tabstop=4                       " column each tab pressed

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

"" sets python file to convert tab to space
"autocmd FileType python setlocal expandtab

" toggle set list
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" allow to use :w!! if we forgot to use sudo vim file
cmap w!! %!sudo tee > /dev/null %

" auto convert less file to css by running lessc command against the file
au BufNewFile,BufRead *.less set filetype=less
autocmd BufWritePost *.less :silent exe '!lessc ' . shellescape(expand('<afile>')) . ' ' . shellescape(expand('<afile>:r')) . '.css'

