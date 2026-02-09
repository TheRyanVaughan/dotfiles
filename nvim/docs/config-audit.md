# Neovim Configuration Audit

Generated: 2026-02-08
Forked from: [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)

---

## Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [All Plugins](#all-plugins)
3. [All Keymaps](#all-keymaps)
4. [All Autocommands](#all-autocommands)
5. [All Vim Options](#all-vim-options)
6. [LSP Servers](#lsp-servers)
7. [Formatters](#formatters)
8. [Differences from Current Kickstart.nvim](#differences-from-current-kickstartnvim)
9. [Modernization Recommendations](#modernization-recommendations)
10. [TODOs Found in Config](#todos-found-in-config)

---

## Architecture Overview

**Plugin Manager:** lazy.nvim (bootstrap in `init.lua`)
**Structure:** Modular — one file per plugin in `lua/plugins/`
**Entry Point:** `init.lua` → requires `remaps`, `options`, `autocommands`, then loads lazy.nvim with `{ import = "plugins" }`

```
nvim/
├── init.lua
├── lazy-lock.json
├── lua/
│   ├── options.lua
│   ├── remaps.lua
│   ├── autocommands.lua
│   └── plugins/
│       ├── ale.lua
│       ├── conform.lua
│       ├── gitsigns.lua
│       ├── harpoon.lua
│       ├── lspconfig.lua
│       ├── mini.lua
│       ├── nvimcmp.lua
│       ├── telescope.lua
│       ├── theme.lua
│       ├── todocomments.lua
│       ├── treesitter.lua
│       └── whichkey.lua
└── docs/
```

---

## All Plugins

### Core Plugins (11)

| Plugin | Repo | Purpose | Lazy Loading | File |
|--------|------|---------|--------------|------|
| lazy.nvim | `folke/lazy.nvim` | Plugin manager | N/A (bootstrap) | `init.lua` |
| Comment.nvim | `numToStr/Comment.nvim` | Toggle code comments | None | `init.lua` |
| nvim-lspconfig | `neovim/nvim-lspconfig` | LSP client configuration | None | `plugins/lspconfig.lua` |
| nvim-cmp | `hrsh7th/nvim-cmp` | Autocompletion engine | `InsertEnter` | `plugins/nvimcmp.lua` |
| nvim-treesitter | `nvim-treesitter/nvim-treesitter` | Syntax highlighting/parsing | None | `plugins/treesitter.lua` |
| telescope.nvim | `nvim-telescope/telescope.nvim` | Fuzzy finder | `VimEnter` | `plugins/telescope.lua` |
| conform.nvim | `stevearc/conform.nvim` | Code formatting | None | `plugins/conform.lua` |
| tokyonight.nvim | `folke/tokyonight.nvim` | Color scheme | `priority = 1000` | `plugins/theme.lua` |
| harpoon (v2) | `ThePrimeagen/harpoon` | Quick file navigation | None | `plugins/harpoon.lua` |
| gitsigns.nvim | `lewis6991/gitsigns.nvim` | Git gutter signs | None | `plugins/gitsigns.lua` |
| mini.nvim | `echasnovski/mini.nvim` | ai + surround + statusline | None | `plugins/mini.lua` |

### Support/Dependency Plugins (11)

| Plugin | Repo | Purpose | Loaded By |
|--------|------|---------|-----------|
| mason.nvim | `williamboman/mason.nvim` | LSP/tool installer | lspconfig |
| mason-lspconfig.nvim | `williamboman/mason-lspconfig.nvim` | Mason ↔ lspconfig bridge | lspconfig |
| mason-tool-installer.nvim | `WhoIsSethDaniel/mason-tool-installer.nvim` | Auto-install tools | lspconfig |
| fidget.nvim | `j-hui/fidget.nvim` | LSP progress indicator | lspconfig |
| neodev.nvim | `folke/neodev.nvim` | Neovim Lua API completion | lspconfig |
| LuaSnip | `L3MON4D3/LuaSnip` | Snippet engine | nvim-cmp |
| cmp_luasnip | `saadparwaiz1/cmp_luasnip` | Snippet source for cmp | nvim-cmp |
| cmp-nvim-lsp | `hrsh7th/cmp-nvim-lsp` | LSP source for cmp | nvim-cmp |
| cmp-path | `hrsh7th/cmp-path` | Path source for cmp | nvim-cmp |
| plenary.nvim | `nvim-lua/plenary.nvim` | Lua utility library | telescope, harpoon |
| nvim-web-devicons | `nvim-tree/nvim-web-devicons` | File type icons | telescope |

### Telescope Extensions (2)

| Plugin | Repo | Purpose |
|--------|------|---------|
| telescope-fzf-native.nvim | `nvim-telescope/telescope-fzf-native.nvim` | FZF-based sorting |
| telescope-ui-select.nvim | `nvim-telescope/telescope-ui-select.nvim` | Telescope for `vim.ui.select` |

### Other Plugins (3)

| Plugin | Repo | Purpose | File |
|--------|------|---------|------|
| which-key.nvim | `folke/which-key.nvim` | Keybinding hints popup | `plugins/whichkey.lua` |
| todo-comments.nvim | `folke/todo-comments.nvim` | TODO/FIXME highlighting | `plugins/todocomments.lua` |
| ALE | `dense-analysis/ale` | Async linter (C# mainly) | `plugins/ale.lua` |

**Total: 27 plugins**

---

## All Keymaps

### Global Keymaps (`remaps.lua`)

| Mode | Key | Action | Description |
|------|-----|--------|-------------|
| `n` | `<Space>` | Leader key | `mapleader` and `maplocalleader` |
| `n` | `<leader>pv` | `vim.cmd.Ex` | Open file explorer (netrw) |
| `n` | `<Esc>` | `:nohlsearch` | Clear search highlighting |
| `n` | `[d` | `vim.diagnostic.goto_prev` | Previous diagnostic |
| `n` | `]d` | `vim.diagnostic.goto_next` | Next diagnostic |
| `n` | `<leader>e` | `vim.diagnostic.open_float` | Show diagnostic float |
| `n` | `<leader>q` | `vim.diagnostic.setloclist` | Open diagnostic quickfix |
| `t` | `<Esc><Esc>` | `<C-\><C-n>` | Exit terminal mode |
| `n` | `<C-h>` | `<C-w><C-h>` | Focus left window |
| `n` | `<C-l>` | `<C-w><C-l>` | Focus right window |
| `n` | `<C-j>` | `<C-w><C-j>` | Focus lower window |
| `n` | `<C-k>` | `<C-w><C-k>` | Focus upper window |

### Telescope Keymaps (`plugins/telescope.lua`)

| Mode | Key | Action | Description |
|------|-----|--------|-------------|
| `n` | `<leader>sh` | `builtin.help_tags` | Search Help |
| `n` | `<leader>sk` | `builtin.keymaps` | Search Keymaps |
| `n` | `<leader>sf` | `builtin.find_files` | Search Files |
| `n` | `<leader>ss` | `builtin.builtin` | Search Telescope builtins |
| `n` | `<leader>sw` | `builtin.grep_string` | Search current Word |
| `n` | `<leader>sg` | `builtin.live_grep` | Search by Grep |
| `n` | `<leader>sd` | `builtin.diagnostics` | Search Diagnostics |
| `n` | `<leader>sr` | `builtin.resume` | Search Resume |
| `n` | `<leader>s.` | `builtin.oldfiles` | Search recent files |
| `n` | `<leader><leader>` | `builtin.buffers` | Find existing buffers |
| `n` | `<leader>/` | `current_buffer_fuzzy_find` | Fuzzy search current buffer |
| `n` | `<leader>s/` | `live_grep` (open files) | Search in open files |
| `n` | `<leader>sn` | `find_files` (config dir) | Search Neovim config files |

### LSP Keymaps (`plugins/lspconfig.lua` — active only when LSP attaches)

| Mode | Key | Action | Description |
|------|-----|--------|-------------|
| `n` | `gd` | `telescope.lsp_definitions` | Goto Definition |
| `n` | `gr` | `telescope.lsp_references` | Goto References |
| `n` | `gI` | `telescope.lsp_implementations` | Goto Implementation |
| `n` | `<leader>D` | `telescope.lsp_type_definitions` | Type Definition |
| `n` | `<leader>ds` | `telescope.lsp_document_symbols` | Document Symbols |
| `n` | `<leader>ws` | `telescope.lsp_dynamic_workspace_symbols` | Workspace Symbols |
| `n` | `<leader>rn` | `vim.lsp.buf.rename` | Rename symbol |
| `n` | `<leader>ca` | `vim.lsp.buf.code_action` | Code Action |
| `n` | `K` | `vim.lsp.buf.hover` | Hover Documentation |
| `n` | `gD` | `vim.lsp.buf.declaration` | Goto Declaration |

### Harpoon Keymaps (`plugins/harpoon.lua`)

| Mode | Key | Action | Description |
|------|-----|--------|-------------|
| `n` | `<leader>a` | `harpoon:list():add()` | Add file to harpoon |
| `n` | `<C-e>` | `harpoon.ui:toggle_quick_menu` | Toggle harpoon menu |
| `n` | `<leader>b` | `harpoon:list():prev()` | Previous harpoon file |
| `n` | `<leader>n` | `harpoon:list():next()` | Next harpoon file |

### Completion Keymaps (`plugins/nvimcmp.lua` — active in insert mode)

| Mode | Key | Action | Description |
|------|-----|--------|-------------|
| `i` | `<C-n>` | Select next item | Next completion |
| `i` | `<C-p>` | Select previous item | Previous completion |
| `i` | `<C-b>` | Scroll docs backward | Scroll docs up |
| `i` | `<C-f>` | Scroll docs forward | Scroll docs down |
| `i` | `<C-y>` | Confirm completion | Accept completion |
| `i` | `<C-Space>` | Trigger completion | Manual complete |
| `i,s` | `<C-l>` | LuaSnip jump forward | Next snippet field |
| `i,s` | `<C-h>` | LuaSnip jump backward | Previous snippet field |

### Which-Key Groups (`plugins/whichkey.lua`)

| Prefix | Group Name |
|--------|-----------|
| `<leader>c` | [C]ode |
| `<leader>d` | [D]ocument |
| `<leader>r` | [R]ename |
| `<leader>s` | [S]earch |
| `<leader>w` | [W]orkspace |

---

## All Autocommands

| Event | Group | Location | Purpose |
|-------|-------|----------|---------|
| `TextYankPost` | `kickstart-highlight-yank` | `autocommands.lua` | Briefly highlight yanked text |
| `LspAttach` | `kickstart-lsp-attach` | `plugins/lspconfig.lua` | Set up LSP keymaps and document highlights |
| `CursorHold`, `CursorHoldI` | (buffer-local, in LspAttach) | `plugins/lspconfig.lua` | Highlight references of symbol under cursor |
| `CursorMoved`, `CursorMovedI` | (buffer-local, in LspAttach) | `plugins/lspconfig.lua` | Clear reference highlights |

---

## All Vim Options

### Set in `options.lua`

| Option | Value | Purpose |
|--------|-------|---------|
| `vim.g.have_nerd_font` | `true` | Enable Nerd Font icons |
| `vim.opt.number` | `true` | Show line numbers |
| `vim.opt.relativenumber` | `true` | Relative line numbers |
| `vim.opt.shiftwidth` | `4` | Indent width (set twice!) |
| `vim.opt.softtabstop` | `-1` | Use shiftwidth value |
| `vim.opt.mouse` | `"a"` | Mouse in all modes |
| `vim.opt.showmode` | `false` | Hide mode (statusline shows it) |
| `vim.opt.clipboard` | `"unnamedplus"` | OS clipboard sync |
| `vim.opt.breakindent` | `true` | Wrapped lines keep indent |
| `vim.opt.undofile` | `true` | Persistent undo |
| `vim.opt.ignorecase` | `true` | Case-insensitive search |
| `vim.opt.smartcase` | `true` | ...unless uppercase used |
| `vim.opt.signcolumn` | `"yes"` | Always show sign column |
| `vim.opt.updatetime` | `250` | Faster CursorHold |
| `vim.opt.timeoutlen` | `300` | Key sequence timeout |
| `vim.opt.splitright` | `true` | Splits open right |
| `vim.opt.splitbelow` | `true` | Splits open below |
| `vim.opt.list` | `true` | Show whitespace chars |
| `vim.opt.listchars` | `tab:"  ", trail:"·", nbsp:"␣"` | Whitespace rendering |
| `vim.opt.inccommand` | `"split"` | Live substitution preview |
| `vim.opt.cursorline` | `true` | Highlight cursor line |
| `vim.opt.scrolloff` | `10` | 10 lines scroll context |
| `vim.opt.hlsearch` | `true` | Highlight search |

### Set in `remaps.lua`

| Option | Value |
|--------|-------|
| `vim.g.mapleader` | `" "` (space) |
| `vim.g.maplocalleader` | `" "` (space) |

### Set in Other Plugins

| Option | Value | Set By |
|--------|-------|--------|
| `vim.g.ale_ruby_robocop_auto_correct_all` | `1` | `plugins/ale.lua` |
| `vim.g.ale_linters` | `{ cs = { "OmniSharp" } }` | `plugins/ale.lua` |

---

## LSP Servers

| Server | Language | Custom Settings |
|--------|----------|-----------------|
| `tsserver` | TypeScript/JavaScript | `checkJs = true`, `allowJs = true` |
| `eslint` | JS/TS Linting | None |
| `omnisharp` | C# | `EnableEditorConfigSupport = true` |
| `lua_ls` | Lua | `callSnippet = "Replace"` |

### Mason Auto-installed Tools

- All servers above + `stylua`

---

## Formatters (conform.nvim)

| Filetype | Formatter(s) | Fallback |
|----------|-------------|----------|
| `lua` | `stylua` | LSP |
| `javascript` | `prettier` → `eslint_d` | LSP |
| `typescript` | `prettier` → `eslint_d` | LSP |
| `javascriptreact` | `prettier` → `eslint_d` | LSP |
| `typescriptreact` | `prettier` → `eslint_d` | LSP |
| `c`, `cpp` | **Disabled** | None |
| All others | None | LSP fallback |

Format-on-save enabled with 500ms timeout.

---

## Differences from Current Kickstart.nvim

Current kickstart.nvim (as of 2026) has diverged significantly from your fork:

### Plugins Kickstart Changed

| Area | Your Config | Current Kickstart | Notes |
|------|-------------|-------------------|-------|
| **Completion** | `nvim-cmp` + `cmp-nvim-lsp` + `cmp_luasnip` + `cmp-path` | `blink.cmp` (v1.*) | Major change — blink.cmp replaces the entire nvim-cmp ecosystem |
| **Indentation** | Hardcoded `shiftwidth = 4` | `guess-indent.nvim` | Auto-detects per file |
| **Mason** | `williamboman/mason.nvim` + `mason-lspconfig.nvim` | `mason-org/mason.nvim` (org moved) | Repo moved to mason-org |
| **Lua dev** | `folke/neodev.nvim` | Removed (built into neovim now) | neodev is deprecated |
| **LSP keymaps** | Custom (`gd`, `gr`, `gI`, etc.) | Uses new `gr*` convention (`grr`, `gri`, `grd`, `gO`, `gW`, `grt`) | Kickstart aligned with neovim 0.11+ defaults |
| **Treesitter** | `nvim-treesitter.configs.setup()` | `vim.treesitter.start()` via FileType autocommand | Kickstart uses built-in treesitter API |
| **Nerd Font** | `true` (always) | `false` (default, user must enable) | Minor |
| **Relative numbers** | Enabled | Not enabled | Your preference |
| **Commenting** | `Comment.nvim` (loaded in init.lua) | Removed (built into neovim 0.10+) | `gc`/`gcc` is native now |

### Plugins You Added (Not in Kickstart)

| Plugin | Purpose | Recommendation |
|--------|---------|----------------|
| `ThePrimeagen/harpoon` (v2) | Quick file marks | Keep — unique and useful |
| `dense-analysis/ale` | Async linter (C#) | **Remove** — redundant with LSP + conform |
| `numToStr/Comment.nvim` | Code commenting | **Remove** — built into neovim 0.10+ natively |

### Plugins Kickstart Added (Not in Yours)

| Plugin | Purpose | Recommendation |
|--------|---------|----------------|
| `NMAC427/guess-indent.nvim` | Auto-detect indentation | **Add** — solves your shiftwidth TODO |

### API / Config Changes

| Area | Your Config | Current Kickstart |
|------|-------------|-------------------|
| `vim.highlight.on_yank()` | `vim.highlight.on_yank()` | `vim.hl.on_yank()` (new API) |
| `vim.loop.fs_stat()` | `vim.loop.fs_stat()` | `vim.uv.fs_stat()` (renamed in 0.10) |
| which-key setup | `require("which-key").register({...})` | `require("which-key").add({...})` (v3 API) |
| clipboard | Set directly | Scheduled after UIEnter for faster startup |
| confirm on quit | Not set | `vim.o.confirm = true` |

---

## Modernization Recommendations

### Priority 1: Replace Deprecated/Outdated Plugins

| Replace | With | Why |
|---------|------|-----|
| `nvim-cmp` + all cmp sources | [`blink.cmp`](https://github.com/saghen/blink.cmp) | Modern completion, better performance, built-in fuzzy matching, simpler config. Kickstart already switched. |
| `Comment.nvim` | **Remove entirely** | Neovim 0.10+ has native `gc`/`gcc` commenting |
| `folke/neodev.nvim` | **Remove entirely** | Deprecated; Neovim has built-in Lua LS support now |
| `dense-analysis/ale` | **Remove entirely** | Redundant with LSP diagnostics + conform for formatting |

### Priority 2: Consider Modern Alternatives

| Replace | With | Why |
|---------|------|-----|
| `telescope.nvim` | [`fzf-lua`](https://github.com/ibhagwan/fzf-lua) or [`snacks.nvim` picker](https://github.com/folke/snacks.nvim) | fzf-lua is faster, lighter, no build step. Snacks picker has frecency. LazyVim defaults to fzf-lua now. |
| Hardcoded `shiftwidth = 4` | [`guess-indent.nvim`](https://github.com/NMAC427/guess-indent.nvim) | Auto-detects per file — solves your TODO |
| `williamboman/mason.nvim` | [`mason-org/mason.nvim`](https://github.com/mason-org/mason.nvim) | Repo moved to new org |

### Priority 3: Update Configuration Patterns

| What | Action |
|------|--------|
| `vim.loop` → `vim.uv` | Rename in init.lua bootstrap |
| `vim.highlight.on_yank()` → `vim.hl.on_yank()` | Update in autocommands.lua |
| which-key `.register()` → `.add()` | Update to which-key v3 API |
| LSP keymaps | Consider adopting `gr*` convention (neovim 0.11+ defaults) |
| Clipboard sync | Schedule after UIEnter for faster startup |
| Add `vim.o.confirm = true` | Prevent accidental quit with unsaved changes |
| `tsserver` → `ts_ls` | tsserver was renamed in lspconfig |

### Priority 4: Nice-to-Have Additions

| Plugin | Purpose |
|--------|---------|
| [`snacks.nvim`](https://github.com/folke/snacks.nvim) | Dashboard, notifications, picker, and many small utilities in one package |
| [`oil.nvim`](https://github.com/stevearc/oil.nvim) | File explorer as a buffer (better than netrw for `<leader>pv`) |

---

## TODOs Found in Config

| File | Line | TODO |
|------|------|------|
| `options.lua` | 13 | "How do i configure this properly? it seems wrong on many projects" (re: shiftwidth) |
| `gitsigns.lua` | 1 | "lets add a keymap to toggle the line diffs on/off (and perhaps word diff) so I can preview PR changes easily" |
| `ale.lua` | 1 | "Evaluate if I use ale at all, and whether I still need it" |

---

## Other Files

| File | Status |
|------|--------|
| `lua/after/ftplugin/javascript.lua` | Empty — can be deleted |
| `lazy-lock.json` | Plugin lock file — will regenerate |
| `README.md` | Personal notes |
| `docs/housekeeping.md` | Maintenance notes |
| `docs/usr_*.md` | Learning notes |
