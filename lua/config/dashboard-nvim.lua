local api = vim.api
local keymap = vim.keymap
local dashboard = require("dashboard")

local custom_header = {
  "                                                       ",
  "                                                       ",
  "                                                       ",
  " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
  " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
  " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
  " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
  " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
  " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
  "                                                       ",
  "                                                       ",
  "                                                       ",
  "                                                       ",
}

dashboard.setup {
  theme = "doom",
  config = {
    header = custom_header,
    center = {
      {
        icon = "  ",
        desc = "Find  File",
        action = "Telescope find_files",
        key = "<Leader> f f",
      },
      {
        icon = "  ",
        desc = "Recently opened files",
        action = "Telescope oldfiles",
        key = "<Leader> f r",
      },
      {
        icon = "  ",
        desc = "Project grep",
        action = "Telescope live_grep",
        key = "<Leader> f g",
      },
      {
        icon = "  ",
        desc = "Open Nvim config",
        action = "tabnew $MYVIMRC | tcd %:p:h",
        key = "<Leader> e v",
      },
      {
        icon = "  ",
        desc = "New file",
        action = "new",
        key = "e",
      },
      {
        icon = "  ",
        desc = "Quit Nvim",
        action = "qa",
        key = "q",
      },
    },
  },
}

api.nvim_create_autocmd("FileType", {
  pattern = "dashboard",
  group = api.nvim_create_augroup("dashboard_enter", { clear = true }),
  callback = function()
    keymap.set("n", "q", ":qa<CR>", { buffer = true, silent = true })
    keymap.set("n", "e", ":new<CR>", { buffer = true, silent = true })
  end,
})
