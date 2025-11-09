-- ============================================================================
--  Bootstrapping lazy.nvim
-- ============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
--  Plugins (converted from your Vim-Plug list)
-- ============================================================================
require("lazy").setup({
  -- Sensible defaults
  { "tpope/vim-sensible" },

  -- === Visuals ===
  { "morhetz/gruvbox" },
  { "nvim-lualine/lualine.nvim" },
  { "junegunn/limelight.vim" },
  { "chrisbra/colorizer" },

  -- === Editing ===
  { "preservim/nerdcommenter" },
  { "roxma/vim-paste-easy" },
  { "tpope/vim-surround" },
  { "danro/rename.vim" },

  -- === Navigation ===
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }, },
  { "christoomey/vim-tmux-navigator" },

  -- === Languages ===
  { "w0rp/ale" },
  { "neovim/nvim-lspconfig" },
  { "mfussenegger/nvim-jdtls" },
  { "hashivim/vim-terraform" },
  { "mason-org/mason.nvim" },

  -- === AI ===
  { "Exafunction/windsurf.vim", branch = "main" },
  { "dustinblackman/oatmeal.nvim", cmd = { "Oatmeal" } },

  -- === Build & Git ===
  { "tpope/vim-dispatch" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  { "mattn/webapi-vim" },
  { "mattn/gist-vim" },
})

-- ============================================================================
--  General Options
-- ============================================================================
vim.opt.encoding = "utf-8"
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd("colorscheme gruvbox")

vim.opt.wrap = false
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", eol = "¬" }
vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.g.mapleader = " "

-- Filetype-specific indentation
vim.api.nvim_create_augroup("FileTypes", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "FileTypes",
  pattern = { "markdown" },
  command = "setlocal wrap",
})
vim.api.nvim_create_autocmd("FileType", {
  group = "FileTypes",
  pattern = { "javascript", "json", "yaml" },
  command = "setlocal ts=2 sts=2 sw=2 expandtab",
})
vim.api.nvim_create_autocmd("FileType", {
  group = "FileTypes",
  pattern = { "make" },
  command = "setlocal ts=4 sts=4 sw=4 noexpandtab",
})

-- ============================================================================
--  Keymaps
-- ============================================================================
vim.keymap.set("n", "<leader><leader>", "<C-^>")
vim.keymap.set("t", "<C-[>", [[<C-\><C-n>]], { desc = "Escape terminal mode" })
vim.keymap.set("n", "<Tab>", ":bnext!<CR>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprev!<CR>", { desc = "Previous buffer", silent = true })
vim.keymap.set("n", "<leader>ev", ":e $MYVIMRC<CR>", { desc = "Edit Vim config" })
vim.keymap.set("n", "<leader>sv", ":source $MYVIMRC<CR>", { desc = "Source Vim config" })
vim.keymap.set("n", "<leader>nh", ":noh<CR>", { desc = "Clear search highlights" })
vim.keymap.set("n", "<leader>ll", ":Limelight!!<CR>", { desc = "Toggle Limelight" })
vim.keymap.set("x", "<leader>ll", ":Limelight!!<CR>", { desc = "Toggle Limelight" })
vim.keymap.set("n", "<leader>fp",
    function() require("telescope.builtin").live_grep() end,
    { desc = "Find term in files" }
)
vim.keymap.set("n", "<leader>fb",
    function() require("telescope.builtin").buffers() end,
    { desc = "Find buffers" }
)
vim.keymap.set("n", "<C-p>", function() require("telescope.builtin").find_files({
    hidden = true,
    find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
}) end, { desc = "Find files in project" })
vim.keymap.set("n", "<leader>om", ":Oatmeal<CR>", { desc = "Start Oatmeal session" })

-- ============================================================================
--  Files, Backups, and Undo
-- ============================================================================
local data_path = vim.fn.stdpath("data") .. "/tmp"
-- Ensure backup, swap, and undo directories exist
for _, dir in ipairs({ "/backup", "/swap", "/undo" }) do
  vim.fn.mkdir(data_path .. dir, "p")
end
vim.opt.backupdir = data_path .. "/backup"
vim.opt.directory = data_path .. "/swap"
vim.opt.undodir = data_path .. "/undo"
vim.opt.undofile = true

-- Wildmenu ignore patterns
vim.opt.wildmenu = true
vim.opt.wildmode = "longest,list"
vim.opt.wildignore = {
  ".hg", ".git", ".svn", "*.a", "*.o", "*.obj", "*.exe", "*.dll", "*.pyc",
  "*.bmp", "*.gif", "*.ico", "*.jpg", "*.png", ".DS_Store", "*~", "*.swp", "*.tmp"
}

-- ============================================================================
--  Load project-specific settings
-- ============================================================================
vim.o.exrc = true
vim.o.secure = true


-- ============================================================================
--  Telescope configuration
-- ============================================================================
local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-t>"] = actions.select_tab,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
        ["<C-t>"] = actions.select_tab,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
      },
    },
  },
})

-- ============================================================================
--  LuaLine configuration
-- ============================================================================
-- LSP diagnostics status for lualine
local function lsp_diagnostics_status()
  local bufnr = vim.api.nvim_get_current_buf()
  local diagnostics = vim.diagnostic.get(bufnr)

  local counts = { error = 0, warning = 0, info = 0, hint = 0 }
  for _, diag in ipairs(diagnostics) do
    if diag.severity == vim.diagnostic.severity.ERROR then
      counts.error = counts.error + 1
    elseif diag.severity == vim.diagnostic.severity.WARN then
      counts.warning = counts.warning + 1
    elseif diag.severity == vim.diagnostic.severity.INFO then
      counts.info = counts.info + 1
    elseif diag.severity == vim.diagnostic.severity.HINT then
      counts.hint = counts.hint + 1
    end
  end

  local symbols = {
    error = "✘",
    warning = "▲",
    info = "»",
    hint = "✔",
  }

  if counts.error > 0 then
    return symbols.error .. " " .. counts.error
  elseif counts.warning > 0 then
    return symbols.warning .. " " .. counts.warning
  elseif counts.info > 0 then
    return symbols.info .. " " .. counts.info
  else
    return symbols.hint
  end
end

require('lualine').setup({
  options = {
    theme = 'auto', -- or pick your preferred theme
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { { 'filename', path = 1 } },
    lualine_c = {},
    lualine_x = { lsp_diagnostics_status },
    lualine_y = { 'filetype' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { { 'filename', path = 1 } },
    lualine_c = {},
    lualine_x = { 'progress' },
    lualine_y = {},
    lualine_z = {},
  },
})

-- ============================================================================
--  ALE Configuration
-- ============================================================================
vim.g.ale_set_signs = 1
vim.g.ale_disable_lsp = 1
vim.g.ale_use_neovim_diagnostics_api = 1
vim.g.ale_fixers = {
  python = { 'ruff' },
  java = { 'google_java_format' },
  go = { 'gofmt' },
  rust = { 'rustfmt' },
  sh = { 'shfmt' },
  xml = { 'xmlformatter' },
  sql = { 'sqruff' },
}

vim.diagnostic.config({
  virtual_text = { prefix = "●" },
  signs = true,
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.INFO] = "»",
      [vim.diagnostic.severity.HINT] = "✔",
    },
  },
})

-- ============================================================================
--  LSP Configuration
-- ============================================================================
require("mason").setup()
local on_attach = require("on_attach")
local servers = { "pylsp", "jdtls", "gopls", "rust_analyzer" }
-- Define base configs (do NOT enable yet)
for _, name in ipairs(servers) do
  vim.lsp.config(name, {
    on_attach = on_attach.on_attach,
    flags = { debounce_text_changes = 150 },
  })
end
-- Enable servers after VimEnter, so .exrc can override
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    for _, name in ipairs(servers) do
      vim.lsp.enable(name)
    end
  end,
})

-- ============================================================================
--  Oatmeal configuration
-- ============================================================================
require("oatmeal").setup({
    use_default_keymaps = false,
})
