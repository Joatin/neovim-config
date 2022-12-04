local api = vim.api
local fn = vim.fn

local utils = require("utils")

-- The root dir to install all plugins. Plugins are under opt/ or start/ sub-directory.
vim.g.plugin_home = fn.stdpath("data") .. "/site/pack/packer"

--- Install packer if it has not been installed.
--- Return:
--- true: if this is a fresh install of packer
--- false: if packer has been installed
local function packer_ensure_install()
  -- Where to install packer.nvim -- the package manager (we make it opt)
  local packer_dir = vim.g.plugin_home .. "/opt/packer.nvim"

  if fn.glob(packer_dir) ~= "" then
    return false
  end

  -- Auto-install packer in case it hasn't been installed.
  vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})

  local packer_repo = "https://github.com/wbthomason/packer.nvim"
  local install_cmd = string.format("!git clone --depth=1 %s %s", packer_repo, packer_dir)
  vim.cmd(install_cmd)

  return true
end

local fresh_install = packer_ensure_install()

-- Load packer.nvim
vim.cmd("packadd packer.nvim")

local packer = require("packer")
local packer_util = require("packer.util")


packer.startup {
  function(use) 
  
    -- it is recommended to put impatient.nvim before any other plugins
    use { "lewis6991/impatient.nvim", config = [[require('impatient')]] }

    use { "wbthomason/packer.nvim", opt = true }

    use { "onsails/lspkind-nvim", event = "VimEnter" }

    -- auto-completion engine
    use { "hrsh7th/nvim-cmp", after = "lspkind-nvim", config = [[require('config.nvim-cmp')]] }

    -- nvim-cmp completion sources
    use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }
    use { "hrsh7th/cmp-path", after = "nvim-cmp" }
    use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
    use { "hrsh7th/cmp-omni", after = "nvim-cmp" }

    if vim.g.is_mac then
      use { "hrsh7th/cmp-emoji", after = "nvim-cmp" }
    end

    -- nvim-lsp configuration (it relies on cmp-nvim-lsp, so it should be loaded after cmp-nvim-lsp).
    use { "neovim/nvim-lspconfig", after = "cmp-nvim-lsp", config = [[require('config.lsp')]] }

    if vim.g.is_mac then
      use {
        "nvim-treesitter/nvim-treesitter",
        event = "BufEnter",
        run = ":TSUpdate",
        config = [[require('config.treesitter')]],
      }
    end

    if vim.g.is_mac then 
      use {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
          require("treesitter-context").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
          }
        end,
        after = 'nvim-treesitter'
      }
    end

    use {
      "folke/twilight.nvim",
      config = function()
        require("twilight").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }

    use { "windwp/nvim-ts-autotag", after = 'nvim-treesitter' }
    
    if vim.g.is_mac then
      use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter'
      }
    end

    use { 'folke/tokyonight.nvim', config = [[require('config.tokyonight')]] }
    use {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      requires = { { "nvim-lua/plenary.nvim" } },
    }

    -- search emoji and other symbols
    use { "nvim-telescope/telescope-symbols.nvim", after = "telescope.nvim" }
    use {
	    "vuki656/package-info.nvim",
    	requires = "MunifTanjim/nui.nvim",
      config = [[require('config.package-info')]]
	  }
	  use {
    	"jose-elias-alvarez/null-ls.nvim",
    	requires = { "nvim-lua/plenary.nvim" },
	  }
    
	  use { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }
	  use {
    	'L3MON4D3/LuaSnip',
    	after = 'nvim-cmp',
	  }
	  use { "lukas-reineke/indent-blankline.nvim", config = [[require('config.indent-blankline')]] }
	  use {
  		"folke/trouble.nvim",
  		requires = "kyazdani42/nvim-web-devicons",
  		config = function()
        require("trouble").setup {
      		-- your configuration comes here
      		-- or leave it empty to use the default settings
      	  -- refer to the configuration section below
    		}
  		end,
	  }
	  use 'RRethy/vim-illuminate'
	  use { 
      'norcalli/nvim-colorizer.lua',
      config = function()
        require("colorizer").setup()
      end
    }
    use 'sbdchd/neoformat'

    use { "kyazdani42/nvim-web-devicons", event = "VimEnter" }

    use {
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      config = [[require('config.statusline')]],
      after = 'lspkind-nvim'
    }

    -- fancy start screen
    use { "glepnir/dashboard-nvim", event = "VimEnter",
      config = [[require('config.dashboard-nvim')]]
    }

    -- Highlight URLs inside vim
    use { "itchyny/vim-highlighturl", event = "VimEnter" }

    -- notification plugin
    use {
      "rcarriga/nvim-notify",
      event = "BufEnter",
      config = function()
        vim.defer_fn(function()
          require("config.nvim-notify")
        end, 2000)
      end,
    }

    -- For Windows and Mac, we can open an URL in the browser. For Linux, it may
    -- not be possible since we maybe in a server which disables GUI.
    if vim.g.is_win or vim.g.is_mac then
      -- open URL in browser
      use { "tyru/open-browser.vim", event = "VimEnter" }
    end

    -- Autosave files on certain events
    use { "907th/vim-auto-save", event = "InsertEnter" }

    -- Show undo history visually
    use { "simnalamburt/vim-mundo", cmd = { "MundoToggle", "MundoShow" } }

    -- Manage your yank history
    if vim.g.is_win or vim.g.is_mac then
      use { "svermeulen/vim-yoink", event = "VimEnter" }
    end

    -- Git command inside vim
    use { "tpope/vim-fugitive", event = "User InGitRepo", config = [[require('config.fugitive')]] }

    -- Better git log display
    use { "rbong/vim-flog", requires = "tpope/vim-fugitive", cmd = { "Flog" } }

    use { "christoomey/vim-conflicted", requires = "tpope/vim-fugitive", cmd = { "Conflicted" } }

    use {
      "ruifm/gitlinker.nvim",
      requires = "nvim-lua/plenary.nvim",
      event = "User InGitRepo",
      config = [[require('config.git-linker')]],
    }

    -- Show git change (change, delete, add) signs in vim sign column
    use { "lewis6991/gitsigns.nvim", config = [[require('config.gitsigns')]] }

    -- Better git commit experience
    use { "rhysd/committia.vim", opt = true, setup = [[vim.cmd('packadd committia.vim')]] }

    use { "chrisbra/unicode.vim", event = "VimEnter" }

    -- showing keybindings
    use {
      "folke/which-key.nvim",
      event = "VimEnter",
      config = function()
        vim.defer_fn(function()
          require("config.which-key")
        end, 2000)
      end,
    }

     -- file explorer
    use {
      "kyazdani42/nvim-tree.lua",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = [[require('config.nvim-tree')]],
    }

    -- Asynchronous command execution
    use { "skywind3000/asyncrun.vim", opt = true, cmd = { "AsyncRun" } }
    

    use { "ii14/emmylua-nvim", ft = "lua" }

    use { "j-hui/fidget.nvim", after = "nvim-lspconfig", config = function()
        require('fidget').setup()
      end
    }
  end,
  config = {
    max_jobs = 16,
    compile_path = packer_util.join_paths(fn.stdpath("data"), "site", "lua", "packer_compiled.lua"),
  },
}



-- For fresh install, we need to install plugins. Otherwise, we just need to require `packer_compiled.lua`.
if fresh_install then
  -- We run packer.sync() here, because only after packer.startup, can we know which plugins to install.
  -- So plugin installation should be done after the startup process.
  packer.sync()
else
  local status, _ = pcall(require, "packer_compiled")
  if not status then
    local msg = "File packer_compiled.lua not found: run PackerSync to fix!"
    vim.notify(msg, vim.log.levels.ERROR, { title = "nvim-config" })
  end
end

-- Auto-generate packer_compiled.lua file
api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "*/nvim/lua/plugins.lua",
  group = api.nvim_create_augroup("packer_auto_compile", { clear = true }),
  callback = function(ctx)
    local cmd = "source " .. ctx.file
    vim.cmd(cmd)
    vim.cmd("PackerCompile")
    vim.notify("PackerCompile done!", vim.log.levels.INFO, { title = "Nvim-config" })
  end,
})
