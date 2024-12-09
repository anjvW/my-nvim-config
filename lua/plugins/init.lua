return {
  -- 主题
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- 语法高亮
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { 
          "markdown", "markdown_inline", "lua", "vim",
          "php", "python", "go", "rust", "javascript",
          "html", "css", "json", "yaml",
          "bash", "dockerfile"
        },
        highlight = { enable = true },
        indent = { enable = true },
        auto_install = true,
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-w>",
            node_incremental = "<C-w>",
            node_decremental = "<C-S-w>",
            scope_incremental = false,
          },
        },
      })
    end,
  },

  -- LSP 支持
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "j-hui/fidget.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("fidget").setup()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "gopls",
          "rust_analyzer",
          "html",
          "intelephense"  -- PHP
        },
        automatic_installation = true,
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')

      -- 设置语言服务器
      local servers = {
        'lua_ls',
        'pyright',
        'gopls',
        'rust_analyzer',
        'html',
        'intelephense'
      }
      
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup({
          capabilities = capabilities,
        })
      end

      -- 添加 null-ls 配置
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- Prettier 格式化
          null_ls.builtins.formatting.prettier.with({
            filetypes = { "markdown", "json", "yaml", "html", "css", "javascript" },
          }),
          -- Python 格式化
          null_ls.builtins.formatting.black,  -- 代码格式化
          null_ls.builtins.formatting.isort,  -- 导入语句排序
        },
      })
    end,
  },

  -- 代码补全
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        })
      })
    end,
  },

  -- Markdown 预览
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview" },
    build = "cd app && npx --yes yarn install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    keys = {
      { "<leader>mp", ":MarkdownPreview<CR>", desc = "Markdown 预览" },
      { "<leader>ms", ":MarkdownPreviewStop<CR>", desc = "Markdown 预览停止" },
    },
  },

  -- 文件浏览器
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup()
      vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { silent = true })
    end,
  },

  -- 状态栏
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup()
    end,
  },

  -- 快捷键提示
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require("which-key").setup()
    end,
  },

  -- 自动配对
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
      require('nvim-autopairs').setup()
    end,
  },

  -- 注释
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        -- 添加额外的注释快捷键
        toggler = {
          line = '<C-/>',  -- 行注释切换
        },
        opleader = {
          line = '<C-/>',  -- 行注释操作符
        },
      })
    end,
  },

  -- 模糊查找
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local telescope = require('telescope')
      telescope.setup()
    end,
  },

  -- Git 集成
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      local keymaps = require('core.keymaps')
      require('gitsigns').setup({
        signs = {
          add          = { text = '│' },
          change       = { text = '│' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        on_attach = keymaps.setup_git_keymaps
      })
    end,
  },

  -- 缩进指示线
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  -- 多光标编辑
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy",
    config = function()
      -- 基础键位设置
      vim.g.VM_leader = '\\'  -- 设置 visual-multi 的 leader 键
      vim.g.VM_maps = {
        ['Find Under'] = '<C-n>',                 -- 开始选择当前单词
        ['Find Subword Under'] = '<C-n>',         -- 选择子单词
        ['Select All'] = '\\A',                   -- 选择所有单词
        ['Select h'] = '\\h',                     -- 向左扩展选择
        ['Select l'] = '\\l',                     -- 向右扩展选择
        ['Add Cursor Up'] = '<S-Up>',             -- 向上添加光标
        ['Add Cursor Down'] = '<S-Down>',         -- 向下添加光标
        ['Add Cursor At Pos'] = '\\\\',           -- 在当前位置添加光标
        ['Start Regex Search'] = '\\/',           -- 开始正则搜索
        ['Visual Regex'] = '\\/',                 -- 可视模式下的正则搜索
        ['Visual All'] = '\\A',                   -- 选择所有匹配项
        ['Visual Add'] = '\\a',                   -- 添加当前选择
        ['Visual Find'] = '\\f',                  -- 查找并选择
        ['Visual Cursors'] = '\\c',               -- 在每行末尾添加光标
        ['Select Cursor Up'] = '<C-Up>',          -- 向上选择
        ['Select Cursor Down'] = '<C-Down>',      -- 向下选择
        ['Undo'] = 'u',                           -- 撤销
        ['Redo'] = '<C-r>',                       -- 重做
        ['Exit'] = '<Esc>',                       -- 退出多光标模式
      }

      -- 其他设置
      vim.g.VM_theme = 'ocean'                    -- 设置主题
      vim.g.VM_highlight_matches = 'underline'    -- 匹配项显示下划线
      vim.g.VM_show_warnings = 1                  -- 显示警告信息
      vim.g.VM_silent_exit = 1                    -- 静默退出
    end,
  },
}
