-- ── Telescope overrides ────────────────────────────────────────────────────
-- Remap <leader>fg to live_grep (LazyVim default maps it to git-files)
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help Tags" })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })

-- Live-grep restricted to the current file
vim.keymap.set("n", "<leader>fgf", function()
  require("telescope.builtin").live_grep({ search_dirs = { vim.fn.expand("%:p") } })
end, { desc = "Live Grep (current file)" })

-- ── File explorer (nvim-tree) ─────────────────────────────────────────────
vim.keymap.set("n", "<C-t>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

-- ── Buffer navigation ─────────────────────────────────────────────────────
-- <S-h> / <S-l> are already set by LazyVim for prev/next buffer.
-- These are extra aliases matching old muscle memory.
vim.keymap.set("n", "<leader>bn", "<cmd>bn<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Delete Buffer" })

-- ── Terminal ──────────────────────────────────────────────────────────────
-- LazyVim exposes Snacks.terminal globally
vim.keymap.set("n", "<leader>tt", function() Snacks.terminal() end, { desc = "Terminal" })

-- ── LSP (already set by LazyVim, kept for explicitness) ──────────────────
vim.keymap.set("n", "gd", vim.lsp.buf.definition,     { desc = "Go to Definition" })
vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Go to Implementation" })

-- ── Auto-hover on CursorHold ──────────────────────────────────────────────
-- Skip filetypes that produce noisy hover popups
local hover_excluded_ft = { yml = true, yaml = true, txt = true, text = true, markdown = true, md = true }
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    if hover_excluded_ft[vim.bo.filetype] then return end
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    for _, client in ipairs(clients) do
      if client.supports_method("textDocument/hover") then
        vim.lsp.buf.hover()
        break
      end
    end
  end,
})
vim.o.updatetime = 500
