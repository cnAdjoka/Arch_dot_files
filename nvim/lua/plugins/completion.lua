-- ============================================================
--  lua/plugins/completion.lua — Autocomplétion (nvim-cmp)
--  Sources : LSP, snippets, buffer, chemin de fichiers
-- ============================================================

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter", -- charge seulement en mode insertion (performance)

  dependencies = {
    -- Sources de complétion
    "hrsh7th/cmp-nvim-lsp",   -- depuis le LSP (la plus importante)
    "hrsh7th/cmp-buffer",     -- depuis les mots du buffer courant
    "hrsh7th/cmp-path",       -- chemins de fichiers système
    "hrsh7th/cmp-cmdline",    -- dans la barre de commandes :

    -- Snippets (petits bouts de code réutilisables)
    "L3MON4D3/LuaSnip",             -- moteur de snippets
    "saadparwaiz1/cmp_luasnip",     -- intégration avec cmp
    "rafamadriz/friendly-snippets", -- collection de snippets pour plein de langages

    -- Icônes dans le menu de complétion
    "onsails/lspkind.nvim",
  },

  config = function()
    local cmp     = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- Charge les snippets de friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({

      -- ── Snippets ─────────────────────────────────────────
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      -- ── Apparence du menu ─────────────────────────────────
      window = {
        completion    = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      -- ── Formatage des items (icônes + source) ─────────────
      formatting = {
        format = lspkind.cmp_format({
          mode      = "symbol_text", -- affiche icône + texte
          maxwidth  = 50,
          ellipsis_char = "...",
          -- Montre d'où vient la suggestion (LSP, Buffer, Path...)
          menu = {
            nvim_lsp = "[LSP]",
            luasnip  = "[Snippet]",
            buffer   = "[Buffer]",
            path     = "[Path]",
          },
        }),
      },

      -- ── Raccourcis dans le menu de complétion ─────────────
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),  -- item précédent
        ["<C-j>"] = cmp.mapping.select_next_item(),  -- item suivant
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),     -- scroll docs vers le haut
        ["<C-f>"] = cmp.mapping.scroll_docs(4),      -- scroll docs vers le bas
        ["<C-Space>"] = cmp.mapping.complete(),      -- déclencher manuellement
        ["<C-e>"] = cmp.mapping.abort(),             -- fermer le menu

        -- Confirmer avec Entrée OU Tab
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Entrée confirme seulement si sélectionné
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()  -- avance dans le snippet
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)          -- recule dans le snippet
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      -- ── Sources de complétion (ordre = priorité) ──────────
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 }, -- LSP en premier
        { name = "luasnip",  priority = 750 },  -- snippets
        { name = "buffer",   priority = 500 },  -- mots du fichier
        { name = "path",     priority = 250 },  -- chemins fichiers
      }),
    })

    -- Complétion dans la barre de commandes /
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = { { name = "buffer" } },
    })

    -- Complétion dans la barre de commandes :
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
      }),
    })
  end,
}
