-- ============================================================
--  lua/plugins/ui.lua — Interface : statusline, telescope, etc.
-- ============================================================

return {

  -- ── Lualine : barre de statut en bas ──────────────────────
  -- Affiche : mode, git branch, fichier, erreurs LSP, position, etc.
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",   -- suit ton colorscheme (change si tu changes de thème)
          -- theme = "auto"        -- détecte le thème automatiquement
          globalstatus = true,   -- une seule statusline pour tous les splits
          component_separators = { left = "", right = "" },
          section_separators   = { left = "", right = "" },
        },

        sections = {
          lualine_a = { "mode" },               -- mode vim actuel
          lualine_b = { "branch", "diff", "diagnostics" }, -- git + erreurs
          lualine_c = { { "filename", path = 1 } },  -- chemin relatif du fichier
          -- path = 0 → nom seul, path = 1 → chemin relatif, path = 2 → chemin absolu
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },           -- % dans le fichier
          lualine_z = { "location" },           -- ligne:colonne
        },
      })
    end,
  },

  -- ── Telescope : fuzzy finder ──────────────────────────────
  -- Chercher fichiers, texte, buffers, etc. avec preview
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Extension pour de meilleures performances (optionnel, nécessite make/gcc)
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          prompt_prefix  = "  ",     -- icône de recherche
          selection_caret = " ",
          path_display   = { "smart" }, -- affiche les chemins intelligemment
          file_ignore_patterns = {   -- fichiers à ignorer
            "node_modules", ".git/", "dist/", "build/",
          },
        },
      })
      -- Active l'extension fzf si disponible
      pcall(telescope.load_extension, "fzf")
    end,
  },

  -- ── Which-key : aide aux raccourcis ───────────────────────
  -- Affiche une popup avec les raccourcis disponibles quand tu hésites
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        delay = 500, -- délai avant d'afficher la popup (ms)
      })

      -- Groupes de raccourcis (pour l'affichage)
      require("which-key").add({
        { "<leader>f", group = "Fichiers / Telescope" },
        { "<leader>l", group = "LSP" },
        { "<leader>b", group = "Buffers" },
        { "<leader>g", group = "Git" },
      })
    end,
  },

  -- ── Indent-blankline : guides d'indentation ───────────────
  -- Affiche des lignes verticales pour visualiser l'indentation
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│", -- caractère de la ligne (alternatives : ▏ ¦ ┆)
        },
        scope = {
          enabled = true, -- surligne le bloc de code actuel
        },
      })
    end,
  },

  -- ── Gitsigns : indicateurs git dans la gouttière ──────────
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = "│" },
          change       = { text = "│" },
          delete       = { text = "󰍵" },
          topdelete    = { text = "‾" },
          changedelete = { text = "~" },
        },
        -- Raccourcis Git
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "Git: " .. desc })
          end
          map("]c", gs.next_hunk,         "Prochain changement")
          map("[c", gs.prev_hunk,         "Changement précédent")
          map("<leader>gp", gs.preview_hunk, "Prévisualiser le changement")
          map("<leader>gb", gs.blame_line, "Blame de la ligne")
          map("<leader>gr", gs.reset_hunk, "Annuler le changement")
        end,
      })
    end,
  },

  -- ── Autopairs : ferme automatiquement (, {, [, ", ' ────────
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- utilise treesitter pour être plus intelligent
      })
      -- Intégration avec cmp : ajoute la parenthèse après une fonction
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- ── Comment.nvim : commenter/décommenter rapidement ───────
  -- gcc → commenter la ligne | gc + mouvement → commenter le bloc
  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    config = true, -- utilise la config par défaut
  },

}
