return {
  -- ── LSP server overrides & custom servers ─────────────────────────────
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {

        -- ── clangd (override LazyVim's clangd extra defaults) ──────────
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
            "--compile-commands-dir=build",
            "--pch-storage=memory",
            "--offset-encoding=utf-16",
            -- clangd's routine logging goes to stderr, which Neovim appends to lsp.log
            "--log=error",
          },
          init_options = {
            usePlaceholders    = true,
            completeUnimported = true,
            clangdFileStatus   = true,
          },
          settings = {
            clangd = {
              InlayHints = {
                Designators  = true,
                Enabled      = true,
                ParameterNames = true,
                DeducedTypes = true,
              },
              fallbackFlags = { "-std=c++23" },
            },
          },
        },

        -- ── C#: Roslyn replaces the OmniSharp server from lang.dotnet ───
        -- lspconfig's roslyn_ls defaults already enable inlay hints and
        -- completion from unimported namespaces.
        omnisharp = { enabled = false },
        roslyn_ls = {
          settings = {
            ["csharp|formatting"] = {
              dotnet_organize_imports_on_format = true,
            },
          },
        },

        -- ── GLSL (no official LazyVim extra) ───────────────────────────
        glsl_analyzer = {},

        -- ── Assembly LSP (AVR / x86 / ARM) ────────────────────────────
        asm_lsp = {
          filetypes = { "asm", "vmasm" },
        },

        -- ── HTML / CSS (covered by tailwind extra, kept explicit) ──────
        html  = {},
        cssls = {},

        -- ── Bash (no dedicated LazyVim extra) ─────────────────────────
        bashls = {},

        -- ── Lua (lazydev.nvim is already set up by LazyVim) ───────────
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
            },
          },
        },
      },
    },
  },

  -- ── Arduino language server (no official extra) ───────────────────────
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.arduino_language_server = {
        cmd = {
          "arduino-language-server",
          "-cli-config", vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
          "-fqbn",  "arduino:avr:uno",
          "-cli",   "arduino-cli",
          "-clangd", "clangd",
        },
        filetypes = { "arduino" },
      }
      return opts
    end,
  },
}
