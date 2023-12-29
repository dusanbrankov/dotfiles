return {
    {
        "aktersnurra/no-clown-fiesta.nvim",
        priority = 1000,
        config = function ()
            require("no-clown-fiesta").setup({
                transparent = true,
                styles = {
                    type = { bold = false },
                    lsp = { underline = true }
                }
            })
            vim.cmd.colorscheme("no-clown-fiesta")
        end
    },
    {
        "miikanissi/modus-themes.nvim",
        -- priority = 1000,
        -- config = function ()
        --     -- Default options
        --     require("modus-themes").setup({
        --         style = "auto",
        --         variant = "tinted", -- Theme comes in four variants `default`, `tinted`, `deuteranopia`, and `tritanopia`
        --         styles = {
        --             -- Style to be applied to different syntax groups
        --             -- Value is any valid attr-list value for `:help nvim_set_hl`
        --             comments = { fg = "#807777", italic = false },
        --             keywords = { italic = false },
        --             functions = {},
        --             variables = {},
        --         },
        --         on_highlights = function(hl, c)
        --             hl.Boolean = { fg = c.blue, bold = false }
        --         end,
        --     })
        --
            -- vim.cmd.colorscheme("modus")
            -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        -- end
    },
    {
        "michaeljsmith/vim-colours-dark-lord",
        -- config = function ()
        --     vim.cmd.colorscheme("darklord")
        --     vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        --     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        -- end
    },
    {
        "xero/miasma.nvim",
        -- priority = 1000,
        -- config = function()
        -- vim.cmd("colorscheme miasma")
        -- end
    },
    {
        "junegunn/seoul256.vim",
        -- priority = 1000,
        -- config = function ()
        --     vim.cmd.colorscheme("seoul256")
        --     vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        --     vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        -- end
    },
    {
        "ldelossa/vimdark",
    },
}
