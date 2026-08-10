return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- Подтягивает умные подсказки от LSP (Pyright, Clangd)
    "L3MON4D3/LuaSnip",     -- Движок сниппетов (без него LSP часто отказывается работать)
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-buffer",   -- Подсказки слов, которые уже есть в текущем файле
    "hrsh7th/cmp-path",     -- Подсказки путей к файлам (супер полезно для скриптов!)
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        -- Говорим Neovim использовать LuaSnip для разворачивания сниппетов
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- Листать документацию в окошке вверх
        ['<C-f>'] = cmp.mapping.scroll_docs(4),  -- Листать документацию вниз
        ['<C-Space>'] = cmp.mapping.complete(),  -- Принудительно вызвать меню
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Enter для подтверждения выбора
        ['<Tab>'] = cmp.mapping.select_next_item(),        -- Tab для листания вниз
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),      -- Shift+Tab для листания вверх
      }),
      -- Источники подсказок (порядок важен: сначала умные от LSP, потом остальные)
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
      }, {
        { name = 'buffer' },
      })
    })
  end
}
