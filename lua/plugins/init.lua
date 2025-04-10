return {
  -- 主题
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        transparent = true,    -- 启用透明背景
        styles = {
          sidebars = "transparent",  -- 侧边栏透明
          floats = "transparent",    -- 浮动窗口透明
        },
      })
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
      require("neo-tree").setup({
        sources = {
          "filesystem",
          "buffers",
          "git_status",
          "document_symbols",
        },
        source_selector = {
          winbar = true,
          content_layout = "center",
          sources = {
            { source = "filesystem", display_name = " 文件" },
            { source = "buffers", display_name = " 缓冲区" },
            { source = "git_status", display_name = "󰊢 Git" },
            { source = "document_symbols", display_name = " 符号" },
          },
        },
        window = {
          position = "left",
          width = 30,
          mappings = {
            ["a"] = { 
              command = "add",
              config = {
                show_path = "relative" -- 显示相对路径
              }
            },  -- 新建文件/文件夹
            ["d"] = "delete",         -- 删除
            ["r"] = "rename",         -- 重命名
            ["c"] = "copy",           -- 复制
            ["m"] = "move",           -- 移动
            ["q"] = "close_window",   -- 关闭窗口
            ["R"] = "refresh",        -- 刷新
            ["?"] = "show_help",      -- 显示帮助
            ["<space>"] = { 
              "toggle_node", 
              nowait = false 
            },  -- 展开/折叠
          }
        },
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = false,    -- 不隐藏以点开头的文件
            hide_gitignored = false,  -- 不隐藏 git 忽略的文件
          },
          follow_current_file = {
            enabled = true,           -- 自动定位到当前文件
            leave_dirs_open = true,   -- 保持目录打开
          },
          use_libuv_file_watcher = true, -- 启用文件监视器
          group_empty_dirs = true,     -- 空目录分组
          hijack_netrw_behavior = "open_default", -- 接管 netrw
          window = {
            mappings = {
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["H"] = "toggle_hidden",
              ["/"] = "fuzzy_finder",
              ["D"] = "fuzzy_finder_directory",
              ["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["[g"] = "prev_git_modified",
              ["]g"] = "next_git_modified",
            },
          },
        },
        buffers = {
          follow_current_file = {
            enabled = true,          -- 自动定位到当前缓冲区
            leave_dirs_open = true,  -- 保持目录打开
          },
          group_empty_dirs = true,   -- 空目录分组
          show_unloaded = true,      -- 显示未加载的缓冲区
        },
        git_status = {
          window = {
            mappings = {
              ["A"]  = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",
              ["gg"] = "git_commit_and_push",
            },
          },
        },
      })
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

  -- 启动界面
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require('alpha')
      local dashboard = require('alpha.themes.dashboard')
      
      -- 自定义标题
      dashboard.section.header.val = {
        [[                                                    ]],
        [[                                                    ]],
        [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
        [[████╗  ██║██╔═���══╝██╔═══���█╗██║   ██║██║████╗ ████║]],
        [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
        [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
        [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
        [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        [[                                                    ]],
        [[                [ Version 1.0.0 ]                   ]],
        [[                                                    ]],
      }

      -- 自定义快捷键
      dashboard.section.buttons.val = {
        dashboard.button("n", "  新建文件", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "  查找文件", ":Telescope find_files<CR>"),
        dashboard.button("r", "  最近文件", ":Telescope oldfiles<CR>"),
        dashboard.button("t", "  查找文本", ":Telescope live_grep<CR>"),
        dashboard.button("c", "  配置文件", ":e $MYVIMRC <CR>"),
        dashboard.button("p", "  插件管理", ":Lazy<CR>"),
        dashboard.button("q", "  退出", ":qa<CR>"),
      }

      -- 自定义页脚
      local function footer()
        local total_plugins = #vim.tbl_keys(require("lazy").plugins())
        local datetime = os.date(" %Y-%m-%d   %H:%M:%S")
        return "已加载 " .. total_plugins .. " 个插件   " .. datetime
      end
      dashboard.section.footer.val = footer()

      -- 设置布局
      dashboard.config.layout = {
        { type = "padding", val = 2 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
      }

      -- 设置选项
      dashboard.config.opts.noautocmd = true

      -- 设置高亮
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"

      alpha.setup(dashboard.config)

      -- 自动启动 alpha
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          dashboard.section.footer.val = footer()
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end
  },

  -- 标签栏
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup({
        options = {
          -- 使用 nvim 内置lsp
          diagnostics = "nvim_lsp",
          -- 左侧让出 neo-tree 的位置
          offsets = {{
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left"
          }},
          -- 显示 LSP 报错图标
          diagnostics_indicator = function(count, level)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
          end,
          -- 分割符样式
          separator_style = "thin",
          -- 显示关闭按钮
          show_close_icon = true,
          -- 鼠标操作
          show_buffer_close_icons = true,
          -- 关闭按钮样式
          close_icon = '',
          -- 缓冲区图标样式
          buffer_close_icon = '',
          -- 修改图标样式
          modified_icon = '●',
          -- 左侧显示序号
          numbers = "ordinal",
          -- 持���化标签页
          persist_buffer_sort = true,
        }
      })

      -- 快捷键设置
      -- 数字快捷键（不显示在 which-key 中）
      for i = 1, 9 do
        vim.keymap.set('n', '<leader>' .. i, 
          '<Cmd>BufferLineGoToBuffer ' .. i .. '<CR>', 
          { silent = true })
      end
      
      -- 其他标签页快捷键（显示在 which-key 中）
      vim.keymap.set('n', '<leader>$', '<Cmd>BufferLineGoToBuffer -1<CR>', { desc = '切换到最后一个标签页' })
      vim.keymap.set('n', '<leader>H', '<Cmd>BufferLineMovePrev<CR>', { desc = '向左移动标签页' })
      vim.keymap.set('n', '<leader>L', '<Cmd>BufferLineMoveNext<CR>', { desc = '向右移动标签页' })
      vim.keymap.set('n', '<leader>bp', '<Cmd>BufferLinePick<CR>', { desc = '选择标签页' })
      vim.keymap.set('n', '<leader>bc', '<Cmd>BufferLinePickClose<CR>', { desc = '选择关闭标签页' })
      vim.keymap.set('n', '<leader>bse', '<Cmd>BufferLineSortByExtension<CR>', { desc = '按扩展名排序' })
      vim.keymap.set('n', '<leader>bsd', '<Cmd>BufferLineSortByDirectory<CR>', { desc = '按目录排序' })
    end,
  },

  -- ChatGPT 集成
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      -- 检查 API 密钥是否存在
      if not vim.fn.getenv('deepseek_key') then
        vim.notify('请设置环境变量 deepseek_key', vim.log.levels.WARN)
        return
      end

      -- 定义可用的模型
      local models = {
        ["deepseek-chat"] = "DeepSeek Chat",
        ["deepseek-coder"] = "DeepSeek Coder",
        ["deepseek-coder-6.7b-instruct"] = "DeepSeek Coder 6.7B",
        ["deepseek-coder-1.3b-instruct"] = "DeepSeek Coder 1.3B",
      }

      -- 创建模型选择命令
      vim.api.nvim_create_user_command('ChatGPTSelectModel', function()
        local model_names = {}
        local model_ids = {}
        for id, name in pairs(models) do
          table.insert(model_names, name)
          table.insert(model_ids, id)
        end

        vim.ui.select(model_names, {
          prompt = '选择模型：',
        }, function(choice)
          if choice then
            for i, name in ipairs(model_names) do
              if name == choice then
                vim.g.chatgpt_model = model_ids[i]
                vim.notify('已切换到模型：' .. choice)
                break
              end
            end
          end
        end)
      end, {})

      require("chatgpt").setup({
        api_key_cmd = ("echo %s"):format(vim.fn.getenv('deepseek_key')),
        openai_params = {
          model = vim.g.chatgpt_model or "deepseek-chat",  -- 使用选择的模型或默认模型
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 2000,
          temperature = 0.7,
          top_p = 1,
          n = 1,
        },
        openai_edit_params = {
          model = vim.g.chatgpt_model or "deepseek-chat",  -- 使用选择的模型或默认模型
          temperature = 0.7,
          top_p = 1,
          n = 1,
        },
        api_host_cmd = "echo https://api.deepseek.com/v1",
        api_base_url = "https://api.deepseek.com/v1",
        openai_api_base_url = "https://api.deepseek.com/v1",
        actions_paths = {},
        show_quickfixes_cmd = "Trouble quickfix",
        predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
        popup_layout = {
          default = "center",
          center = {
            width = "80%",
            height = "80%",
          },
          right = {
            width = "30%",
            width_settings_open = "50%",
          },
        },
        system_prompt = "You are a helpful AI assistant and code expert.",
      })

      -- 设置快捷键
      vim.keymap.set('n', '<leader>cc', ':ChatGPT<CR>', { desc = '打开 ChatGPT' })
      vim.keymap.set('n', '<leader>ce', ':ChatGPTEditWithInstruction<CR>', { desc = '使用 GPT 编辑' })
      vim.keymap.set('v', '<leader>ce', ':ChatGPTEditWithInstruction<CR>', { desc = '使用 GPT 编辑选中内容' })
      vim.keymap.set('n', '<leader>cg', ':ChatGPTRun grammar_correction<CR>', { desc = 'GPT 语法修正' })
      vim.keymap.set('n', '<leader>ct', ':ChatGPTRun translate<CR>', { desc = 'GPT 翻译' })
      vim.keymap.set('n', '<leader>ck', ':ChatGPTRun keywords<CR>', { desc = '提取关键词' })
      vim.keymap.set('n', '<leader>cd', ':ChatGPTRun docstring<CR>', { desc = '生成文档字符串' })
      vim.keymap.set('n', '<leader>ca', ':ChatGPTActAs<CR>', { desc = 'GPT 角色扮演' })
      vim.keymap.set('n', '<leader>cm', ':ChatGPTSelectModel<CR>', { desc = '选择 GPT 模型' })
    end,
  },
}
