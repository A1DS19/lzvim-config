return {
  -- ── CodeCompanion: AI pair programmer ────────────────────────────────────
  -- Requires ANTHROPIC_API_KEY environment variable.
  -- Usage:
  --   <leader>aa  → action palette (inline assist, explain, refactor, …)
  --   <leader>ac  → toggle chat sidebar
  --   <leader>ai  → inline completion at cursor (visual: act on selection)
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionActions<CR>",     desc = "AI Actions",     mode = { "n", "v" } },
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<CR>", desc = "AI Chat Toggle", mode = { "n", "v" } },
      { "<leader>ai", "<cmd>CodeCompanion<CR>",            desc = "AI Inline",      mode = { "n", "v" } },
    },
    opts = {
      strategies = {
        chat   = { adapter = "anthropic" },
        inline = { adapter = "anthropic" },
        agent  = { adapter = "anthropic" },
      },
    },
  },
}
