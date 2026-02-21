-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit...", "ErrorMsg" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- LazyVim core
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- ── Language extras ──────────────────────────────────────────────
    { import = "lazyvim.plugins.extras.lang.rust" },
    { import = "lazyvim.plugins.extras.lang.clangd" },
    { import = "lazyvim.plugins.extras.lang.typescript" }, -- uses vtsls (faster than tsserver)
    { import = "lazyvim.plugins.extras.lang.python" },
    { import = "lazyvim.plugins.extras.lang.dotnet" },      -- C# (was omnisharp)
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.toml" },
    { import = "lazyvim.plugins.extras.lang.cmake" },
    -- bash: no dedicated extra; bashls added via lsp.lua servers table
    -- nushell: handled by nvim-nu plugin in coding.lua

    -- ── Editor extras ────────────────────────────────────────────────
    -- lazygit: no dedicated extra; plugin added directly in editor.lua
    { import = "lazyvim.plugins.extras.editor.fzf" },

    -- ── Coding extras ────────────────────────────────────────────────
    { import = "lazyvim.plugins.extras.coding.luasnip" }, -- LuaSnip + blink.cmp integration

    -- ── DAP extras ───────────────────────────────────────────────────
    { import = "lazyvim.plugins.extras.dap.core" },

    -- ── Test extras ──────────────────────────────────────────────────
    { import = "lazyvim.plugins.extras.test.core" },

    -- ── User plugins ─────────────────────────────────────────────────
    { import = "plugins" },
  },

  defaults = {
    lazy = false,
    version = false,
  },

  install = { colorscheme = { "dracula", "tokyonight", "habamax" } },

  checker = {
    enabled = true,
    notify = false,
  },

  performance = {
    rtp = {
      disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
})
