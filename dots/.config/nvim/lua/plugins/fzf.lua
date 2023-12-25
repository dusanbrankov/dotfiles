return {
    { 
        "junegunn/fzf.vim",
        config = function ()
            vim.keymap.set("n", "<leader>ff", ":MyFiles<cr>")
            vim.keymap.set("n", "<leader>ft", ":CNewTab<cr>")
            vim.keymap.set("n", "<leader>fg", ":Rg<cr>")
            vim.keymap.set("n", "<leader>fb", ":Buffers<cr>")
        end
    },
    {
        "junegunn/fzf",
        config = function ()
            vim.cmd([[
                let g:fzf_layout = { "window": { "width": 1.0, "height": 0.6, "relative": v:true, "yoffset": 1.0 } }
            ]])
        end
    },
}
