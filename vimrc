"   TODO: update these
"   __plugin__ https://github.com/kevinw/pyflakes-vim.git
"   __plugin__ https://github.com/mattn/zencoding-vim.git
"   __plugin__ https://github.com/mhz/vim-matchit.git
"   __plugin__ https://github.com/nanotech/jellybeans.vim.git
"   __plugin__ https://github.com/scrooloose/nerdtree.git
"   __plugin__ https://github.com/vim-scripts/python.vim--Vasiliev.git

call pathogen#infect()
call pathogen#helptags()

set t_Co=256
set background=dark                 " dark background
" colorscheme desert
" colorscheme jellybeans
" colorscheme blackboard
" colorscheme solarized
colorscheme plain_dark

" vim-powerlline
" let g:Powerline_symbols = 'fancy'
" set laststatus=2

filetype plugin indent on
syntax on                           " syntax hightlighting

" gvim
if has('gui_gtk2')
    "colorscheme solarized

    set guifont=Envy\ Code\ R\ 11  " the coolest font. ever.
    set guioptions-=r              " removes right-hand scroll bar
    set guioptions-=l              " removes left-hand scroll bar
    set guioptions-=R              " removes right-hand scroll bar when splitted
    set guioptions-=L              " removes left-hand scroll bar when splitted
    set guioptions-=m              " removes menu bar
    set guioptions-=T              " removes toolbar
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
"nmap <leader>f :FufFileWithCurrentBufferDir **/<CR>
nmap <leader>f :FufFile<CR>
nmap <leader>g :FufFileWithCurrentBufferDir<CR>
nmap <leader>b :FufBuffer<CR>
nmap <leader>t :FufTaggedFile<CR>

let g:fuf_file_exclude = '\v\~$|\.pyc$|\.orig$|\.bak$|\.swp|\.swo$'
"let g:fuf_keyComplete = <Tab>

set colorcolumn=80                  " sets a color marker in col 80
set exrc                            " enable per-directory .vimrc files
set expandtab                       " converts tab to space
set number                          " line number
set hlsearch                        " highlight the search
set list                            " whitespace sign
set nobackup                        " doesn't create backup
set secure                          " disable unsafe commands in local .vimrc files
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

" rope
source /home/aldi/lib/ropevim/rope.vim

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
