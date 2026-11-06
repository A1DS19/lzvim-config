return {
  -- ── neotest: run tests inline from Neovim ────────────────────────────────
  -- The Python, Rust and .NET adapters come from their lang extras; only Jest
  -- needs wiring here.
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
    dependencies = { "nvim-neotest/neotest-jest" },
    opts = {
      adapters = {
        ["neotest-jest"] = { jestCommand = "npx jest --passWithNoTests" },
      },
    },
  },
}
