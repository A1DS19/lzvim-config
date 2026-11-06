-- Options are set before plugins load to avoid flicker
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.cmdheight = 2
vim.opt.guifont = "JetBrainsMono Nerd Font:h17"

-- TypeScript 7's native server instead of vtsls. Mason supplies the binary, so
-- it also works in projects pinned to an older TypeScript.
vim.g.lazyvim_ts_lsp = "tsc"

-- Cursor colours — bright red block so it always pops
vim.api.nvim_set_hl(0, "Cursor",  { fg = "#000000", bg = "#ff5555", bold = true }) -- normal: red
vim.api.nvim_set_hl(0, "iCursor", { fg = "#000000", bg = "#ff79c6", bold = true }) -- insert: pink
vim.api.nvim_set_hl(0, "vCursor", { fg = "#000000", bg = "#ff5555", bold = true }) -- visual: red
vim.api.nvim_set_hl(0, "rCursor", { fg = "#000000", bg = "#ff5555", bold = true }) -- replace: red

-- Tell Neovim which highlight group to use per mode
vim.opt.guicursor = "n-v-c:block-Cursor,i-ci:ver25-iCursor,r-cr:hor20-rCursor,o:hor50-Cursor"
