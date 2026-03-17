-- ============================================================
--  init.lua — Point d'entrée principal de ta config Neovim
--  Structure :
--    init.lua              ← ce fichier
--    lua/config/options.lua   ← options générales de vim
--    lua/config/keymaps.lua   ← tes raccourcis clavier
--    lua/plugins/            ← un fichier par plugin
-- ============================================================

-- Bootstrap lazy.nvim (gestionnaire de plugins)
-- Télécharge lazy.nvim automatiquement si absent
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Charge les options et keymaps avant les plugins
require("config.options")
require("config.keymaps")

-- Charge tous les plugins définis dans lua/plugins/
require("lazy").setup("plugins", {
  -- Options de lazy.nvim
  ui = {
    border = "rounded", -- bordure de la fenêtre de lazy
  },
  checker = {
    enabled = true,     -- vérifie les mises à jour automatiquement
    notify = false,     -- sans notification au démarrage
  },
})
