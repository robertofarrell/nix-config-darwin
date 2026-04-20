{ pkgs, ... }:

#############################################################
#
#  Neovim configuration
#
#############################################################

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      nvim-web-devicons  # file icons (requires a Nerd Font — JetBrainsMono is configured)
      nvim-tree-lua
    ];

    extraLuaConfig = ''
      -- ── Leader key ──────────────────────────────────────────────────────
      vim.g.mapleader      = " "
      vim.g.maplocalleader = " "

      -- ── Core options ────────────────────────────────────────────────────
      vim.opt.termguicolors  = true      -- 24-bit colour within neovim only
      vim.opt.background     = "dark"
      vim.opt.number         = true      -- line numbers
      vim.opt.relativenumber = true      -- relative line numbers
      vim.opt.signcolumn     = "yes"     -- always show sign column
      vim.opt.cursorline     = true      -- highlight current line
      vim.opt.wrap           = false     -- no line wrapping
      vim.opt.scrolloff      = 8         -- keep 8 lines above/below cursor
      vim.opt.splitright     = true
      vim.opt.splitbelow     = true

      -- ── Indentation ─────────────────────────────────────────────────────
      vim.opt.expandtab  = true
      vim.opt.tabstop    = 2
      vim.opt.shiftwidth = 2

      -- ── Search ──────────────────────────────────────────────────────────
      vim.opt.ignorecase = true
      vim.opt.smartcase  = true
      vim.opt.hlsearch   = false

      -- ── Colorscheme ─────────────────────────────────────────────────────
      -- habamax is built-in and does not redefine the terminal's ANSI colours.
      vim.cmd.colorscheme("habamax")

      -- ── File tree (nvim-tree) ────────────────────────────────────────────
      -- Disable netrw so nvim-tree takes over directory opening
      vim.g.loaded_netrw       = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        view = {
          width = 32,
          side  = "left",
        },
        renderer = {
          group_empty   = true,   -- collapse single-child directories
          highlight_git = true,
          icons = {
            git_placement = "after",
            show = { file = true, folder = true, folder_arrow = true, git = true },
          },
        },
        filters = {
          dotfiles = false,       -- show dotfiles by default
        },
        git = { enable = true },
        -- Close the tree automatically when opening a file
        actions = {
          open_file = { quit_on_open = false },
        },
      })

      -- <Space>e  — toggle the tree
      -- <Space>E  — reveal the current file in the tree
      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>",   { desc = "Toggle file tree" })
      vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeFindFile<CR>", { desc = "Reveal file in tree" })
    '';
  };
}
