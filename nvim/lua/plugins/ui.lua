return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    opts = {},
  },
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#1a1b26",
      timeout = 5000,
    },
  },

  -- animations
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },

  -- buffer line
  {
    "b0o/incline.nvim",
    event = "BufReadPre", -- Load this plugin before reading a buffer
    priority = 1200, -- Set the priority for loading this plugin
    config = function()
      require("incline").setup({
        window = { margin = { vertical = 0, horizontal = 1 } }, -- Set the window margin
        hide = {
          cursorline = true, -- Hide the incline window when the cursorline is active
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t") -- Get the filename
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename -- Indicate if the file is modified
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename) -- Get the icon and color for the file
          return { { icon, guifg = color }, { " " }, { filename } } -- Return the rendered content
        end,
      })
    end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        -- globalstatus = false,
        theme = "solarized-osaka",
      },
    },
  },

  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  -- Logo
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        matcher = {
          fuzzy = true,
          smartcase = true,
          ignorecase = true,
          filename_bonus = true,
        },
        sources = {
          explorer = {
            matcher = {
              fuzzy = true,
              smartcase = true,
              ignorecase = true,
              filename_bonus = true,
              sort_empty = false,
            },
          },
        },
      },

      keys = {
        -- Top Pickers & Explorer
        {
          "<leader><space>",
          function()
            Snacks.picker.smart()
          end,
          desc = "Smart Find Files",
        },
        {
          "<leader>,",
          function()
            Snacks.picker.buffers()
          end,
          desc = "Buffers",
        },
        {
          "<leader>/",
          function()
            Snacks.picker.grep()
          end,
          desc = "Grep",
        },
        {
          "<leader>:",
          function()
            Snacks.picker.command_history()
          end,
          desc = "Command History",
        },
        {
          "<leader>n",
          function()
            Snacks.picker.notifications()
          end,
          desc = "Notification History",
        },
        {
          "<leader>e",
          function()
            Snacks.explorer()
          end,
          desc = "File Explorer",
        },
        -- find
        {
          "<leader>fb",
          function()
            Snacks.picker.buffers()
          end,
          desc = "Buffers",
        },
        {
          "<leader>fc",
          function()
            Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
          end,
          desc = "Find Config File",
        },
        {
          "<leader>ff",
          function()
            Snacks.picker.files()
          end,
          desc = "Find Files",
        },
        {
          "<leader>fg",
          function()
            Snacks.picker.git_files()
          end,
          desc = "Find Git Files",
        },
        {
          "<leader>fp",
          function()
            Snacks.picker.projects()
          end,
          desc = "Projects",
        },
        {
          "<leader>fr",
          function()
            Snacks.picker.recent()
          end,
          desc = "Recent",
        },
        -- git
        {
          "<leader>gb",
          function()
            Snacks.picker.git_branches()
          end,
          desc = "Git Branches",
        },
        {
          "<leader>gl",
          function()
            Snacks.picker.git_log()
          end,
          desc = "Git Log",
        },
        {
          "<leader>gL",
          function()
            Snacks.picker.git_log_line()
          end,
          desc = "Git Log Line",
        },
        {
          "<leader>gs",
          function()
            Snacks.picker.git_status()
          end,
          desc = "Git Status",
        },
        {
          "<leader>gS",
          function()
            Snacks.picker.git_stash()
          end,
          desc = "Git Stash",
        },
        {
          "<leader>gd",
          function()
            Snacks.picker.git_diff()
          end,
          desc = "Git Diff (Hunks)",
        },
        {
          "<leader>gf",
          function()
            Snacks.picker.git_log_file()
          end,
          desc = "Git Log File",
        },
        -- Grep
        {
          "<leader>sb",
          function()
            Snacks.picker.lines()
          end,
          desc = "Buffer Lines",
        },
        {
          "<leader>sB",
          function()
            Snacks.picker.grep_buffers()
          end,
          desc = "Grep Open Buffers",
        },
        {
          "<leader>sg",
          function()
            Snacks.picker.grep()
          end,
          desc = "Grep",
        },
        {
          "<leader>sw",
          function()
            Snacks.picker.grep_word()
          end,
          desc = "Visual selection or word",
          mode = { "n", "x" },
        },
        -- search
        {
          '<leader>s"',
          function()
            Snacks.picker.registers()
          end,
          desc = "Registers",
        },
        {
          "<leader>s/",
          function()
            Snacks.picker.search_history()
          end,
          desc = "Search History",
        },
        {
          "<leader>sa",
          function()
            Snacks.picker.autocmds()
          end,
          desc = "Autocmds",
        },
        {
          "<leader>sb",
          function()
            Snacks.picker.lines()
          end,
          desc = "Buffer Lines",
        },
        {
          "<leader>sc",
          function()
            Snacks.picker.command_history()
          end,
          desc = "Command History",
        },
        {
          "<leader>sC",
          function()
            Snacks.picker.commands()
          end,
          desc = "Commands",
        },
        {
          "<leader>sd",
          function()
            Snacks.picker.diagnostics()
          end,
          desc = "Diagnostics",
        },
        {
          "<leader>sD",
          function()
            Snacks.picker.diagnostics_buffer()
          end,
          desc = "Buffer Diagnostics",
        },
        {
          "<leader>sh",
          function()
            Snacks.picker.help()
          end,
          desc = "Help Pages",
        },
        {
          "<leader>sH",
          function()
            Snacks.picker.highlights()
          end,
          desc = "Highlights",
        },
        {
          "<leader>si",
          function()
            Snacks.picker.icons()
          end,
          desc = "Icons",
        },
        {
          "<leader>sj",
          function()
            Snacks.picker.jumps()
          end,
          desc = "Jumps",
        },
        {
          "<leader>sk",
          function()
            Snacks.picker.keymaps()
          end,
          desc = "Keymaps",
        },
        {
          "<leader>sl",
          function()
            Snacks.picker.loclist()
          end,
          desc = "Location List",
        },
        {
          "<leader>sm",
          function()
            Snacks.picker.marks()
          end,
          desc = "Marks",
        },
        {
          "<leader>sM",
          function()
            Snacks.picker.man()
          end,
          desc = "Man Pages",
        },
        {
          "<leader>sp",
          function()
            Snacks.picker.lazy()
          end,
          desc = "Search for Plugin Spec",
        },
        {
          "<leader>sq",
          function()
            Snacks.picker.qflist()
          end,
          desc = "Quickfix List",
        },
        {
          "<leader>sR",
          function()
            Snacks.picker.resume()
          end,
          desc = "Resume",
        },
        {
          "<leader>su",
          function()
            Snacks.picker.undo()
          end,
          desc = "Undo History",
        },
        {
          "<leader>uC",
          function()
            Snacks.picker.colorschemes()
          end,
          desc = "Colorschemes",
        },
        -- LSP
        {
          "gd",
          function()
            Snacks.picker.lsp_definitions()
          end,
          desc = "Goto Definition",
        },
        {
          "gD",
          function()
            Snacks.picker.lsp_declarations()
          end,
          desc = "Goto Declaration",
        },
        {
          "gr",
          function()
            Snacks.picker.lsp_references()
          end,
          nowait = true,
          desc = "References",
        },
        {
          "gI",
          function()
            Snacks.picker.lsp_implementations()
          end,
          desc = "Goto Implementation",
        },
        {
          "gy",
          function()
            Snacks.picker.lsp_type_definitions()
          end,
          desc = "Goto T[y]pe Definition",
        },
        {
          "<leader>ss",
          function()
            Snacks.picker.lsp_symbols()
          end,
          desc = "LSP Symbols",
        },
        {
          "<leader>sS",
          function()
            Snacks.picker.lsp_workspace_symbols()
          end,
          desc = "LSP Workspace Symbols",
        },
      },
      dashboard = {
        sections = {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
        preset = {
          header = [[

 ██████╗ █████╗      ██╗██╗   ██╗██╗  ██╗ █████╗ 
██╔════╝██╔══██╗     ██║██║   ██║██║ ██╔╝██╔══██╗
██║     ███████║     ██║██║   ██║█████╔╝ ███████║
██║     ██╔══██║██   ██║██║   ██║██╔═██╗ ██╔══██║
╚██████╗██║  ██║╚█████╔╝╚██████╔╝██║  ██╗██║  ██║
 ╚═════╝╚═╝  ╚═╝ ╚════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        },
      },
    },
  },
  --   {
  --     "nvimdev/dashboard-nvim",
  --     event = "VimEnter",
  --     opts = function(_, opts)
  --       local logo = [[
  --  ██████╗ █████╗      ██╗██╗   ██╗██╗  ██╗ █████╗
  -- ██╔════╝██╔══██╗     ██║██║   ██║██║ ██╔╝██╔══██╗
  -- ██║     ███████║     ██║██║   ██║█████╔╝ ███████║
  -- ██║     ██╔══██║██   ██║██║   ██║██╔═██╗ ██╔══██║
  -- ╚██████╗██║  ██║╚█████╔╝╚██████╔╝██║  ██╗██║  ██║
  --  ╚═════╝╚═╝  ╚═╝ ╚════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝
  --       ]]
  --       logo = string.rep("\n", 8) .. logo .. "\n\n"
  --       opts.config.header = vim.split(logo, "\n")
  --     end,
  --   },
}
