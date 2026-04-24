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

      # Telescope — fuzzy finder
      plenary-nvim                  # required dependency
      telescope-fzf-native-nvim     # native fzf sorter for better performance
      telescope-nvim
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

      -- ── Telescope (fuzzy finder) ─────────────────────────────────────────
      local telescope = require("telescope")
      local builtin   = require("telescope.builtin")

      telescope.setup({
        extensions = {
          fzf = {
            fuzzy                   = true,
            override_generic_sorter = true,
            override_file_sorter    = true,
            case_mode               = "smart_case",
          },
        },
      })
      telescope.load_extension("fzf")

      -- Ctrl+P  — find files (git-aware: uses git ls-files when inside a repo)
      vim.keymap.set("n", "<leader>p", function()
        local ok = pcall(builtin.git_files, { show_untracked = true })
        if not ok then builtin.find_files() end
      end, { desc = "Find files" })

      -- <Space>/ — live grep across project
      vim.keymap.set("n", "<leader>/", builtin.live_grep,  { desc = "Live grep" })
      -- <Space>b — switch buffers
      vim.keymap.set("n", "<leader>b", builtin.buffers,    { desc = "Buffers" })
      -- <Space>h — search help tags
      vim.keymap.set("n", "<leader>h", builtin.help_tags,  { desc = "Help tags" })

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
