-- ============================================================
--  lua/plugins/lsp.lua — Language Server Protocol
--  Fournit : erreurs en temps réel, autocomplétion intelligente,
--  aller à la définition, documentation, refactoring...
-- ============================================================

return {
  -- mason.nvim : installe les LSP servers facilement via :Mason
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = { border = "rounded" },
      })
    end,
  },

  -- mason-lspconfig : bridge entre mason et lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({

        -- ── Serveurs à installer automatiquement ─────────────
        -- Ajoute ou retire selon tes langages
        -- Liste complète : https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
        ensure_installed = {
          "lua_ls",        -- Lua
          "ts_ls",         -- TypeScript / JavaScript
          "pyright",       -- Python
          "rust_analyzer", -- Rust
          "gopls",         -- Go
          "cssls",         -- CSS
          "html",          -- HTML
          "jsonls",        -- JSON
          -- "clangd",     -- C / C++
          -- "intelephense",-- PHP
        },
      })
    end,
  },

  -- nvim-lspconfig : configuration des LSP servers
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp", -- intégration avec nvim-cmp
    },

 config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end
          map("gd",         vim.lsp.buf.definition,      "Aller à la définition")
          map("gD",         vim.lsp.buf.declaration,     "Aller à la déclaration")
          map("gr",         vim.lsp.buf.references,      "Voir les références")
          map("gi",         vim.lsp.buf.implementation,  "Voir l'implémentation")
          map("K",          vim.lsp.buf.hover,           "Documentation")
          map("<leader>ca", vim.lsp.buf.code_action,     "Code action")
          map("<leader>rn", vim.lsp.buf.rename,          "Renommer le symbole")
          map("<leader>lf", vim.lsp.buf.format,          "Formater le fichier")
        end,
      })

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      local servers = { "ts_ls", "pyright", "rust_analyzer", "gopls", "cssls", "html", "jsonls" }
      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = capabilities })
      end
    end, },
}
