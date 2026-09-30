
require('plug')
require('keys')
require('opts')
-- Mason Setup
require("mason").setup({
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    }
})
require("mason-lspconfig").setup()

-- LSP Diagnostics Options Setup 
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- Completion Plugin Setup
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})


-- Treesitter Plugin Setup
require('nvim-treesitter.config').setup {
  ensure_installed = { "lua", "rust", "toml" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true }, -- Corregido de "ident" a "indent"
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}

local map = vim.keymap.set
-- Atajos estándar de Telescope (asumiendo que tu tecla  es el espacio)
map('n', 'ff', 'Telescope find_files', { desc = "Buscar archivos" })
map('n', 'fg', 'Telescope live_grep', { desc = "Buscar texto en archivos" })
map('n', 'fb', 'Telescope buffers', { desc = "Ver archivos abiertos" })
map('n', 'fh', 'Telescope help_tags', { desc = "Buscar en la ayuda" })

-- Carga segura de nvim-tree
local tree_ok, nvim_tree = pcall(require, "nvim-tree")
if tree_ok then
  nvim_tree.setup({
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = 30,
      side = "left",
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = false, -- Cambia a true si quieres ocultar archivos ocultos (.gitignore, etc)
    },
  })
end

-- Atajo de teclado: Espacio + e para abrir/cerrar el explorador
local map = vim.keymap.set
map('n', 'e', function () vim.cmd("NvimTreeToggle") end, { desc = "Abrir/Cerrar explorador de archivos" })

-- Carga segura de todo-comments
local todo_ok, todo_comments = pcall(require, "todo-comments")
if todo_ok then
  todo_comments.setup({
    -- Puedes dejarlo vacío para usar la configuración excelente por defecto
  })
end

-- Carga segura de Trouble
local trouble_ok, trouble = pcall(require, "trouble")
if trouble_ok then
  trouble.setup({
    -- Configuración por defecto limpia y funcional
  })
end

-- Carga segura de Catppuccin
local catppuccin_ok, catppuccin = pcall(require, "catppuccin")
if catppuccin_ok then
  catppuccin.setup({
    flavour = "mocha", -- Opciones: latte, frappe, macchiato, mocha
    transparent_background = false, -- Cambia a true si quieres el fondo transparente de tu terminal
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
      },
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      telescope = true,
      notify = true,
      mini = true,
    },
  })

  -- Aplica el esquema de colores
  vim.cmd.colorscheme("catppuccin")
end
