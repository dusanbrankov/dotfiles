vim.cmd([[
    command! -bang MyFiles call fzf#run(fzf#wrap({
        \ 'source': 'fdfind . --type file --hidden --strip-cwd-prefix',
        \ 'sink': 'edit',
        \ 'options': ['--multi', '--pointer', ' ', '--marker', '*', '--preview', 'batcat --number --color always {}', '--preview-window', 'hidden,right,border-none', '--color', 'fg+:white,fg:247,bg+:-1,prompt:white,info:grey']
        \ }, <bang>0))
]])

