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
        "rose-pine/neovim"
    },
    {
        "blazkowolf/gruber-darker.nvim",
        opts = {
            bold = false,
            invert = {
                signs = false,
                tabline = false,
                visual = false,
            },
            italic = {
                strings = false,
                comments = false,
                operators = false,
                folds = true,
            },
            undercurl = true,
            underline = true,
        }
    },
    {
        "miikanissi/modus-themes.nvim",
        priority = 1000,
        config = function ()
            -- Default options
            require("modus-themes").setup({
                style = "auto",
                variant = "tinted", -- Theme comes in four variants `default`, `tinted`, `deuteranopia`, and `tritanopia`
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { fg = "#807777", italic = false },
                    keywords = { italic = false },
                    functions = {},
                    variables = {},
                },
                on_highlights = function(hl, c)
                    hl.Boolean = { fg = c.blue, bold = false }
                end,
            })

            -- vim.cmd.colorscheme("modus_vivendi")
            -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end
    },
    { 
        "olivercederborg/poimandres.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("poimandres").setup {
                disable_background = true, -- disable background
                disable_float_background = true, -- disable background for floats
                disable_italics = true,
            }
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end,

        -- optionally set the colorscheme within lazy config
        init = function()
            vim.cmd("colorscheme poimandres")
        end
    },
}
