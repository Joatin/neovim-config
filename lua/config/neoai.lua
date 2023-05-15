require('neoai').setup()
local keymap = vim.keymap

keymap.set("n", "<leader>aa", '<Cmd>NeoAIToggle<CR>', { silent = true, desc = "open ChatGPT panel" })
keymap.set("n", "<leader>ac", '<Cmd>NeoAIContext<CR>', { silent = true, desc = "open ChatGPT panel" })

