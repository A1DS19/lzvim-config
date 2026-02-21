# lzvim-config

A personal [LazyVim](https://www.lazyvim.org/) configuration with a Dracula theme, a curated set of language extras, and custom plugin overrides.

## Requirements

| Dependency | Version | Notes |
|---|---|---|
| [Neovim](https://neovim.io/) | >= 0.11.2 (LuaJIT build) | Required |
| [Git](https://git-scm.com/) | >= 2.19.0 | Required |
| [Nerd Font](https://www.nerdfonts.com/) | v3.0+ | Required for icons |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | latest | Required for grep |
| [fd](https://github.com/sharkdp/fd) | latest | Required for file search |
| [lazygit](https://github.com/jesseduffield/lazygit) | latest | Required for LazyGit |
| [fzf](https://github.com/junegunn/fzf) | latest | Required for fzf-lua |
| A true-color terminal | — | kitty / wezterm / ghostty (recommended) |

> **Terminal recommendation:** [Ghostty](https://ghostty.org) unlocks Snacks image preview (kitty graphics protocol), proper undercurl rendering, and the best Nerd Font support. WarpTerminal is supported but lacks these features.

Optional — only needed for specific language servers / formatters:

| Tool | For |
|---|---|
| `clangd`, `clang-format` | C / C++ / GLSL |
| `dotnet` SDK | C# / F# |
| `node`, `npm` | TypeScript, Tailwind, HTML/CSS |
| `python`, `pip` | Python |
| `cargo`, `rustup` | Rust |
| `cmake`, `cmake-format`, `cmake-lint` | CMake |
| `prettier` | JS/TS/JSON/HTML/CSS/YAML/Markdown |
| `black`, `isort` | Python formatting |
| `stylua` | Lua formatting |
| `shfmt` | Shell formatting |
| `yamlfmt`, `yamllint` | YAML formatting / linting |
| `hadolint` | Dockerfile linting |
| `arduino-cli` | Arduino language server |
| `asm-lsp` | Assembly (AVR / x86 / ARM) |

Install most of these directly from Neovim with `:MasonInstall <tool>`.

---

## Installation

### 1. Backup your existing Neovim config

```sh
mv ~/.config/nvim{,.bak}
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
```

### 2. Clone this repo into `~/.config/nvim`

```sh
git clone https://github.com/<your-username>/lzvim-config ~/.config/nvim
```

### 3. Launch Neovim

```sh
nvim
```

On first launch [lazy.nvim](https://github.com/folke/lazy.nvim) bootstraps itself automatically, then installs all plugins and language servers. This takes a minute or two.

Once the UI settles, run `:LazyHealth` to verify everything loaded correctly.

---

## Post-install: fix remaining health warnings

After `:LazyHealth` you will likely see a few expected warnings. Here is how to clear them:

### Missing formatters / linters

```sh
# via Mason (inside Neovim)
:MasonInstall prettier stylua shfmt yamlfmt

# via pip
pip install black isort yamllint cmake-lint

# via npm (global)
npm i -g prettier
```

### tree-sitter-cli version mismatch

nvim-treesitter requires an exact version. Install it via Mason:

```
:MasonInstall tree-sitter-cli
```

or with Cargo:

```sh
cargo install tree-sitter-cli --version 0.26.1
```

### luarocks (lazy.nvim warning)

No plugins in this config require luarocks. The warning is safe to ignore. If you want to silence it, add to `lazy.lua`:

```lua
rocks = { enabled = false },
```

### Neorg keybind conflicts

These are cosmetic — Neorg skips conflicting keys automatically. If you want Neorg's full keybind set, resolve the conflicts in your `keymaps.lua`.

---

## What's Included

### Theme

- **Dracula** — active colorscheme with italic comments

### Language Support

| Language | Extra / LSP |
|---|---|
| Rust | `lang.rust` + rustaceanvim |
| C / C++ | `lang.clangd` (custom flags, C++23, inlay hints) |
| TypeScript / JavaScript | `lang.typescript` (vtsls) |
| Python | `lang.python` + venv-selector |
| C# / .NET | `lang.dotnet` (OmniSharp) |
| F# | fantomas formatter |
| Tailwind CSS | `lang.tailwind` |
| YAML | `lang.yaml` + SchemaStore |
| JSON | `lang.json` + SchemaStore |
| Markdown | `lang.markdown` + render-markdown |
| Docker | `lang.docker` + hadolint linter |
| TOML | `lang.toml` |
| CMake | `lang.cmake` + cmake-tools |
| HTML / CSS | `htmlls` / `cssls` |
| Bash | `bashls` + shfmt |
| Lua | `lua_ls` + stylua |
| GLSL | `glsl_analyzer` + clang-format |
| Assembly | `asm_lsp` (AVR / x86 / ARM) |
| Arduino | `arduino-language-server` |
| Nushell | `nvim-nu` (syntax + indent) |

### Plugins

| Plugin | Role |
|---|---|
| **blink.cmp** | Rust-native completion engine (faster than nvim-cmp) |
| **conform.nvim** | Async formatter (replaces none-ls) |
| **nvim-lint** | Async linter (replaces none-ls diagnostics) |
| **LuaSnip** | Snippet engine + friendly-snippets + user snippets |
| **nvim-tree** | Sidebar file explorer (auto-opens on launch) |
| **oil.nvim** | Edit the filesystem like a buffer |
| **fzf-lua** | Fuzzy finder (faster than Telescope) |
| **LazyGit** | Git TUI inside Neovim |
| **neotest** | Inline test runner (Rust / Python / .NET / Jest) |
| **cmake-tools** | Build / run CMake projects |
| **nvim-autopairs** | Auto-close brackets / quotes |
| **nvim-ts-autotag** | Auto-close HTML / JSX tags |
| **DAP** | Debug adapter protocol (codelldb / debugpy / netcoredbg / js-debug) |
| **Neorg** | Org-mode for Neovim (loads on `.norg` files) |

### Key Bindings

#### File navigation

| Key | Action |
|---|---|
| `<C-t>` / `<leader>e` | Toggle nvim-tree |
| `-` | Open parent directory in oil.nvim |
| `<leader>ff` | Find files (fzf-lua) |
| `<leader>fg` | Live grep (fzf-lua) |
| `<leader>fb` | Buffers (fzf-lua) |
| `<leader>fh` | Help tags (fzf-lua) |
| `<leader>fgf` | Live grep in current file |

#### Git

| Key | Action |
|---|---|
| `<leader>gg` | Open LazyGit |

#### Tests (neotest)

| Key | Action |
|---|---|
| `<leader>tt` | Run nearest test |
| `<leader>tT` | Run all tests in file |
| `<leader>tr` | Re-run last test |
| `<leader>ts` | Toggle test summary panel |
| `<leader>to` | Open test output |

#### Completion (blink.cmp)

| Key | Action |
|---|---|
| `<C-j>` / `<C-k>` | Navigate completion menu |
| `<CR>` | Accept completion |
| `<C-e>` | Cancel completion |

#### Window navigation (works inside nvim-tree too)

| Key | Action |
|---|---|
| `<C-h/j/k/l>` | Move between windows |
| `v` (in nvim-tree) | Open file in vertical split |

All other key bindings follow the [LazyVim defaults](https://www.lazyvim.org/keymaps).

---

## Updating

```
:Lazy update
:MasonUpdate
```

---

## Useful Commands

| Command | Description |
|---|---|
| `:Lazy` | Plugin manager UI |
| `:LazyHealth` | Health check for all plugins |
| `:Mason` | LSP / tool installer UI |
| `:MasonUpdate` | Update all Mason-managed tools |
| `:LazyGit` | Open LazyGit TUI |
| `:Oil` | Open current directory as a buffer |
| `:CMakeGenerate` | Generate CMake build files |
| `:CMakeBuild` | Build the CMake project |
| `:Neotest run` | Run nearest test |
| `:Neotest summary` | Open test summary panel |

---

## References

- [LazyVim documentation](https://www.lazyvim.org/)
- [lazy.nvim documentation](https://lazy.folke.io/)
- [LazyVim extras](https://www.lazyvim.org/extras)
- [blink.cmp](https://github.com/Saghen/blink.cmp)
- [conform.nvim](https://github.com/stevearc/conform.nvim)
- [oil.nvim](https://github.com/stevearc/oil.nvim)
- [fzf-lua](https://github.com/ibhagwan/fzf-lua)
- [neotest](https://github.com/nvim-neotest/neotest)
