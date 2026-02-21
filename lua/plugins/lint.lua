return {
  -- ── nvim-lint: async linting ──────────────────────────────────────────────
  -- Replaces none-ls diagnostics sources. Install missing tools via Mason or
  -- system package manager (see README for the full list).
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        yaml       = { "yamllint" },
        cmake      = { "cmakelint" },
        dockerfile = { "hadolint" },
      },
    },
  },
}
