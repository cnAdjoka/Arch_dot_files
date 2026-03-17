-- ============================================================
--  lua/plugins/treesitter.lua — Coloration syntaxique avancée
--  Treesitter parse le code comme un vrai AST, bien mieux
--  que les regex classiques de vim
-- ============================================================

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate", -- met à jour les parsers après installation

  config = function()
    require("nvim-treesitter").setup({

      -- ── Parsers à installer automatiquement ───────────────
      -- Ajoute les langages que tu utilises
      ensure_installed = {
        "lua", "vim", "vimdoc",     -- pour neovim lui-même
        "javascript", "typescript", -- JS/TS
        "python",                   -- Python
        "rust",                     -- Rust
        "go",                       -- Go
        "html", "css", "json",      -- Web
        "bash",                     -- Shell
        "markdown", "markdown_inline", -- Markdown
        "yaml", "toml",             -- Config files
        -- "c", "cpp",              -- C/C++
        -- "php",                   -- PHP
      },

      -- Installe les parsers manquants automatiquement
      auto_install = true,

      -- ── Coloration syntaxique ─────────────────────────────
      highlight = {
        enable = true,
        -- Désactive la coloration regex de vim (redondant avec treesitter)
        additional_vim_regex_highlighting = false,
      },

      -- ── Indentation automatique ───────────────────────────
      indent = {
        enable = true, -- indentation basée sur treesitter
      },

      -- ── Sélection incrémentale ────────────────────────────
      -- Permet d'étendre/réduire la sélection intelligemment
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection    = "<C-space>",  -- commence la sélection
          node_incremental  = "<C-space>",  -- étend au nœud parent
          node_decremental  = "<bs>",       -- réduit au nœud enfant
        },
      },
    })
  end,
}
