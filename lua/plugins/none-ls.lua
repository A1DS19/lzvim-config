return {
  -- ── none-ls: formatters and linters ──────────────────────────────────
  -- The lsp.none-ls LazyVim extra adds the plugin; we configure sources here.
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {

        -- ── Formatters ───────────────────────────────────────────────

        null_ls.builtins.formatting.prettier.with({
          filetypes = {
            "javascript", "typescript", "javascriptreact", "typescriptreact",
            "json", "html", "css", "scss", "markdown", "yaml", "glsl",
          },
        }),

        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.yamlfmt,
        null_ls.builtins.formatting.cmake_format,

        -- ── Diagnostics / linters ────────────────────────────────────
        -- Note: ESLint diagnostics/code-actions are handled by the
        -- lazyvim.plugins.extras.linting.eslint extra (uses nvim-lint).

        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.diagnostics.cmake_lint,
      })
      return opts
    end,
  },
}
