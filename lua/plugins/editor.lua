return {
  -- ── Disable snacks file explorer (using nvim-tree instead) ────────────
  {
    "folke/snacks.nvim",
    opts = {
      explorer = { enabled = false },
    },
  },

  -- ── nvim-tree ─────────────────────────────────────────────────────────
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = {
      { "<C-t>",      "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
      { "<leader>e",  "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
    },
    opts = {
      disable_netrw = true,
      hijack_netrw  = true,
      update_cwd    = false,
      update_focused_file = { enable = false, update_cwd = false },
      view = {
        width = 35,
        side  = "left",
        number         = false,
        relativenumber = false,
      },
      filters = {
        dotfiles    = false,
        git_clean   = false,
        git_ignored = false,
        custom      = {},
      },
      git = {
        enable  = true,
        ignore  = false,
        timeout = 400,
      },
      actions = {
        open_file = { quit_on_open = false },
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set("n", "v", api.node.open.vertical, {
          desc    = "nvim-tree: Open vertical split",
          buffer  = bufnr,
          noremap = true,
          silent  = true,
          nowait  = true,
        })
      end,
    },
  },

  -- ── Telescope customisations ──────────────────────────────────────────
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    opts = function(_, opts)
      local actions    = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        mappings = {
          n = {
            ["s"] = actions.select_horizontal,
            ["v"] = actions.select_vertical,
          },
          i = {
            ["<C-s>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
          },
        },
      })

      opts.extensions = vim.tbl_deep_extend("force", opts.extensions or {}, {
        file_browser = {
          theme           = "dropdown",
          hijack_netrw    = false,
          layout_strategy = "horizontal",
          layout_config   = { width = 0.8, height = 0.9, prompt_position = "bottom", mirror = false },
          mappings = {
            ["n"] = {
              ["<A-c>"] = fb_actions.create,
              ["<S-CR>"] = fb_actions.create_from_prompt,
              ["<A-r>"] = fb_actions.rename,
              ["<A-m>"] = fb_actions.move,
              ["<A-y>"] = fb_actions.copy,
              ["<A-d>"] = fb_actions.remove,
              ["<C-o>"] = fb_actions.open,
              ["<C-g>"] = fb_actions.goto_parent_dir,
              ["<C-e>"] = fb_actions.goto_home_dir,
              ["<C-w>"] = fb_actions.goto_cwd,
              ["<C-t>"] = fb_actions.change_cwd,
              ["<C-f>"] = fb_actions.toggle_browser,
              ["<C-h>"] = fb_actions.toggle_hidden,
              ["<C-s>"] = fb_actions.toggle_all,
              ["<BS>"]  = fb_actions.backspace,
            },
          },
        },
      })

      return opts
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "file_browser")
      pcall(telescope.load_extension, "fzf")
    end,
  },

  -- Telescope extensions (declared separately so lazy.nvim resolves them)
  { "nvim-telescope/telescope-file-browser.nvim", lazy = true },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    lazy  = true,
  },

  -- ── CMake tools ───────────────────────────────────────────────────────
  {
    "Civitasv/cmake-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "cmake", "cpp", "c" },
    opts = {
      cmake_command              = "cmake",
      cmake_regenerate_on_save   = true,
      cmake_generate_options     = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
      cmake_build_options        = {},
      cmake_build_directory      = "build/${variant:buildType}",
      cmake_soft_link_compile_commands = true,
      cmake_compile_commands_from_lsp  = false,
      cmake_dap_configuration = {
        name           = "cpp",
        type           = "codelldb",
        request        = "launch",
        stopOnEntry    = false,
        runInTerminal  = true,
        console        = "integratedTerminal",
      },
      cmake_executor = {
        name = "quickfix",
        opts = {},
        default_opts = {
          quickfix = {
            show                   = "always",
            position               = "belowright",
            size                   = 10,
            encoding               = "utf-8",
            auto_close_when_success = true,
          },
        },
      },
      cmake_runner = {
        name = "terminal",
        opts = {},
        default_opts = {
          terminal = {
            name             = "Main Terminal",
            prefix_name      = "[CMakeTools]: ",
            split_direction  = "horizontal",
            split_size       = 11,
          },
        },
      },
    },
  },
}
