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

    extraLuaConfig = ''
      -- ── Core options ────────────────────────────────────────────────────
      vim.opt.termguicolors = true      -- 24-bit colour within neovim only
      vim.opt.background    = "dark"
      vim.opt.number        = true      -- line numbers
      vim.opt.relativenumber = true     -- relative line numbers
      vim.opt.signcolumn    = "yes"     -- always show sign column
      vim.opt.cursorline    = true      -- highlight current line
      vim.opt.wrap          = false     -- no line wrapping
      vim.opt.scrolloff     = 8        -- keep 8 lines above/below cursor
      vim.opt.splitright    = true
      vim.opt.splitbelow    = true

      -- ── Indentation ─────────────────────────────────────────────────────
      vim.opt.expandtab   = true
      vim.opt.tabstop     = 2
      vim.opt.shiftwidth  = 2

      -- ── Search ──────────────────────────────────────────────────────────
      vim.opt.ignorecase = true
      vim.opt.smartcase  = true
      vim.opt.hlsearch   = false

      -- ── Colorscheme ─────────────────────────────────────────────────────
      -- Use habamax (built-in, ships with neovim) — does not redefine the
      -- terminal's 16 ANSI colours, so your Ghostty theme stays intact.
      vim.cmd.colorscheme("habamax")
    '';
  };
}
