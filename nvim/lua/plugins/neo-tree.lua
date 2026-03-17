-- ============================================================
--  lua/plugins/neo-tree.lua — Explorateur de fichiers latéral
--  Affiche l'arborescence du projet dans une sidebar
--  Toggle : <leader>e  |  Focus : <leader>o
-- ============================================================

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch  = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",          -- utilitaires Lua
    "nvim-tree/nvim-web-devicons",    -- icônes de fichiers (nécessite une Nerd Font)
    "MunifTanjim/nui.nvim",           -- composants UI
  },

  config = function()
    require("neo-tree").setup({

      -- ── Comportement général ──────────────────────────────
      close_if_last_window = true,   -- ferme nvim si neo-tree est la dernière fenêtre
      popup_border_style   = "rounded",

      -- ── Fenêtre latérale ─────────────────────────────────
      window = {
        position = "left",  -- "left" | "right" | "float"
        width    = 35,      -- largeur en colonnes (ajuste à ton goût)

        mappings = {
          -- Raccourcis dans l'arbre
          ["<space>"] = "toggle_node",  -- ouvrir/fermer dossier
          ["<cr>"]    = "open",
          ["s"]       = "open_vsplit",  -- ouvrir en split vertical
          ["S"]       = "open_split",   -- ouvrir en split horizontal
          ["t"]       = "open_tabnew",  -- ouvrir dans un nouvel onglet
          ["a"]       = "add",          -- créer un fichier/dossier
          ["d"]       = "delete",
          ["r"]       = "rename",
          ["y"]       = "copy_to_clipboard",
          ["x"]       = "cut_to_clipboard",
          ["p"]       = "paste_from_clipboard",
          ["R"]       = "refresh",
          ["?"]       = "show_help",
        },
      },

      -- ── Sources disponibles ──────────────────────────────
      -- Tu peux basculer entre filesystem, buffers, git_status
      -- avec :Neotree source=<source>
      sources = { "filesystem", "buffers", "git_status" },

      filesystem = {
        -- Affiche le dossier courant au démarrage
        follow_current_file = {
          enabled = true,  -- surligne le fichier ouvert dans l'arbre
        },
        use_libuv_file_watcher = true, -- détecte les changements de fichiers en temps réel

        filtered_items = {
          hide_dotfiles   = false,  -- montre les fichiers cachés (.env, .gitignore...)
          hide_gitignored = false,
        },
      },
    })
  end,
}
