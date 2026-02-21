return {
  -- ── blink.cmp: fast Rust-native completion ────────────────────────────
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset    = "default",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-e>"] = { "cancel",      "fallback" },
        ["<CR>"]  = { "accept",      "fallback" },
      },
      snippets = { preset = "luasnip" },
    },
  },

  -- ── LuaSnip ───────────────────────────────────────────────────────────
  {
    "L3MON4D3/LuaSnip",
    opts = { history = true, updateevents = "TextChanged,TextChangedI" },
  },

  -- ── Friendly snippets ─────────────────────────────────────────────────
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      -- load user snippets stored alongside this config
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })
    end,
  },

  -- ── Autopairs ─────────────────────────────────────────────────────────
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts  = {},
  },

  -- ── Auto-close HTML/JSX tags ──────────────────────────────────────────
  -- (already included in LazyVim defaults; kept here for explicitness)
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },

  -- ── Neorg (org-mode for Neovim) ───────────────────────────────────────
  {
    "nvim-neorg/neorg",
    ft     = "norg",
    config = true,
  },

  -- ── Nushell syntax (nvim-nu) ──────────────────────────────────────────
  -- The lang.nushell extra sets up the LSP; this adds syntax/indent support
  {
    "LhKipp/nvim-nu",
    ft     = "nu",
    config = true,
  },

  -- ── dressing.nvim is no longer needed (snacks.input replaces it) ──────
  -- kept disabled so it doesn't conflict with snacks
  { "stevearc/dressing.nvim", enabled = false },
}
