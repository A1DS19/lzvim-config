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

        null_ls.builtins.formatting.eslint_d.with({
          condition = function(utils)
            return utils.root_has_file({
              ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json",
              "package.json", "turbo.json",
            })
          end,
        }),

        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.yamlfmt,
        null_ls.builtins.formatting.cmake_format,

        -- ── Code actions ─────────────────────────────────────────────

        null_ls.builtins.code_actions.eslint_d,

        -- ── Diagnostics / linters ────────────────────────────────────

        null_ls.builtins.diagnostics.eslint.with({
          condition = function(utils)
            return utils.root_has_file({
              ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json",
            })
          end,
        }),

        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.diagnostics.cmake_lint,
      })
      return opts
    end,
  },
}
