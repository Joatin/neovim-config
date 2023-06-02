local keymap = vim.keymap
local api = vim.api
local uv = vim.loop

keymap.set({ "n", "x" }, ";", ":")

-- Switch buffer
keymap.set("n", "<TAB>", "<cmd>:bn<cr>", { silent = true, desc = "Next buffer" })
keymap.set("n", "<S-TAB>", "<cmd>:bp<cr>", { silent = true, desc = "Previous buffer" })

keymap.set("n", "<leader>o", "<cmd>:%bd|e#|bd#|Neotree reveal<cr>", { silent = true, desc = "Previous buffer" })

-- Shortcut for faster save and quit
keymap.set("n", "<leader>w", "<cmd>update<cr>", { silent = true, desc = "save buffer" })

-- Saves the file if modified and quit
keymap.set("n", "<leader>q", "<cmd>x<cr>", { silent = true, desc = "quit current window" })

-- Exit insert mode
keymap.set("i", 'jj', '<ESC>', { silent = true, desc = "Exit insert mode" })

-- Quit all opened buffers
keymap.set("n", "<leader>Q", "<cmd>qa!<cr>", { silent = true, desc = "quit nvim" })

-- Go to start or end of line easier
keymap.set({ "n", "x" }, "H", "^")
keymap.set({ "n", "x" }, "L", "g_")

-- Edit and reload nvim config file quickly
keymap.set("n", "<leader>ev", "<cmd>tabnew $MYVIMRC <bar> tcd %:h<cr>", {
  silent = true,
  desc = "open init.lua",
})

keymap.set("n", "<leader>sv", function()
  vim.cmd([[
      update $MYVIMRC
      source $MYVIMRC
    ]])
  vim.notify("Nvim config successfully reloaded!", vim.log.levels.INFO, { title = "nvim-config" })
end, {
  silent = true,
  desc = "reload init.lua",
})

-- Always use very magic mode for searching
keymap.set("n", "/", [[/\v]])

-- Use Esc to quit builtin terminal
keymap.set("t", "<Esc>", [[<c-\><c-n>]])

-- Copy entire buffer.
keymap.set("n", "<leader>y", "<cmd>%yank<cr>", { desc = "yank entire buffer" })

-- Move current line up and down
keymap.set("n", "<A-k>", '<cmd>call utils#SwitchLine(line("."), "up")<cr>', { desc = "move line up" })
keymap.set("n", "<A-j>", '<cmd>call utils#SwitchLine(line("."), "down")<cr>', { desc = "move line down" })

-- Switch windows
keymap.set("n", "<left>", "<c-w>h")
keymap.set("n", "<Right>", "<C-W>l")
keymap.set("n", "<Up>", "<C-W>k")
keymap.set("n", "<Down>", "<C-W>j")

-- Go to the beginning and end of current line in insert mode quickly
keymap.set("i", "<C-A>", "<HOME>")
keymap.set("i", "<C-E>", "<END>")

-- Go to beginning of command in command-line mode
keymap.set("c", "<C-A>", "<HOME>")

-- Telescope
keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "find files in workspace", silent = true })
keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "search in workspace files", silent = true })
keymap.set("n", "<leader>fr", ":Telescope frecency workspace=CWD<CR>", { desc = "find recent files", silent = true })
keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "list all active buffers", silent = true })

