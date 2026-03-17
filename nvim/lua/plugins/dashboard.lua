-- ============================================================
--  lua/plugins/dashboard.lua — Page d'accueil (nvim .)
--  S'affiche au démarrage sans fichier, ou avec nvim .
-- ============================================================

return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter", -- charge au démarrage de vim

  config = function()
    local alpha   = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- ── Header ASCII ──────────────────────────────────────
    -- Remplace par ton propre ASCII art si tu veux !
    -- Générateur : https://patorjk.com/software/taag/
    dashboard.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
      "                                                     ",
    }

    -- ── Boutons du menu ───────────────────────────────────
    -- Format : shortcut, text, keybind, action
    dashboard.section.buttons.val = {
      dashboard.button("f", "󰱼  Chercher un fichier",    ":Telescope find_files<CR>"),
      dashboard.button("r", "  Fichiers récents",        ":Telescope oldfiles<CR>"),
      dashboard.button("g", "  Chercher du texte",       ":Telescope live_grep<CR>"),
      dashboard.button("e", "  Nouvel explorateur",      ":Neotree toggle<CR>"),
      dashboard.button("c", "  Config Neovim",           ":e ~/.config/nvim/init.lua<CR>"),
      dashboard.button("l", "󰒲  Gestionnaire de plugins", ":Lazy<CR>"),
      dashboard.button("q", "󰅚  Quitter",                ":qa<CR>"),
    }

    -- ── Footer (stats au bas de la page) ──────────────────
    -- Affiche le nombre de plugins chargés
    local function footer()
      local stats    = require("lazy").stats()
      local ms       = math.floor(stats.startuptime)
      return "⚡ Neovim chargé en " .. ms .. "ms avec " .. stats.count .. " plugins"
    end

    dashboard.section.footer.val = footer()

    -- ── Mise en page ──────────────────────────────────────
    dashboard.config.layout = {
      { type = "padding", val = 8 },     -- espace en haut
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 2 },
      dashboard.section.footer,
    }

    alpha.setup(dashboard.config)
  end,
}
