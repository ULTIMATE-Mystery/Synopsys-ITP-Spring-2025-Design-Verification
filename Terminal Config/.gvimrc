" General settings
set nocompatible
syntax enable
set syntax=verilog
set nu                       " Show line numbers
set tabstop=2                " A tab character looks like 2 spaces
set shiftwidth=2             " Indent levels (>> << ==) are 2 spaces
set background=dark          " Optimize for dark background
set termguicolors            " Enable 24-bit colors
" set guicursor=
set guicursor=n-v-c:block-blinkon500-blinkoff500-blinkwait500

" Cursor and line highlights
" set cursorline              " Uncomment to highlight the current line
highlight LineNr           guifg=#dfe2eb guibg=#15274f
highlight CursorLineNr     guifg=#ffffff guibg=#232529
highlight CursorLine       guibg=#ffffff
highlight Visual           guibg=#094d2a

" Syntax highlighting (GUI colors only work in gvim)
highlight Normal           guifg=#b9c8c9 guibg=black
"highlight Comment          guifg=#6f737d
"highlight Keyword          guifg=#a627a4
"highlight Identifier       guifg=#0a82bb
"highlight Type             guifg=#eca013
"highlight Constant         guifg=#e25849
"highlight String           guifg=#50a14f
"highlight Number           guifg=#b68430
"highlight Statement        guifg=#a627a4
"highlight Function         guifg=#82aaff
"highlight PreProc          guifg=#0a82bb

" Optional popup menu (used in autocompletion)
" highlight Pmenu            guibg=#1e1e2e guifg=#cbe3e7
" highlight PmenuSel         guibg=#444267 guifg=#ffffff