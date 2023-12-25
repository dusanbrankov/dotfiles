vim.cmd([[
    highlight LineNr guibg=NONE guifg=#666666
    highlight SignColumn guibg=NONE

    highlight CursorLine guibg=#333333
    highlight CursorLineNr guibg=NONE

    " highlight tabline guifg=#888888 guibg=none
    " highlight tablinesel gui=bold guifg=#333333 guibg=#DDDDDD
    " highlight tablinefill guibg=none
    " https://learnvimscriptthehardway.stevelosh.com/chapters/17.html

    " highlight ModeMsg guibg=NONE guifg=#BAD7FF
    " highlight MsgArea guibg=#ffffff guifg=#E1E1E1

    " highlight StatusLineTextColor guifg=#a0a0a0
    " highlight StatusLineFileText guifg=#ffffff
    "
    " set statusline+=\%#StatusLineFileText#
    " set statusline+=%.40f%m\    " Path to the file
    " set statusline+=\%#StatusLineTextColor#
    " set statusline+=%Y\         " Filetype of the file
    " set statusline+=%=          " Switch to the right side
    " set statusline+=%l,%c       " Current line
    " set statusline+=/           " Separator
    " set statusline+=%L          " Total lines
]])

vim.cmd.highlight({ "EndOfBuffer", "ctermfg=NONE guifg=NONE" })

