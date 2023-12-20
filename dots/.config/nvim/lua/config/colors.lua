vim.cmd([[
  highlight tabline guifg=#888888 guibg=none
  highlight tablinesel gui=bold guifg=white guibg=none
  highlight tablinefill guibg=none

  " https://learnvimscriptthehardway.stevelosh.com/chapters/17.html

  highlight LineNr guibg=NONE guifg=#666666

  highlight ModeMsg guibg=NONE guifg=#BAD7FF
  highlight MsgArea guibg=NONE guifg=#E1E1E1

  highlight StatusLineTextColor guifg=#a0a0a0
  highlight StatusLineFileText guifg=#ffffff
  
  set statusline+=\%#StatusLineFileText#
  set statusline+=%.40f%m\    " Path to the file
  set statusline+=\%#StatusLineTextColor#
  set statusline+=%Y\         " Filetype of the file
  set statusline+=%=          " Switch to the right side
  set statusline+=%l,%c       " Current line
  set statusline+=/           " Separator
  set statusline+=%L          " Total lines

]])

vim.cmd.highlight({ "EndOfBuffer", "ctermfg=NONE guifg=NONE" })

