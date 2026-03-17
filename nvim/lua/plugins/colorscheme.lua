-- ============================================================
--  lua/plugins/colorscheme.lua — Thème de couleurs
-- ============================================================

return {
  -- Catppuccin : thème moderne et populaire (variantes : latte, frappe, macchiato, mocha)
  -- Remplace par ton thème préféré si tu veux : tokyonight, gruvbox, rose-pine...
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- charger en premier pour éviter les flash de couleurs

  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- "latte" (clair) | "frappe" | "macchiato" | "mocha" (sombre)

      integrations = {
        -- Active les intégrations avec nos autres plugins
        cmp        = true,   -- nvim-cmp (autocomplétion)
        gitsigns   = true,   -- indicateurs git
        nvimtree   = false,
        neo_tree   = true,   -- explorateur de fichiers
        telescope  = true,   -- fuzzy finder
        treesitter = true,   -- coloration syntaxique avancée
        which_key  = true,   -- aide aux raccourcis
        alpha      = true,   -- dashboard (page d'accueil)
      },
    })

    -- Applique le thème
    vim.cmd.colorscheme("catppuccin")
  end,
}
