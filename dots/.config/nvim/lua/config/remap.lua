vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "v" }, "<leader>p", "\"_dP")

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set({ "n", "v" }, ";", ":")

-- Tab navigation
vim.keymap.set("n", "<a-k>", ":tabnext<cr>")
vim.keymap.set("n", "<a-j>", ":tabprevious<cr>")

vim.keymap.set({ "n", "v" }, "<a-up>", ":m .-2<cr>==")
vim.keymap.set({ "n", "v" }, "<a-down>", ":m .+1<cr>==")

vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<leader>x", ":x<cr>")
vim.keymap.set("n", "<leader>q", ":q<cr>")
vim.keymap.set("n", "<leader>Q", ":q!<cr>")

vim.keymap.set("n", "<c-a>", "^")
vim.keymap.set("n", "<c-e>", "$")
vim.keymap.set("i", "<c-a>", "<esc>^i")
vim.keymap.set("i", "<c-e>", "<esc>$a")

vim.keymap.set("n", "<leader>r", ":set relativenumber!<cr>")
vim.keymap.set("n", "<leader>W", ":set wrap!<cr>")

vim.keymap.set("n", "<leader>o", "o<esc>")
vim.keymap.set("n", "<leader>O", "O<esc>")

-- Stay in indent mode
vim.keymap.set("v", "<tab>", ">gv")
vim.keymap.set("v", "<s-tab>", "<gv")
vim.keymap.set("n", "<tab>", "v>")
vim.keymap.set("n", "<s-tab>", "v<")

vim.keymap.set("n", "vv", "viw")

-- Wrap selection in (), [], {}, "" etc.
vim.keymap.set("v", "'", "<esc>`<i'<esc>`>la'<esc>")
vim.keymap.set("v", '"', '<esc>`<i"<esc>`>la"<esc>')
vim.keymap.set("v", '`', '<esc>`<i`<esc>`>la`<esc>')
vim.keymap.set("v", '(', '<esc>`<i(<esc>`>la)<esc>')
vim.keymap.set("v", '{', '<esc>`<i{<esc>`>la}<esc>')
vim.keymap.set("v", '[', '<esc>`<i[<esc>`>la]<esc>')
vim.keymap.set("v", '<', '<esc>`<i<<esc>`>la><esc>')

vim.keymap.set("i", "<c-d>", "<esc>^C")

vim.keymap.set("o", "(", "i(")
vim.keymap.set("o", "{", "i{")
vim.keymap.set("o", "[", "i[")
vim.keymap.set("o", '"', 'i"')
vim.keymap.set("o", "'", "i'")

vim.keymap.set("o", "n(", ":<c-u>normal! f(vi(<cr>")
vim.keymap.set("o", "n{", ":<c-u>normal! f{vi{<cr>")
vim.keymap.set("o", "n[", ":<c-u>normal! f[vi[<cr>")
vim.keymap.set("o", 'n"', ':<c-u>normal! f"vi"<cr>')
vim.keymap.set("o", 'n"', ':<c-u>normal! f"vi"<cr>')

-- Duplicate line
vim.keymap.set("n", "<C-Down>", "yyp")
vim.keymap.set("n", "<C-Up>", "yyP")
vim.keymap.set("x", "<C-Down>", "yp")
vim.keymap.set("x", "<C-Up>", "yP")

-- Better window navigation
vim.keymap.set("n", "<C-S-Left>", "<C-w>h")
vim.keymap.set("n", "<C-S-Down>", "<C-w>j")
vim.keymap.set("n", "<C-S-Up>", "<C-w>k")
vim.keymap.set("n", "<C-S-Right>", "<C-w>l")

-- vim.keymap.set({"n", "v"}, "d", ""_d")
vim.keymap.set({"n", "v"}, "c", '"_c')

vim.keymap.set("i", "jj", "<Esc>")
