# 🚀 Ma config Neovim

## Structure
```
~/.config/nvim/
├── init.lua                    ← point d'entrée
└── lua/
    ├── config/
    │   ├── options.lua         ← options vim
    │   └── keymaps.lua         ← raccourcis clavier
    └── plugins/
        ├── colorscheme.lua     ← thème (catppuccin)
        ├── completion.lua      ← autocomplétion (nvim-cmp)
        ├── dashboard.lua       ← page d'accueil (alpha)
        ├── lsp.lua             ← language servers (mason)
        ├── neo-tree.lua        ← explorateur de fichiers
        ├── treesitter.lua      ← coloration syntaxique
        └── ui.lua              ← lualine, telescope, etc.
```

## Installation

### 1. Prérequis
```bash
# Neovim 0.9+
brew install neovim        # macOS
sudo apt install neovim    # Ubuntu

# Nerd Font (pour les icônes) → https://www.nerdfonts.com/
# Recommandé : JetBrainsMono Nerd Font ou FiraCode Nerd Font

# Outils optionnels mais recommandés
brew install ripgrep fd    # pour telescope (recherche rapide)
brew install node          # pour certains LSP (ts_ls, etc.)
```

### 2. Copier la config
```bash
# Backup de l'ancienne config si elle existe
mv ~/.config/nvim ~/.config/nvim.bak

# Copie des fichiers
cp -r nvim-config ~/.config/nvim
```

### 3. Premier lancement
```bash
nvim
```
Lazy.nvim va installer tous les plugins automatiquement.
Ensuite `:Mason` pour voir/installer des language servers supplémentaires.

## Raccourcis principaux

| Touche | Action |
|--------|--------|
| `<Space>e` | Toggle explorateur de fichiers |
| `<Space>ff` | Chercher un fichier |
| `<Space>fg` | Chercher du texte |
| `<Space>fr` | Fichiers récents |
| `Tab` / `S-Tab` | Naviguer dans la complétion |
| `CR` | Confirmer la complétion |
| `gd` | Aller à la définition |
| `K` | Documentation du symbole |
| `<Space>ca` | Code action |
| `<Space>rn` | Renommer le symbole |
| `gcc` | Commenter la ligne |

## Personnalisation rapide

- **Thème** : `lua/plugins/colorscheme.lua` → change `flavour`
- **Langages LSP** : `lua/plugins/lsp.lua` → `ensure_installed`
- **Leader key** : `lua/config/keymaps.lua` → `vim.g.mapleader`
- **Taille sidebar** : `lua/plugins/neo-tree.lua` → `width`
- **ASCII art** : `lua/plugins/dashboard.lua` → `header.val`
