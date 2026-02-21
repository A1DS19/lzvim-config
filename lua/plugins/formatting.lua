return {
  -- ── conform.nvim: async formatting ───────────────────────────────────────
  -- Replaces none-ls for formatting. Install missing tools via Mason or system
  -- package manager (see README for the full list).
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- ── Web ──────────────────────────────────────────────────────
        javascript      = { "prettier" },
        typescript      = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json            = { "prettier" },
        html            = { "prettier" },
        css             = { "prettier" },
        scss            = { "prettier" },
        yaml            = { "prettier" },
        markdown        = { "prettier" },

        -- ── Systems / embedded ───────────────────────────────────────
        c               = { "clang_format" },
        cpp             = { "clang_format" },
        glsl            = { "clang_format" },

        -- ── Scripting ────────────────────────────────────────────────
        python          = { "isort", "black" },
        sh              = { "shfmt" },
        bash            = { "shfmt" },
        lua             = { "stylua" },

        -- ── .NET ─────────────────────────────────────────────────────
        cs              = { "csharpier" },
        fsharp          = { "fantomas" },

        -- ── Build systems ─────────────────────────────────────────────
        cmake           = { "cmake_format" },
      },
    },
  },
}
