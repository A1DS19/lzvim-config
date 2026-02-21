-- ── Custom filetype detection ─────────────────────────────────────────────

vim.filetype.add({
  extension = {
    -- GLSL shaders
    vert = "glsl",
    frag = "glsl",
    -- Arduino
    ino = "arduino",
    -- Assembly
    asm = "asm",
    s   = "asm",
    S   = "asm",
    inc = "asm",
  },
  pattern = {
    [".*%.asm"] = "asm",
    [".*%.s"]   = "asm",
    [".*%.S"]   = "asm",
  },
})

-- ── Custom file icons ──────────────────────────────────────────────────────
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    local ok, devicons = pcall(require, "nvim-web-devicons")
    if not ok then return end
    devicons.set_icon({
      asm = { icon = "", color = "#529aba", name = "Asm" },
      s   = { icon = "", color = "#529aba", name = "AsmS" },
      S   = { icon = "", color = "#529aba", name = "AsmSUpper" },
      inc = { icon = "", color = "#529aba", name = "AsmInc" },
    })
  end,
})

-- ── Format on save ────────────────────────────────────────────────────────
-- LazyVim has autoformat built-in (toggle with <leader>uf).
-- This autocmd handles filetypes not covered by conform / none-ls primary.
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {
    "*.rs", "*.c", "*.cpp", "*.cs",
    "*.ts", "*.tsx", "*.js", "*.jsx",
    "*.py", "*.lua",
    "*.hpp", "*.h",
    "*.json", "*.yaml", "*.yml", "*.toml",
    "*.sh", "*.bash",
    "*.html", "*.css", "*.scss",
    "*.md",
    "*.cmake", "CMakeLists.txt", "Makefile", "*.make",
    "Dockerfile", "*.dockerfile",
    "*.go", "*.java", "*.php", "*.rb",
    "*.vim", "*.xml", "*.svg",
    "*.vert", "*.frag", "*.glsl",
  },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- Arduino: format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.ino",
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 1000 })
  end,
})
