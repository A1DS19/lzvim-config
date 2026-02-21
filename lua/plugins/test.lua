return {
  -- ── neotest: run tests inline from Neovim ────────────────────────────────
  -- Adapters cover the languages configured in this setup.
  -- Default keymaps (from lazyvim.plugins.extras.test.core):
  --   <leader>tt  → run nearest test
  --   <leader>tT  → run all tests in file
  --   <leader>tr  → run last test
  --   <leader>ts  → toggle summary panel
  --   <leader>to  → open test output
  --   <leader>tO  → toggle output panel
  --   <leader>tS  → stop test run
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",   -- Python (pytest / unittest)
      "rouge8/neotest-rust",           -- Rust (cargo test)
      "Issafalcon/neotest-dotnet",     -- C# / F# (dotnet test)
      "nvim-neotest/neotest-jest",     -- JS/TS (jest)
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      vim.list_extend(opts.adapters, {
        require("neotest-python"),
        require("neotest-rust"),
        require("neotest-dotnet"),
        require("neotest-jest")({ jestCommand = "npx jest --passWithNoTests" }),
      })
    end,
  },
}
