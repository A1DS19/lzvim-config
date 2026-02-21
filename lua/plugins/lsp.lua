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

        -- ── omnisharp (override path to mason-managed binary) ──────────
        omnisharp = {
          cmd = {
            vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp",
            "--languageserver",
            "--hostPID",
            tostring(vim.fn.getpid()),
          },
          init_options = {
            RoslynExtensionsOptions = {
              enableImportCompletion   = true,
              enableRoslynAnalyzers    = true,
            },
          },
          settings = {
            FormattingOptions = {
              EnableEditorConfigSupport = true,
              OrganizeImports           = true,
            },
            RoslynExtensionsOptions = {
              enableImportCompletion   = true,
              enableRoslynAnalyzers    = true,
              documentationProvider    = true,
            },
            Sdk = { IncludePrereleases = true },
            enableEditorConfigSupport         = true,
            enableRoslynAnalyzers             = true,
            organizeImportsOnFormat           = true,
            enableImportCompletion            = true,
            includeInlayParameterNameHints    = "all",
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints     = true,
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

        -- ── Lua (lazydev.nvim is already set up by LazyVim) ───────────
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
            },
          },
        },

        -- ── schemastore for JSON/YAML (both extras pull it in) ────────
        jsonls = {
          settings = {
            json = { schemas = require("schemastore").json.schemas() },
          },
        },
        yamlls = {
          settings = {
            yaml = { schemas = require("schemastore").yaml.schemas() },
          },
        },
      },
    },
  },

  -- schemastore is a dependency for jsonls / yamlls overrides above
  { "b0o/schemastore.nvim", lazy = true },

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
