return {
  -- ── Snacks overrides ──────────────────────────────────────────────────
  {
    "folke/snacks.nvim",
    opts = {
      explorer     = { enabled = false }, -- using nvim-tree instead
      statuscolumn = { enabled = true  }, -- cleaner folds + git + diagnostics gutter
    },
  },

  -- ── render-markdown: disable latex (no parser installed) ─────────────
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = { latex = { enabled = false } },
  },


  -- ── nvim-tree ─────────────────────────────────────────────────────────
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- Load eagerly so the VimEnter autocmd can open it immediately
    lazy = false,
    keys = {
      { "<C-t>",     "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
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

        local function map(key, action, desc)
          vim.keymap.set("n", key, action, {
            desc = "nvim-tree: " .. desc,
            buffer  = bufnr,
            noremap = true,
            silent  = true,
            nowait  = true,
          })
        end

        -- Open in vertical split
        map("v", api.node.open.vertical, "Open vertical split")

        -- Window navigation: override nvim-tree's <C-k> (file info)
        -- so all four directions work the same as outside the tree
        vim.keymap.set("n", "<C-h>", "<C-w>h", { buffer = bufnr, silent = true })
        vim.keymap.set("n", "<C-j>", "<C-w>j", { buffer = bufnr, silent = true })
        vim.keymap.set("n", "<C-k>", "<C-w>k", { buffer = bufnr, silent = true })
        vim.keymap.set("n", "<C-l>", "<C-w>l", { buffer = bufnr, silent = true })
      end,
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)

      -- Auto-open nvim-tree when nvim starts (but not for diffs or stdin)
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function(data)
          local is_dir  = vim.fn.isdirectory(data.file) == 1
          local is_file = vim.fn.filereadable(data.file) == 1
          if not is_dir and not is_file then return end
          -- Open tree without stealing focus from the file
          require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
        end,
      })
    end,
  },

  -- ── fzf-lua customisations ────────────────────────────────────────────
  {
    "ibhagwan/fzf-lua",
    opts = {
      -- Open in horizontal / vertical split with the same keys muscle-memory
      -- expects from the old Telescope setup.
      winopts = { preview = { layout = "horizontal" } },
      keymap  = {
        builtin = {
          ["<C-s>"] = "toggle-preview",
        },
        fzf = {
          ["ctrl-s"] = "toggle",
          ["ctrl-v"] = "vertical",
        },
      },
    },
  },

  -- ── oil.nvim: edit the filesystem like a buffer ───────────────────────
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = {
      { "-", "<cmd>Oil<CR>", desc = "Open parent directory (Oil)" },
    },
    opts = {
      delete_to_trash            = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden  = true,
        natural_sort = true,
      },
      float = {
        padding    = 2,
        max_width  = 90,
        max_height = 30,
      },
    },
  },

  -- ── LazyGit ───────────────────────────────────────────────────────────
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd  = "LazyGit",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
    },
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
