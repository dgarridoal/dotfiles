return {
  -- {
  --   -- aura-dark
  --   "baliestri/aura-theme",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     transparent_background = true,
  --   },
  -- },
  {
    -- cyberdream
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = function(_, opts)
      opts.transparent = true
      opts.italic_comments = true
      opts.borderless_pickers = false
    end,
  },
  {
    "mawkler/modicator.nvim",
    dependencies = "scottmckendry/cyberdream.nvim",
    init = function()
      -- These are required for Modicator to work
      vim.o.cursorline = false
      vim.o.number = true
      vim.o.termguicolors = true
    end,
    opts = {},
  },
  -- {
  --   -- onedark
  --   "navarasu/onedark.nvim",
  --   priority = 1000,
  -- },
  {
    "sainnhe/sonokai",
    priority = 1000,
    config = function()
      vim.g.sonokai_transparent_background = "1"
      vim.g.sonokai_enable_italic = "1"
      vim.g.sonokai_style = "andromeda"
    end,
  },
  -- {
  --   -- min-theme
  --   "datsfilipe/min-theme.nvim",
  --   lazy = true,
  --   priority = 1000,
  --   theme = "dark", -- String: 'dark' or 'light', determines the colorscheme used
  --   transparent = true, -- Boolean: Sets the background to transparent
  --   italics = {
  --     comments = true, -- Boolean: Italicizes comments
  --     keywords = true, -- Boolean: Italicizes keywords
  --     functions = true, -- Boolean: Italicizes functions
  --     strings = true, -- Boolean: Italicizes strings
  --     variables = true, -- Boolean: Italicizes variables
  --   },
  -- },
  --

  {
    -- solarized-osaka
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      transparent_background = true,
    },
    --   integrations = {
    --     cmp = true,
    --     gitsigns = true,
    --     nvimtree = true,
    --     treesitter = true,
    --     notify = true,
    --     mini = {
    --       enabled = true,
    --       indentscope_color = "",
    --     },
    --   },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized-osaka",
    },
  },
}
