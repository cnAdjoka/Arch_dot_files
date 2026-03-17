-- ============================================================
--  lua/config/keymaps.lua — Raccourcis clavier personnalisés
-- ============================================================

-- Leader key = espace (très courant et ergonomique)
-- Doit être défini AVANT lazy.nvim
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- ── Navigation entre les splits ──────────────────────────────
map("n", "<C-h>", "<C-w>h", { desc = "Split gauche" })
map("n", "<C-j>", "<C-w>j", { desc = "Split bas" })
map("n", "<C-k>", "<C-w>k", { desc = "Split haut" })
map("n", "<C-l>", "<C-w>l", { desc = "Split droit" })

-- ── Déplacement de lignes en mode visuel ─────────────────────
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Déplacer ligne vers le bas" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Déplacer ligne vers le haut" })

-- ── Qualité de vie ───────────────────────────────────────────
map("n", "<leader>w", "<cmd>w<CR>",  { desc = "Sauvegarder" })
map("n", "<leader>q", "<cmd>q<CR>",  { desc = "Quitter" })
map("n", "<leader>x", "<cmd>x<CR>",  { desc = "Sauvegarder et quitter" })

-- Rester centré lors des recherches
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Coller sans écraser le registre
map("x", "<leader>p", '"_dP', { desc = "Coller sans écraser clipboard" })

-- ── Explorateur de fichiers (Neo-tree) ───────────────────────
map("n", "<leader>e", "<cmd>Neotree toggle<CR>",  { desc = "Toggle explorateur" })
map("n", "<leader>o", "<cmd>Neotree focus<CR>",   { desc = "Focus explorateur" })

-- ── Telescope (fuzzy finder) ─────────────────────────────────
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>",   { desc = "Chercher fichiers" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>",    { desc = "Chercher dans le texte" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>",      { desc = "Chercher buffers ouverts" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>",    { desc = "Chercher dans l'aide" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>",     { desc = "Fichiers récents" })

-- ── LSP (Language Server) ────────────────────────────────────
-- Ces keymaps sont aussi définis dans la config LSP ci-dessous,
-- mais on les liste ici pour référence
-- gd  → aller à la définition
-- gr  → voir les références
-- K   → documentation au survol
-- <leader>ca → code action
-- <leader>rn → renommer le symbole

-- ── Buffers ──────────────────────────────────────────────────
map("n", "<S-l>", "<cmd>bnext<CR>",     { desc = "Buffer suivant" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Buffer précédent" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Fermer le buffer" })

-- ── Diagnostics ──────────────────────────────────────────────
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Voir le diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev,         { desc = "Diagnostic précédent" })
map("n", "]d", vim.diagnostic.goto_next,         { desc = "Diagnostic suivant" })
