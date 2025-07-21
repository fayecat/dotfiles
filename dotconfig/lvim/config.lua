local keymap = lvim.builtin.which_key.mappings
local vkeymap = lvim.builtin.which_key.vmappings

-- General settings
lvim.log.level = "warn"
lvim.format_on_save = true
-- lvim.plugins = {
-- 	"Mofiqul/dracula.nvim",
-- }
-- lvim.colorscheme = "dracula-soft"

-- lvim.plugins = {
-- 	"projekt0n/github-nvim-theme",
-- }
-- lvim.colorscheme = "github-nvim-theme"

-- lvim.colorscheme = 'monokai-pro'

vim.wo.wrap = true
lvim.builtin.bufferline.active = false
lvim.builtin.telescope.defaults.find_files= {
	find_command = { "fd", "-t=f", "--hidden", "--exclude", "node_modules" },
	path_display = { "truncate" },
  hidden = true,
  no_ignore = false,
}
-- show hidden files when running a find command in telescope
lvim.builtin.telescope.defaults.file_ignore_patterns = { "node_modules", ".git/", "dist", "build" }
-- lvim.builtin.telescope.pickers.find_files.find_command = { "fd", "--type", "f", "--hidden", "--exclude", "node_modules" }

lvim.builtin.telescope.defaults.dynamic_preview_title = true
lvim.builtin.telescope.defaults.path_display = { absolute = true }
lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
lvim.builtin.telescope.defaults.layout_config = {
  horizontal = {
    prompt_position = "bottom",
    preview_width = 0.5,
    results_width = 0.5,
  },
  width = 0.9,
  height = 0.8,
  preview_cutoff = 120,
}

lvim.builtin.telescope.defaults.borderchars = {
  prompt = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
  results = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
  preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
}

vim.cmd [[ set showtabline=0 ]]

-- Key mappings
lvim.leader = "space"
-- Add your custom key mappings here

-- Plugin configuration
lvim.plugins = {
  {
    "nvim-telescope/telescope.nvim",
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  {
    "kyazdani42/nvim-tree.lua", 
    -- config = function()
    --   require('nvim-tree').setup({ actions = { open_file = { window_picker = { enable = false } } } })
    -- end
  },
  {"akinsho/bufferline.nvim"},
  {"hrsh7th/nvim-cmp"},
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      opts.ignore_install = { 'help'}
  
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, {
          'dockerfile',
          'git_config',
          'jsdoc',
          'make',
          'toml',
          'vimdoc',
        })
      end
    end,
  },
  -- {"L3MON4D3/LuaSnip"},
  {"numToStr/Comment.nvim"},
  {"lewis6991/gitsigns.nvim"},
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme duskfox")
    end
  },
  {"folke/which-key.nvim"},
  -- {"Mofiqul/dracula.nvim"},
  -- {
  --   'projekt0n/github-nvim-theme',
  --   name = 'github-theme',
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require('github-theme').setup({})
  
  --     vim.cmd('colorscheme github_dark')
  --   end,
  -- },
  {
    "loctvl842/monokai-pro.nvim",
  },
  { "catppuccin/nvim", name = "catppuccin-macchiato", priority = 1000 },
  {"windwp/nvim-autopairs"},
  {"tpope/vim-rsi"},
  {"lukas-reineke/indent-blankline.nvim"},
  {"tanvirtin/monokai.nvim"},
  -- {
  --   "olimorris/onedarkpro.nvim",
  -- },
  { "navarasu/onedark.nvim" },
  -- {"ribru17/bamboo.nvim"},
  {"nathom/filetype.nvim"},
  {"nvim-lua/plenary.nvim"},
  {"nvim-pack/nvim-spectre"},
  {"yamatsum/nvim-cursorline"},
  {"rebelot/kanagawa.nvim"},
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xa",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>xs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {"dmmulroy/tsc.nvim"},
  {"romainl/vim-cool"},
  {
    "gennaro-tedesco/nvim-jqx",
    event = {"BufReadPost"},
    ft = { "json", "yaml" },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require('lspconfig')

      lspconfig.rust_analyzer.setup {}
      lspconfig.tsserver.setup {}
      lspconfig.clangd.setup({
        filetypes = { "c", "cpp" }
      })

      lspconfig.sourcekit.setup({
        -- cmd = { "sourcekit-lsp" },
        cmd = {
          "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp"
        },
        filetypes = { "swift", "c", "cpp", "objective-c", "objective-cpp" },
        root_dir = require('lspconfig.util').root_pattern("Package.swift", ".git"),
        -- filetypes = { "swift", "objective-c", "objective-cpp" },
        -- root_dir = require('lspconfig.util').root_pattern('Package.swift', '.git'),
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP Actions',
        callback = function(args)
          -- Once we've attached, configure the keybindings
          local wk = require('which-key')
          wk.register({
            K = { vim.lsp.buf.hover, "LSP hover info"},
            gd = { vim.lsp.buf.definition, "LSP go to definition"},
            gD = { vim.lsp.buf.declaration, "LSP go to declaration"},
            gi = { vim.lsp.buf.implementation, "LSP go to implementation"},
            gr = { vim.lsp.buf.references, "LSP list references"},
            gs = { vim.lsp.buf.signature_help, "LSP signature help"},
            gn = { vim.lsp.buf.rename, "LSP rename"},
            ["[g"] = { vim.diagnostic.goto_prev, "Go to previous diagnostic"},
            ["g]"] = { vim.diagnostic.goto_next, "Go to next diagnostic"},
          }, {
            mode = 'n',
            silent = true,
          })
        end,
      })

      -- vim.api.nvim_create_autocmd("BufWritePost", {
      --   pattern = "Package.swift",
      --   callback = function()
      --     vim.fn.jobstart({ "swift", "build" }, {
      --       stdout_buffered = true,
      --       stderr_buffered = true,
      --       on_stdout = function(_, data)
      --         if data then
      --           print("[swift build] " .. table.concat(data, "\n"))
      --         end
      --       end,
      --       on_stderr = function(_, data)
      --         if data then
      --           print("[swift build error] " .. table.concat(data, "\n"))
      --         end
      --       end,
      --     })
      --   end,
      -- })

    end
  },
  {'kevinhwang91/nvim-hlslens'},
  -- {
  --   "romgrk/nvim-treesitter-context",
  --   lazy = true,
  --   event = { "User FileOpened" },
  --   config = function()
  --       require("treesitter-context").setup({
  --           enable = true,
  --           throttle = true,
  --           max_lines = 0, 
  --           patterns = {
  --               default = {
  --                   "class",
  --                   "function",
  --                   "method",
  --               },
  --           },
  --       })
  --   end,
  -- },
  -- {
  --   "JoosepAlviste/nvim-ts-context-commentstring",
  --   lazy = true,
  --   event = { "User FileOpened" },
  -- },
  {
    "rmagatti/goto-preview",
    lazy = true,
    keys = { "gp" },
    config = function()
        require("goto-preview").setup({
            width = 100,
            height = 20,
            default_mappings = true,
            debug = false,
            opacity = nil,
            post_open_hook = nil, 
            references = { -- Configure the telescope UI for slowing the references cycling window.
              telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
            },
            -- You can use "default_mappings = true" setup option
            -- Or explicitly set keybindings
            -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
            -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
            -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
        })
    end,
  },
  {
    "ethanholz/nvim-lastplace",
    lazy = true,
    event = { "User FileOpened" },
    config = function()
        require("nvim-lastplace").setup({
            lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
            lastplace_ignore_filetype = {
                "gitcommit",
                "gitrebase",
                "svn",
                "hgcommit",
            },
            lastplace_open_folds = true,
        })
    end,
  },
  {
    "andymass/vim-matchup",
    -- Highlight, jump between pairs like if..else
    lazy = true,
    event = { "User FileOpened" },
    config = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
        lvim.builtin.treesitter.matchup.enable = true
    end,
 },
 {'airblade/vim-gitgutter'},
 {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    config = function()
      require("lsp_signature").setup({
        bind = true,
        floating_window = true,
        hint_enable = true,
        handler_opts = {
          border = "rounded"
        },
      })
    end,
 },
 {
    "zbirenbaum/neodim",
    lazy = true,
    event = "LspAttach",
    config = function()
        require("neodim").setup({
            alpha = 0.75,
            blend_color = "#000000",
            update_in_insert = {
                enable = true,
                delay = 100,
            },
            hide = {
                virtual_text = true,
                signs = false,
                underline = false,
            },
        })
    end,
  },
  -- {"wojciech-kulik/ios-dev-starter-nvim"},
  -- {
  --   "wojciech-kulik/xcodebuild.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --     "MunifTanjim/nui.nvim",
  --     "nvim-tree/nvim-tree.lua", -- (optional) to manage project files
  --     "stevearc/oil.nvim", -- (optional) to manage project files
  --     "nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
  --   },
  --   config = function()
  --     require("xcodebuild").setup({
  --       auto_select_project = true,
  --       auto_select_scheme = true,
  --       auto_select_destination = true,
  --       show_build_output = true,
  --       show_test_output = true,
  --       mappings_enabled = false
  --     })
  --   end,
  -- },
  {
    "j-hui/fidget.nvim",
  },
  -- {
  --   "rcarriga/nvim-notify",
  --   lazy = true,
  --   event = "VeryLazy",
  --   config = function()
  --       local notify = require("notify")
  --       notify.setup({
  --           -- "fade", "slide", "fade_in_slide_out", "static"
  --           stages = "slide",
  --           on_open = nil,
  --           on_close = nil,
  --           timeout = 3000,
  --           fps = 1,
  --           render = "default",
  --           background_colour = "Normal",
  --           max_width = math.floor(vim.api.nvim_win_get_width(0) / 2),
  --           max_height = math.floor(vim.api.nvim_win_get_height(0) / 4),
  --           -- minimum_width = 50,
  --           -- ERROR > WARN > INFO > DEBUG > TRACE
  --           level = "TRACE",
  --       })

  --       vim.notify = notify
  --   end,
  -- },
  {
    "simrat39/symbols-outline.nvim",
        lazy = true,
        cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
        config = function()
            local opts = {
                highlight_hovered_item = true,
                show_guides = true,
                auto_preview = false,
                position = "right",
                relative_width = true,
                width = 25,
                auto_close = false,
                show_numbers = false,
                show_relative_numbers = false,
                show_symbol_details = true,
                preview_bg_highlight = "Pmenu",
                autofold_depth = nil,
                auto_unfold_hover = true,
                fold_markers = { "", "" },
                wrap = false,
                keymaps = { -- These keymaps can be a string or a table for multiple keys
                    close = { "<Esc>", "q" },
                    goto_location = "<Cr>",
                    focus_location = "o",
                    hover_symbol = "<C-space>",
                    toggle_preview = "K",
                    rename_symbol = "r",
                    code_actions = "a",
                    fold = "h",
                    unfold = "l",
                    fold_all = "P",
                    unfold_all = "U",
                    fold_reset = "Q",
                },
                lsp_blacklist = {},
                symbol_blacklist = {},
                symbols = {
                    File = { icon = "", hl = "@text.uri" },
                    Module = { icon = "", hl = "@namespace" },
                    Namespace = { icon = "", hl = "@namespace" },
                    Package = { icon = "", hl = "@namespace" },
                    Class = { icon = "𝓒", hl = "@type" },
                    Method = { icon = "ƒ", hl = "@method" },
                    Property = { icon = "", hl = "@method" },
                    Field = { icon = "", hl = "@field" },
                    Constructor = { icon = "", hl = "@constructor" },
                    Enum = { icon = "", hl = "@type" },
                    Interface = { icon = "ﰮ", hl = "@type" },
                    Function = { icon = "", hl = "@function" },
                    Variable = { icon = "", hl = "@constant" },
                    Constant = { icon = "", hl = "@constant" },
                    String = { icon = "𝓐", hl = "@string" },
                    Number = { icon = "#", hl = "@number" },
                    Boolean = { icon = "", hl = "@boolean" },
                    Array = { icon = "", hl = "@constant" },
                    Object = { icon = "", hl = "@type" },
                    Key = { icon = "🔐", hl = "@type" },
                    Null = { icon = "NULL", hl = "@type" },
                    EnumMember = { icon = "", hl = "@field" },
                    Struct = { icon = "𝓢", hl = "@type" },
                    Event = { icon = "🗲", hl = "@type" },
                    Operator = { icon = "+", hl = "@operator" },
                    TypeParameter = { icon = "𝙏", hl = "@parameter" },
                    Component = { icon = "󰡀", hl = "@function" },
                    Fragment = { icon = "", hl = "@constant" },
                },
            }
            require("symbols-outline").setup(opts)
        end,
  },
  -- {
  --   "nvim-zh/colorful-winsep.nvim",
  --   lazy = true,
  --   event = "WinNew",
  --   config = function()
  --       require("colorful-winsep").setup()
  --   end,
  -- },
  {
    "karb94/neoscroll.nvim",
    lazy = true,
    -- event = "WinScrolled",
    keys = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
    config = function()
        require("neoscroll").setup({
            -- All these keys will be mapped to their corresponding default scrolling animation
            -- mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
            hide_cursor = true,
            stop_eof = true,
            use_local_scrolloff = false,
            respect_scrolloff = false,
            cursor_scrolls_alone = true,
            -- quadratic, cubic, quartic, quintic, circular, sine
            easing_function = "cubic",
            pre_hook = nil,
            post_hook = nil,
        })

        local t = {}
        t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "50", [['cubic']] } }
        t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "50", [['cubic']] } }
        t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "50", [['cubic']] } }
        t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "50", [['cubic']] } }
        t["<C-y>"] = { "scroll", { "-0.10", "false", "50", [['cubic']] } }
        t["<C-e>"] = { "scroll", { "0.10", "false", "50", [['cubic']] } }
        t["zt"] = { "zt", { "100", [['cubic']] } }
        t["zz"] = { "zz", { "100", [['cubic']] } }
        t["zb"] = { "zb", { "100", [['cubic']] } }

        require("neoscroll.config").set_mappings(t)
    end,
  },
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        "neovim/nvim-lspconfig",
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = true,
  },
  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   opts = {},
  -- },
  {
    "cuducos/yaml.nvim",
    ft = { "yaml" }, -- optional
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
    },
  },
  {'iamcco/markdown-preview.nvim'},
  { "ellisonleao/dotenv.nvim" },
  {"NvChad/nvim-colorizer.lua"},
  -- {
  --   "mikavilpas/yazi.nvim",
  --   cmd = { "Yazi" },
  --   keys = {
  --     { "<leader>sy", "<cmd>Yazi<cr>", desc = "Open Yazi" }
  --   },
  --   opts = {}
  -- },
  {
    "SmiteshP/nvim-navic",
    dependencies = {
      "neovim/nvim-lspconfig"
    }
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },
  { "mhinz/vim-startify" },
  -- {
  --   "kdheepak/lazygit.nvim",
  --   lazy = true,
  --   cmd = {
  --       "LazyGit",
  --       "LazyGitConfig",
  --       "LazyGitCurrentFile",
  --       "LazyGitFilter",
  --       "LazyGitFilterCurrentFile",
  --   },
  --   -- optional for floating window border decoration
  --   dependencies = {
  --       "nvim-lua/plenary.nvim",
  --   },
  --   -- setting the keybinding for LazyGit with 'keys' is recommended in
  --   -- order to load the plugin when the command is run for the first time
  --   keys = {
  --       { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
  --   }
  --   config = function()
  --     require("lazygit").setup({
  --       editCommand = function(filename, line_number)
  --         line_number = tonumber(line_number) or 1
  --         vim.api.nvim_win_close(0, true)
  --         vim.api.nvim_command('edit +' .. line_number .. " " .. filename)
  --       end,
  --       openCommand = function(filename, line_number)
  --         line_number = tonumber(line_number) or 1
  --         vim.api.nvim_win_close(0, true)
  --         vim.api.nvim_command('edit +' .. line_number .. " " .. filename)
  --       end,
  --     })
  --   end
  -- },
  {
    "yorickpeterse/nvim-window",
    config = true,
  },
  { "autoim.vim" },
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter',
    config = function ()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-s>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
      vim.keymap.set('i', '<C-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
      vim.keymap.set('i', '<C-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
      vim.keymap.set('i', '<C-l>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
    end
  },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({
  --       suggestion = {
  --         auto_trigger = true, -- 自动触发建议
  --         keymap = {
  --           accept = "<C-s>", -- 接受建议
  --           next = "<C-,>",   -- 下一个建议
  --           prev = "<C-.>",   -- 上一个建议
  --           dismiss = "<C-l>", -- 清除建议
  --         },
  --       },
  --       panel = {
  --         enabled = true, -- 启用面板功能
  --         keymap = {
  --           open = "<C-;>", -- 打开面板
  --           accept = "<C-s>", -- 接受面板中的建议
  --           refresh = "gr", -- 刷新面板
  --           jump_prev = "[[", -- 跳转到上一个建议
  --           jump_next = "]]", -- 跳转到下一个建议
  --         },
  --       },
  --     })
  --   end,
  -- },
  -- { "github/copilot.vim" },
  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   dependencies = {
  --     { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
  --     { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
  --   },
  --   build = "make tiktoken", -- Only on MacOS or Linux
  --   opts = {
  --     model = 'gpt-4o',
  --     agent = 'copilot',
  --     prompts = {
  --       Default = "请回答以下问题：", -- 设置默认提示为中文
  --       Explain = "请解释以下代码：",
  --       Fix = "请修复并优化以下代码：",
  --       Optimize = "请优化以下代码：",
  --       Docs = "请为以下代码生成文档：",
  --       Tests = "请为以下代码生成测试：",
  --       Review = "请在代码的功能性、性能、可读性、安全性，或者是否存在潜在的错误或改进空间等方面审查以下代码：",
  --     },
  --     mappings = {
  --       complete = {
  --         insert = '<C-s>',
  --       },
  --       show_diff = {
  --         full_diff = true
  --       }
  --     },
  --     separator = '',
  --     clear_chat_on_new_prompt = true,
  --     chat_autocomplete = false,
  --     auto_insert_mode = true,
  --     window = {
  --       layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace'
  --       width = 0.3, -- fractional width of parent, or absolute width in columns when > 1
  --       height = 1, -- fractional height of parent, or absolute height in rows when > 1
  --       -- Options below only apply to floating windows
  --       relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
  --       border = 'none', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
  --       row = nil, -- row position of the window, default is centered
  --       col = nil, -- column position of the window, default is centered
  --       title = '', -- title of chat window
  --       footer = nil, -- footer of chat window
  --       zindex = 1, -- determines if window is on top or below other floating windows
  --     },
  --   }
  -- },
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   tag = "v0.0.23",
  --   version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  --   opts = {
  --     tokenizer = "tiktoken",
  --     provider = "copilot",
  --     -- behaviour = {
  --     --   jump_result_buffer_on_finish = false,
  --     -- },
  --     web_search_engine = {
  --       provider = "google",
  --     },
  --     -- vendors = {
  --     --   ["copilot1"] = {
  --     --     __inherited_from = "copilot",
  --     --     model = "claude-3.5-sonnet",
  --     --   },
  --     --   ["copilot2"] = {
  --     --     __inherited_from = "copilot",
  --     --     model = "claude-3.7-sonnet",
  --     --   },
  --     --   ["copilot3"] = {
  --     --     __inherited_from = "copilot",
  --     --     model = "o3-mini",
  --     --   },
  --     -- },  
  --     mappings = {
  --       --- @class AvanteConflictMappings
  --       sidebar = {
  --         apply_all = "A",
  --         apply_cursor = "a",
  --         retry_user_request = "r",
  --         edit_user_request = "e",
  --         switch_windows = "<Tab>",
  --         reverse_switch_windows = "<S-Tab>",
  --         remove_file = "d",
  --         add_file = "@",
  --         close = { "q" },
  --         close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
  --       },
  --       toggle = {
  --         hint = "<leader>ah",
  --         repomap = "<leader>aR",
  --       },
  --     },
  --     repo_map = {
  --       ignore_patterns = { "%.git", "%.worktree", "__pycache__", "node_modules" }, -- ignore files matching these
  --       negate_patterns = {}, -- negate ignore files matching these.
  --     },
  --     --- @class AvanteFileSelectorConfig
  --     file_selector = {
  --       --- @alias FileSelectorProvider "native" | "fzf" | "mini.pick" | "snacks" | "telescope" | string | fun(params: avante.file_selector.IParams|nil): nil
  --       provider = "telescope",
  --       -- Options override for custom providers
  --       provider_opts = {},
  --     },
  --     windows = {
  --       -- width = 35,
  --       wrap = true,
  --       input = {
  --         prefix = "",
  --       },
  --       sidebar_header = {
  --         enabled = false,
  --       },
  --       edit = {
  --         border = "rounded",
  --         floating = false,
  --         start_insert = true, -- Start insert mode when opening the edit window
  --       },
  --       ask = {
  --         floating = false, -- Open the 'AvanteAsk' prompt in a floating window
  --         start_insert = true, -- Start insert mode when opening the ask window
  --         border = "none",
  --         ---@type "ours" | "theirs"
  --         focus_on_apply = "ours", -- which diff to focus after applying
  --       },
  --     }
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = "make",
  --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "echasnovski/mini.pick", -- for file_selector provider mini.pick
  --     "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
  --     "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
  --     "ibhagwan/fzf-lua", -- for file_selector provider fzf
  --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --     "zbirenbaum/copilot.lua", -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       'MeanderingProgrammer/render-markdown.nvim',
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'catppuccin-macchiato',
          icons_enabled = true,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          refresh = {
            statusline = 100,
          },
        },
        sections = {
          lualine_a = { { 'mode', icon = '' } },
          lualine_b = { { 'branch', icon = '' }, 'diff', 'diagnostics' },
          -- lualine_c = { { 'filename', file_status = true, path = 2, icon = '' } },
          lualine_c = {
            {
              function()
                return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')  -- 获取当前目录名称
              end,
              icon = '',  -- 可以自定义图标
              color = { fg = '#ffcc00', gui = 'bold' },  -- 设置高亮
            },
            { 'filename', file_status = true, path = 2, icon = '' }
          },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { { 'location', icon = '' } }
        }
      }
    end
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
  },
  {'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async'},
  -- {
  --   'luukvbaal/statuscol.nvim',
  --   opts = function()
  --     local builtin = require('statuscol.builtin')
  --     return {
  --       setopt = true,
  --       -- override the default list of segments with:
  --       -- number-less fold indicator, then signs, then line number & separator
  --       segments = {
  --         { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
  --         { text = { '%s' }, click = 'v:lua.ScSa' },
  --         {
  --           text = { builtin.lnumfunc, ' ' },
  --           condition = { true, builtin.not_empty },
  --           click = 'v:lua.ScLa',
  --         },
  --       },
  --     }
  --   end,
  -- },
  -- {
  --   'ggandor/leap.nvim',
  --   config = function()
  --     require('leap').setup { opts = { safe_labels = {} } }
  --     vim.keymap.del({'n', 'x', 'o'}, 's')
  --     vim.keymap.del({'n', 'x', 'o'}, 'S')
  --     vim.keymap.set({'n', 'x', 'o'}, 'f', function()
  --       require('leap').leap { target_windows = {vim.api.nvim_get_current_win()} }
  --     end)
  --   end
  -- },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = {
          enabled = true,
          jump_labels = true, -- 显示提示字母
          keys = { "f", "F" }, -- 把这些键绑定给 flash
        },
      },
    },
    keys = {
      {
        "f",
        mode = { "n", "x", "o" },
        function()
          -- 启动 Flash，在屏幕所有地方查找字符（不分方向）
          require("flash").treesitter({
            search = {
              mode = "exact",
              forward = true
            },
            label = {
              style = "overlay",
            },
            jump = {
              autojump = true, -- 自动跳过去
            },
          })
        end,
        desc = "Flash Everywhere (no direction)",
      },
      {
        "F",
        mode = { "n", "x", "o" },
        function()
          -- 启动 Flash，在屏幕所有地方查找字符（不分方向）
          require("flash").treesitter({
            search = {
              mode = "exact",
              forward = false
            },
            label = {
              style = "overlay",
            },
            jump = {
              autojump = true, -- 自动跳过去
            },
          })
        end,
        desc = "Flash Everywhere (no direction)",
      },
    },
  },
  -- {
  --   "justinmk/vim-sneak",
  --   keys = {
  --     { "f", "<Plug>Sneak_s", mode = { "n", "x", "o" }, desc = "Sneak forward" },
  --     { "F", "<Plug>Sneak_S", mode = { "n", "x", "o" }, desc = "Sneak backward" },
  --   },
  --   init = function()
  --     vim.g["sneak#label"] = 1        -- 开启标签提示
  --     vim.g["sneak#use_ic_scs"] = 1   -- 智能大小写
  --   end,
  -- },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<C-\>]],
        direction = "horizontal",
        size = 15
      })
    end
  },
  -- {
  --   'rmagatti/auto-session',
  --   lazy = false,
  
  --   ---enables autocomplete for opts
  --   ---@module "auto-session"
  --   ---@type AutoSession.Config
  --   opts = {
  --     suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/', 'node_modules', '~/Code' },
  --     -- log_level = 'debug',
  --     cwd_change_handling = true,
  --     pre_cwd_changed_cmds = {
  --       "tabdo NERDTreeClose" -- Close NERDTree before saving session
  --     },
  --     post_cwd_changed_cmds = {
  --       function()
  --         require("lualine").refresh() -- example refreshing the lualine status line _after_ the cwd changes
  --       end
  --     }
  --   }
  -- }
}

-- require('monokai').setup { italics = false }
-- require('monokai').load()

require("nvim-navic")

require("filetype").setup({
  overrides = {
      extensions = {
          -- Set the filetype of *.pn files to potion
          pn = "potion",
      },
      literal = {
          -- Set the filetype of files named "MyBackupFile" to lua
          MyBackupFile = "lua",
      },
      complex = {
          -- Set the filetype of any full filename matching the regex to gitconfig
          [".*git/config"] = "gitconfig", -- Included in the plugin
      },

      -- The same as the ones above except the keys map to functions
      function_extensions = {
          ["cpp"] = function()
              vim.bo.filetype = "cpp"
              -- Remove annoying indent jumping
              vim.bo.cinoptions = vim.bo.cinoptions .. "L0"
          end,
          ["pdf"] = function()
              vim.bo.filetype = "pdf"
              -- Open in PDF viewer (Skim.app) automatically
              vim.fn.jobstart(
                  "open -a skim " .. '"' .. vim.fn.expand("%") .. '"'
              )
          end,
      },
      function_literal = {
          Brewfile = function()
              vim.cmd("syntax off")
          end,
      },
      function_complex = {
          ["*.math_notes/%w+"] = function()
              vim.cmd("iabbrev $ $$")
          end,
      },

      shebang = {
          -- Set the filetype of files with a dash shebang to sh
          dash = "sh",
      },
  },
})


local function cmd(command)
  return table.concat({ '<Cmd>', command, '<CR>' })
end

require('dotenv').setup({
  enable_on_load = true, -- will load your .env file upon loading a buffer
  verbose = false, -- show error notification if .env file is not found and if .env is loaded
})

require 'colorizer'.setup {
  filetypes = {
    '*',
    html = { mode = 'foreground'; }
  },
}

require('tsc').setup()

require('cmp').setup {
  enabled = true,
  autocomplete = true,
  source = {
    path = true,
    buffer = true,
    nvim_lsp = true,
    nvim_lua = true,
  },
}

require("flutter-tools").setup {}

require('spectre').setup({
  color_devicons=true,
  lnum_for_results = true,
  highlight = {
    ui = "String",
    search = "DiffChange",
    replace = "DiffDelete"
  },
  line_sep_start = '┌-----------------------------------------',
  result_padding = '¦  ',
  line_sep       = '└-----------------------------------------',
  live_update=true,
  is_insert_mode=true
})
lvim.keys.normal_mode["<leader>sg"] = ":Spectre<CR>"
function Spectre_search_current_file()
  local spectre = require("spectre")
  spectre.open_file_search({select_word=false})
end
lvim.keys.normal_mode["<leader>s/"] = ":lua Spectre_search_current_file()<CR>"
lvim.keys.normal_mode["<leader>r"] = ":e!<CR>"


vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldcolumn = '0'
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]


local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' 󰁂 %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
      local chunkText = chunk[1]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
      else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, {chunkText, hlGroup})
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
          end
          break
      end
      curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, {suffix, 'MoreMsg'})
  return newVirtText
end

require('ufo').setup({
  fold_virt_text_handler = handler,
  provider_selector = function(bufnr, filetype, buftype)
      return {'treesitter', 'indent'}
  end
})


lvim.builtin.treesitter.context_commentstring.enable_autocmd = false
lvim.keys.insert_mode["<M-]>"] = { "<Plug>(copilot-next)", { silent = true } }

lvim.builtin.breadcrumbs.active = false


-- 设置 Space + 方向键来切换窗口
vim.api.nvim_set_keymap('n', '<Space><Left>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space><Down>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space><Up>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space><Right>', '<C-w>l', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Space>]', ':vsp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>[', ':sp<CR>', { noremap = true, silent = true })


-- vim.api.nvim_set_keymap('n', '<Space>.', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Space>,', '<C-t>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>.', ":lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Space>,', '<C-t>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'D-.', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'D-,', '<C-t>', { noremap = true, silent = true })

-- vim.g.codeium_no_map_tab = 1
-- vim.g.codeium_disable_bindings = 1

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

vim.keymap.set("n", "<Down>", "gj")
vim.keymap.set("n", "<Up>", "gk")


vim.keymap.set("v", "j", "gj")
vim.keymap.set("v", "k", "gk")

vim.keymap.set("v", "<Down>", "gj")
vim.keymap.set("v", "<Up>", "gk")

-- inoremap <Down> gj
-- inoremap <Up> gk
vim.api.nvim_set_keymap("i", "<Up>", "<C-o>gk", { noremap = true, silent = true })

vim.api.nvim_set_keymap("i", "<Down>", "<C-o>gj", { noremap = true, silent = true })

lvim.builtin.alpha.dashboard.section.header.val = {
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " "
}

lvim.builtin.alpha.dashboard.section.footer.val = {
  " "
}

require("telescope").load_extension "file_browser"


lvim.keys.normal_mode["<leader>se"] = ":Telescope file_browser path=%:p:h select_buffer=true<CR>"

-- require('go').setup()

-- lvim.keys.normal_mode["<leader>sx"] = ":lua require('telescope.builtin').buffers({ sort_lastused = true, ignore_current_buffer = true, sort_mru = true })<CR>"


require('gitsigns').setup {
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  -- signs_staged = {
  --   add          = { text = '┃' },
  --   change       = { text = '┃' },
  --   delete       = { text = '_' },
  --   topdelete    = { text = '‾' },
  --   changedelete = { text = '~' },
  --   untracked    = { text = '┆' },
  -- },
  -- signs_staged_enable = true,
  -- signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 0,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}

lvim.builtin.gitsigns.opts.current_line_blame = true
-- lvim.builtin.gitsigns.opts.SignColumn = true
lvim.builtin.gitsigns.opts.numhl = true

require('hlslens').setup()

-- require("typescript-tools").setup {
--   settings = {
--     -- spawn additional tsserver instance to calculate diagnostics on it
--     separate_diagnostic_server = true,
--     -- "change"|"insert_leave" determine when the client asks the server about diagnostic
--     publish_diagnostic_on = "insert_leave",
--     -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
--     -- "remove_unused_imports"|"organize_imports") -- or string "all"
--     -- to include all supported code actions
--     -- specify commands exposed as code_actions
--     expose_as_code_action = {},
--     -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
--     -- not exists then standard path resolution strategy is applied
--     tsserver_path = nil,
--     -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
--     -- (see 💅 `styled-components` support section)
--     tsserver_plugins = {},
--     -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
--     -- memory limit in megabytes or "auto"(basically no limit)
--     tsserver_max_memory = "auto",
--     -- described below
--     tsserver_format_options = {},
--     tsserver_file_preferences = {},
--     -- locale of all tsserver messages, supported locales you can find here:
--     -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
--     tsserver_locale = "en",
--     -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
--     complete_function_calls = false,
--     include_completions_with_insert_text = true,
--     -- CodeLens
--     -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
--     -- possible values: ("off"|"all"|"implementations_only"|"references_only")
--     code_lens = "off",
--     -- by default code lenses are displayed on all referencable values and for some of you it can
--     -- be too much this option reduce count of them by removing member references from lenses
--     disable_member_code_lens = true,
--     -- JSXCloseTag
--     -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
--     -- that maybe have a conflict if enable this feature. )
--     jsx_close_tag = {
--         enable = false,
--         filetypes = { "javascriptreact", "typescriptreact" },
--     }
--   },
-- }

vim.opt.guicursor = "n:block,i:ver25,r:hor10,v:hor20,c:ver20,sm:block-blinkwait175-blinkoff150-blinkon175"

-- vim.opt.guicursor = {
--   -- Normal mode
--   'n:block',       -- Block cursor for normal, visual, and command modes
--   -- Insert mode
--   'i:ver25',           -- Vertical bar cursor with 25% width for insert mode
--   -- Replace mode
--   'r:hor20',           -- Horizontal bar cursor with 20% height for replace mode
--   -- Visual mode
--   'v:block',           -- Horizontal bar cursor with 20% height for visual mode
--   -- Command-line mode
--   'c:ver25',           -- Horizontal bar cursor with 20% height for command-line mode
--   -- Select mode
--   'sm:block-blinkwait175-blinkoff150-blinkon175', -- Blinking block cursor for select mode
--   -- More modes and their cursor styles can be added here
-- }

-- require('nvim-cursorline').setup {
--   cursorline = {
--     enable = true,
--     timeout = 0,
--     number = false,
--   },
--   cursorword = {
--     enable = true,
--     min_length = 3,
--     hl = { underline = false }
--   }
-- }

vim.api.nvim_set_keymap('n', 'D-z', 'u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'D-S-z', '<C-r>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'D-z', '<C-o>u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'D-S-z', '<C-o><C-r>', { noremap = true, silent = true })

require("fidget").setup({
  text = {
      spinner = "dots", -- 使用点状加载动画
  },
  window = {
      blend = 0, -- 不透明背景
  },
})
lvim.builtin.which_key.mappings["c"] = {} -- 清除 `<leader>c`
lvim.builtin.which_key.mappings["a"] = {} -- 清除 `<leader>c`


-- lvim.builtin.which_key.mappings["a"] = {
--   name = "Avante",
--   -- c = { "<cmd>AvanteClear<CR>", "Avante Clear" },
--   l = {
--     function()
--       -- 1. 进入视觉模式 (v)
--       vim.api.nvim_feedkeys('v', 'n', false)

--       -- 2. 执行 AvanteClear
--       vim.cmd('AvanteClear')

--       -- 3. 按 Esc 退出视觉模式
--       vim.defer_fn(function()
--         vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
--       end, 50)
--     end,
--     "Avante Clear"
--   },
--   v = { "<cmd>AvanteAsk 解释这些代码<CR>", "Avante Explain" },
--   w = { "<cmd>AvanteToggle <CR>", "Avante Toggle" },
--   y = { "<cmd>AvanteAsk 为这些代码生成文档，并且生成对应文件的 SEARCH/REPLACE 块<CR>", "Avante Docs" },
--   u = { "<cmd>AvanteAsk 为这些代码生成测试，并且生成对应文件的 SEARCH/REPLACE 块<CR>", "Avante Tests" },
--   x = { "<cmd>AvanteAsk 请在代码的功能性、性能、可读性、安全性，或者是否存在潜在的错误或改进空间等方面审查以下代码，优化这些代码，修复其中的bug和问题（如果有），并且生成对应文件的 SEARCH/REPLACE 块<CR>", "Avante Review" },
--   m = { "<cmd>AvanteAsk 总结这些代码，写一个 git commit message  <CR>", "Avante Commit" },
-- }

-- lvim.builtin.which_key.mappings["a"] = {
--   name = "Copilot", -- 让 which-key 显示 "Copilot" 作为菜单名称
--   a = { "<cmd>CopilotChat<CR>", "Chat Toggle" },
--   e = { "<cmd>CopilotChatExplain<CR>", "Explain Code" },
--   f = { "<cmd>CopilotChatFix<CR>", "Fix Code" },
--   o = { "<cmd>CopilotChatOptimize<CR>", "Optimize Code" },
--   d = { "<cmd>CopilotChatDocs<CR>", "Generate Docs" },
--   t = { "<cmd>CopilotChatTests<CR>", "Generate Tests" },
--   s = { "<cmd>CopilotChatStop<CR>", "Copilot Stop" },
--   r = { "<cmd>CopilotChatReview<CR>", "Copilot Review" },
--   m = { "<cmd>CopilotChatCommit<CR>", "Copilot Review" },
-- }

-- lvim.keys.visual_mode["<leader>al"] = "<cmd>AvanteClear<CR>"
-- lvim.keys.visual_mode["<leader>aw"] = "<cmd>AvanteToggle <CR>"
-- lvim.keys.visual_mode["<leader>av"] = "<cmd>AvanteAsk 解释这些代码<<CR>"
-- lvim.keys.visual_mode["<leader>ay"] = "<cmd>AvanteAsk 为这些代码生成文档，并且生成对应文件的 SEARCH/REPLACE 块<CR>"
-- lvim.keys.visual_mode["<leader>au"] = "<cmd>AvanteAsk 为这些代码生成测试，并且生成对应文件的 SEARCH/REPLACE 块<CR>"
-- lvim.keys.visual_mode["<leader>ax"] = "<cmd>AvanteAsk 请在代码的功能性、性能、可读性、安全性，或者是否存在潜在的错误或改进空间等方面审查以下代码，优化这些代码，修复其中的bug和问题（如果有），并且生成对应文件的 SEARCH/REPLACE 块<CR>"
-- lvim.keys.visual_mode["<leader>am"] = "<cmd>AvanteAsk 总结这些代码，写一个 git commit message<CR>"

-- lvim.keys.visual_mode["<leader>aa"] = "<cmd>CopilotChat<CR>"
-- lvim.keys.visual_mode["<leader>ae"] = "<cmd>CopilotChatExplain<CR>"
-- lvim.keys.visual_mode["<leader>af"] = "<cmd>CopilotChatFix<CR>"
-- lvim.keys.visual_mode["<leader>ao"] = "<cmd>CopilotChatOptimize<CR>"
-- lvim.keys.visual_mode["<leader>ad"] = "<cmd>CopilotChatDocs<CR>"
-- lvim.keys.visual_mode["<leader>at"] = "<cmd>CopilotChatTests<CR>"
-- lvim.keys.visual_mode["<leader>as"] = "<cmd>CopilotChatStop<CR>"
-- lvim.keys.visual_mode["<leader>ar"] = "<cmd>CopilotChatReview<CR>"
-- lvim.keys.visual_mode["<leader>am"] = "<cmd>CopilotChatCommit<CR>"


-- lvim.colorscheme = "duskfox"
lvim.colorscheme = "catppuccin-macchiato"

-- vim.opt.fillchars = {
--   vert = " ", -- 垂直分隔符为空格
--   horiz = " ", -- 水平分隔符为空格
--   horizup = " ", -- 上水平分隔符为空格
--   horizdown = " ", -- 下水平分隔符为空格
--   vertleft = " ", -- 左垂直分隔符为空格
--   vertright = " ", -- 右垂直分隔符为空格
--   verthoriz = " ", -- 十字分隔符为空格
-- }

require('nvim-window').setup({
  -- The characters available for hinting windows.
  chars = {
    'q', 'w', 'e', 'd', 's', 'a', 'r', 'f', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
    'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
  },

  -- A group to use for overwriting the Normal highlight group in the floating
  -- window. This can be used to change the background color.
  normal_hl = 'Normal',

  -- The highlight group to apply to the line that contains the hint characters.
  -- This is used to make them stand out more.
  hint_hl = 'Bold',

  -- The border style to use for the floating window.
  border = 'single',

  -- How the hints should be rendered. The possible values are:
  --
  -- - "float" (default): renders the hints using floating windows
  -- - "status": renders the hints to a string and calls `redrawstatus`,
  --   allowing you to show the hints in a status or winbar line
  render = 'float',
})

lvim.keys.normal_mode["<leader>sw"] = ":lua require('nvim-window').pick()<CR>"

vim.cmd [[autocmd VimEnter * Startify]]

vim.g.startify_lists = {
  { type = 'commands', header = { '   Commands' }, indices = { 'f', 'p', 't', 'r', 'c', 'v' } },
  { type = 'files', header = { '   MRU' }, indices = { 
    '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
    'a', 's', 'd', 'g', 'h', 'j', 'k', 'l', ';', '\''
  } },
  -- { type = 'dir', header = { '   Current Directory' }, indices = { 'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '/' } },
}

vim.g.startify_commands = {
  { 'Find File', ':Telescope find_files'},
  { 'Projects', ':Telescope projects'},
  { 'Find Text', ':Telescope live_grep'},
  { 'Recent files', ':Telescope oldfiles'},
  { 'Configuration', ':e ~/.config/lvim/config.lua'},
  { 'Refresh', ':Startify'},
}

vim.g.startify_files_number = 20

lvim.keys.normal_mode["<leader>v"] = ":Startify <CR>"
lvim.keys.normal_mode["<leader>sd"] = ":TodoTelescope <CR>"


vim.g.autoim_toggle_shortcut = 'cmd_space'

vim.opt.termguicolors = true

-- require('leap').add_default_mappings(false)

-- require("lspconfig").volar.setup({
--   on_attach = function(client)
--     client.server_capabilities.documentFormattingProvider = false
--   end
-- })

require("lspconfig").tsserver.setup({
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git")
})

local null_ls = require("null-ls")

-- 设置格式化器 & Linter
null_ls.setup({
  sources = {
    -- Prettier 格式化器
    null_ls.builtins.formatting.prettier.with({
      filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "yaml", "markdown" },
    }),

    -- ESLint Linter（诊断 + 自动修复）
    null_ls.builtins.diagnostics.eslint.with({
      condition = function(utils)
        return utils.root_has_file({ "eslint.config.mjs", "eslint.config.js", ".eslintrc.js", ".eslintrc.json" })
      end,
    }),

    null_ls.builtins.code_actions.eslint.with({
      condition = function(utils)
        return utils.root_has_file({ "eslint.config.mjs", "eslint.config.js", ".eslintrc.js", ".eslintrc.json" })
      end,
    }),
    -- Go 语言格式化工具
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.goimports,
    -- Go 语言诊断工具（可选）
    null_ls.builtins.diagnostics.golangci_lint,
    -- 格式化器，调用 SwiftFormat
    null_ls.builtins.formatting.swiftformat,
    -- 诊断工具，调用 SwiftLint
    null_ls.builtins.diagnostics.swiftlint,
  },
})

local lspconfig = require("lspconfig")
local lsp_signature = require("lsp_signature")

local on_attach = function(client, bufnr)
  lsp_signature.on_attach({
    bind = true,
    handler_opts = {
      border = "rounded"
    },
  }, bufnr)
end

-- Go
require("lspconfig").gopls.setup({
  on_attach = on_attach,
})

-- TypeScript / JavaScript
require("lspconfig").tsserver.setup({
  on_attach = on_attach,
})

-- Swift（需要你本地安装 sourcekit-lsp）
require("lspconfig").sourcekit.setup({
  on_attach = on_attach,
})

-- local swift_lsp = vim.api.nvim_create_augroup("swift_lsp", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "swift" },
--   callback = function()
--     local root_dir = vim.fs.dirname(vim.fs.find({
--       'Package.swift',
--       ".git",
--     }, { upward = true })[1])
--     local client = vim.lsp.start({
--       name = "sourcekit-lsp",
--       cmd = { "sourcekit-lsp" },
--       root_dir = root_dir,
--     })
--     vim.lsp.buf_attach_client(0, client)
--   end,
--   group = swift_lsp,
-- })
