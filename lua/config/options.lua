-- Options are set before plugins load to avoid flicker
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.cmdheight = 2
vim.opt.guifont = "JetBrainsMono Nerd Font:h17"

-- Cursor colours (Dracula palette)
vim.api.nvim_set_hl(0, "Cursor",  { fg = "#000000", bg = "#44475a", bold = true })
vim.api.nvim_set_hl(0, "iCursor", { fg = "#000000", bg = "#6272a4", bold = true })
vim.api.nvim_set_hl(0, "vCursor", { fg = "#000000", bg = "#555555", bold = true })
vim.api.nvim_set_hl(0, "rCursor", { fg = "#000000", bg = "#888888", bold = true })
