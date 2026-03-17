-- ============================================================
--  lua/config/options.lua — Options générales de Neovim
-- ============================================================

local opt = vim.opt

-- ── Apparence ────────────────────────────────────────────────
opt.number         = true   -- numéros de lignes absolus
opt.relativenumber = true   -- numéros relatifs (pratique pour les mouvements)
opt.cursorline     = true   -- surligne la ligne courante
opt.termguicolors  = true   -- active les vraies couleurs 24-bit
opt.signcolumn     = "yes"  -- colonne pour les signes (erreurs, git...) toujours visible
opt.scrolloff      = 8      -- garde 8 lignes de contexte en haut/bas
opt.sidescrolloff  = 8      -- idem horizontalement
opt.wrap           = false  -- pas de retour à la ligne automatique
opt.colorcolumn    = "80"   -- repère visuel à 80 caractères (à ta guise)

-- ── Indentation ──────────────────────────────────────────────
opt.tabstop        = 2      -- largeur d'une tabulation en espaces
opt.shiftwidth     = 2      -- largeur de l'indentation (>> et <<)
opt.expandtab      = true   -- convertit les tabs en espaces
opt.autoindent     = true   -- indentation automatique
opt.smartindent    = true   -- indentation intelligente selon le langage

-- ── Recherche ────────────────────────────────────────────────
opt.ignorecase     = true   -- recherche insensible à la casse...
opt.smartcase      = true   -- ...sauf si tu mets une majuscule
opt.hlsearch       = false  -- ne surligne pas tous les résultats
opt.incsearch      = true   -- recherche en direct pendant la frappe

-- ── Splits ───────────────────────────────────────────────────
opt.splitright     = true   -- nouveau split vertical → à droite
opt.splitbelow     = true   -- nouveau split horizontal → en bas

-- ── Fichiers & backup ────────────────────────────────────────
opt.swapfile       = false  -- pas de fichiers .swp encombrants
opt.backup         = false  -- pas de backup automatique
opt.undofile       = true   -- historique d'annulation persistant entre sessions
opt.undodir        = vim.fn.stdpath("data") .. "/undodir"

-- ── Performance ──────────────────────────────────────────────
opt.updatetime     = 250    -- délai avant de déclencher CursorHold (ms)
opt.timeoutlen     = 300    -- délai pour les séquences de touches (ms)

-- ── Divers ───────────────────────────────────────────────────
opt.mouse          = "a"    -- active la souris partout
opt.clipboard      = "unnamedplus"  -- partage le clipboard système
opt.completeopt    = "menu,menuone,noselect"  -- comportement de l'autocomplétion
opt.pumheight      = 10     -- hauteur max du menu d'autocomplétion
opt.showmode       = false  -- ne pas afficher -- INSERT -- (statusline le fait)
opt.fileencoding   = "utf-8"
