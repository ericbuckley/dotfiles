-- Set runtimepath
vim.opt.runtimepath:prepend("~/.vim")
vim.opt.runtimepath:append("~/.vim/after")
-- Disable unused providers (optional)
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
-- Source vimrc
vim.cmd("source ~/.vim/vimrc")


vim.call('plug#begin')
-- navigating
vim.fn['plug#']('nvim-lua/plenary.nvim')
vim.fn['plug#']('nvim-telescope/telescope.nvim')
-- languages
vim.fn['plug#']('neovim/nvim-lspconfig')
vim.fn['plug#']('mfussenegger/nvim-jdtls')
vim.call('plug#end')

-- telescope
local ok, telescope = pcall(require, 'telescope')
if not ok then return end

local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

telescope.setup{
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
      }
    },
  },
}

-- Key mappings
local builtin = require('telescope.builtin')
local mapf = function(mode, lhs, fn)
    vim.keymap.set(mode, lhs, fn, { noremap = true, silent = true })
end
local sopts = { hidden = true, no_ignore = false }

mapf('n', '<C-p>', function() builtin.find_files(sopts) end)
mapf('n', '<Leader>fp', function() builtin.live_grep(sopts) end)
mapf('n', '<Leader>fb', function() builtin.buffers() end)
-- $HOME without hidden files
mapf('n', '<Leader>ff', function()
  builtin.find_files({ cwd = vim.fn.expand('$HOME') })
end)
-- $HOME including hidden files
mapf('n', '<Leader>fd', function()
  builtin.find_files({ cwd = vim.fn.expand('$HOME'), hidden = true })
end)


-- vim-diagnostic
vim.g.ale_use_neovim_diagnostics_api = 1
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN]  = "▲",
            [vim.diagnostic.severity.INFO]  = "»",
            [vim.diagnostic.severity.HINT]  = "⚑",
        },
    },
    virtual_text = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})


-- nvim-lspconfig
-- Function that runs when an LSP attaches to a buffer
function _G.my_on_attach(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', 'gh', vim.diagnostic.open_float, opts)
end

-- Define LSP servers
local servers = { 'pylsp', 'gopls', 'rust_analyzer' }
for _, name in ipairs(servers) do
    vim.lsp.config(name, {
        on_attach = _G.my_on_attach,
        flags = { debounce_text_changes = 150 },
    })
    vim.lsp.enable(name)
end
