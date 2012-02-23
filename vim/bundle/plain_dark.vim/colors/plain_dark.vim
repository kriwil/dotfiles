set background=dark
highlight clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "plain_dark"

" generic
highlight Comment ctermfg=LightGreen ctermbg=None
highlight Constant ctermfg=LightYellow ctermbg=None
highlight Identifier ctermfg=None ctermbg=None
highlight Statement ctermfg=LightBlue ctermbg=None
highlight PreProc ctermfg=LightBlue ctermbg=None
highlight Type ctermfg=None ctermbg=None
highlight Special ctermfg=None ctermbg=None
highlight Underlined ctermfg=None ctermbg=None
highlight Ignore ctermfg=None ctermbg=None
highlight Error ctermfg=Red ctermbg=None
highlight Todo ctermfg=Yellow ctermbg=None

" vim
highlight ColorColumn ctermfg=None ctermbg=DarkGrey
highlight Conceal ctermfg=None ctermbg=None
highlight Cursor ctermfg=none ctermbg=none
highlight cursorim ctermfg=none ctermbg=none
highlight cursorcolumn ctermfg=none ctermbg=none
highlight cursorline ctermfg=None ctermbg=None
highlight Directory ctermfg=None ctermbg=None
highlight DiffAdd ctermfg=None ctermbg=None
highlight DiffChange ctermfg=None ctermbg=None
highlight DiffDelete ctermfg=None ctermbg=None
highlight DiffText ctermfg=None ctermbg=None
highlight ErrorMsg ctermfg=None ctermbg=None
highlight VertSplit ctermfg=None ctermbg=None
highlight Folded ctermfg=None ctermbg=None
highlight FoldColumn ctermfg=None ctermbg=None
highlight SignColumn ctermfg=None ctermbg=None
highlight IncSearch ctermfg=None ctermbg=None
highlight LineNr ctermfg=DarkGrey ctermbg=None
highlight MatchParent ctermfg=None ctermbg=None
highlight ModeMsg ctermfg=None ctermbg=None
highlight MoreMsg ctermfg=None ctermbg=None
highlight NonText ctermfg=DarkGrey ctermbg=None
highlight Normal ctermfg=None ctermbg=None
highlight Pmenu ctermfg=None ctermbg=None
highlight PmenuSel ctermfg=None ctermbg=None
highlight PmenuSbar ctermfg=None ctermbg=None
highlight PmenuThumb ctermfg=None ctermbg=None
highlight Question ctermfg=None ctermbg=None
highlight Search ctermfg=Black ctermbg=LightYellow cterm=underline
highlight SpecialKey ctermfg=DarkGrey ctermbg=None
highlight SpellBad ctermfg=None ctermbg=DarkRed
highlight SpellCap ctermfg=None ctermbg=None
highlight SpellLocal ctermfg=None ctermbg=None
highlight SpellRare ctermfg=None ctermbg=none
highlight statusline ctermfg=none ctermbg=none
highlight statuslinenc ctermfg=none ctermbg=none
highlight tabline ctermfg=LightGrey ctermbg=none
highlight tablinefill ctermfg=Black ctermbg=none
highlight tablinesel ctermfg=Black ctermbg=LightGrey
highlight Title ctermfg=None ctermbg=None
highlight Visual ctermfg=Black ctermbg=LightGreen
highlight WarningMsg ctermfg=None ctermbg=None
highlight WildMenu ctermfg=None ctermbg=None

" python
highlight link PythonPreCondit PreProc
highlight link PythonStatement Statement
highlight link PythonString Constant
highlight link PythonDottedName PythonStatement
highlight PythonFunction ctermfg=None ctermbg=None

" ummm ...
"highlight LineNr ctermfg=DarkGray ctermbg=None

"highlight Comment ctermfg=100 ctermbg=None
"highlight LineNr ctermfg=247 ctermbg=None

" python
"highlight PythonFunction ctermfg=None ctermbg=None
"highlight PythonStatement ctermfg=117 ctermbg=None
"highlight PythonString ctermfg=72 ctermbg=None
"highlight link PythonPreCondit PythonStatement
