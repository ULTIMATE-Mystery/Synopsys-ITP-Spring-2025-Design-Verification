"highlight LineNr ctermfg=7 ctermbg=None
"highlight Normal guifg=white guibg=black
set syntax=verilog
set nu
set tabstop=2       " A tab character looks like 4 spaces
set shiftwidth=2    " Indent levels (>> << ==) are 4 spaces

set nocompatible
syntax enable
" set cursorline
set background=dark " Optimize highlight for dark background
set termguicolors

" Colors for code elements
"highlight Normal					guifg=#b9c8c9
"highlight Comment        guifg=#6f737d 
"highlight Keyword         guifg=#a627a4
"highlight Identifier      guifg=#0a82bb
"highlight Type           guifg=#eca013
"highlight Constant       guifg=#e25849
"highlight String         guifg=#50a14f
"highlight Number         guifg=#b68430
"highlight Statement      guifg=#a627a4
"highlight Function       guifg=#82aaff
"highlight PreProc        guifg=#0a82bb 

" UI colors
highlight LineNr         guifg=#dfe2eb guibg=#15274f
highlight CursorLineNr   guifg=#ffffff guibg=#232529
highlight CursorLine     guibg=#ffffff
highlight Visual         guibg=#094d2a
"highlight Pmenu          guibg=#1e1e2e guifg=#cbe3e7
"highlight PmenuSel       guibg=#444267 guifg=#ffffff



" ====== Highlight (Hex Color) ======
" Normal 			: normal code
" Comment 		: comment
" Type				: not applicable in verilog syntax
" Constant		: capitalized words (MODE, FIRST, SECOND)
" String			: string
" Number			: numbers (1, 2, 3. etc.)
" Statement		: begin, end, function, class, etc.
" Function		: +, -, *, ~, #, ;, etc.
" PreProc			: $display, $realtime, etc.
"
" Color picker online			: https://www.w3schools.com/colors/colors_picker.asp
" Color scheme reference	: https://vimcolorschemes.com/i/trending