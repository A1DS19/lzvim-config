-- biome-check only counts as available inside a project with a Biome config, so
-- every other project falls through to Prettier.
local biome_or_prettier = { "biome-check", "prettier", stop_after_first = true }

return {
  -- ── conform.nvim: async formatting ───────────────────────────────────────
  -- Replaces none-ls for formatting. Install missing tools via Mason or system
  -- package manager (see README for the full list).
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- ── Web ──────────────────────────────────────────────────────
        javascript      = biome_or_prettier,
        typescript      = biome_or_prettier,
        javascriptreact = biome_or_prettier,
        typescriptreact = biome_or_prettier,
        json            = biome_or_prettier,
        css             = biome_or_prettier,
        scss            = biome_or_prettier,
        html            = { "prettier" },
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
  { "mason-org/mason.nvim", opts = { ensure_installed = { "isort" } } },
}
