-- Markdown 相关快捷键
vim.keymap.set('n', '<leader>mp', ':MarkdownPreview<CR>', { desc = 'Markdown 预览' })
vim.keymap.set('n', '<leader>ms', ':MarkdownPreviewStop<CR>', { desc = 'Markdown 预览停止' })
vim.keymap.set('n', '<leader>mf', function()
  vim.lsp.buf.format({ async = true })
end, { desc = 'Markdown 格式化' })

-- 行导航（普通模式和可视模式）
vim.keymap.set({'n', 'v'}, 'gl', '$', { desc = '移动到行尾' })
vim.keymap.set({'n', 'v'}, 'gh', '0', { desc = '移动到行首' })
vim.keymap.set({'n', 'v'}, 'ge', 'G$', { desc = '移动到文件末尾的行尾' })
vim.keymap.set({'n', 'v'}, 'gg', 'gg0', { desc = '移动到文件开头的行首' })

-- 基础快捷键
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = '保存文件' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = '退出' })
vim.keymap.set('n', '<Esc>', ':noh<CR>', { desc = '清除搜索高亮' })

-- 系统剪贴板
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { desc = '复制到系统剪贴板' })
vim.keymap.set({'n', 'v'}, '<leader>p', '"+p', { desc = '从系统剪贴板粘贴（后）' })
vim.keymap.set({'n', 'v'}, '<leader>P', '"+P', { desc = '从系统剪贴板粘贴（前）' })

-- 窗口导航
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = '移动到左窗口' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = '移动到下窗口' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = '移动到上窗口' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = '移动到右窗口' })

-- 缩进优化
vim.keymap.set('v', '<', '<gv', { desc = '减少缩进并保持选择' })
vim.keymap.set('v', '>', '>gv', { desc = '增加缩进并保持选择' })

-- 插件管理
vim.keymap.set('n', '<leader>L', ':Lazy<CR>', { desc = '打开插件管理器' })

-- LSP 快捷键
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = '显示诊断信息' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = '上一个诊断' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = '下一个诊断' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = '诊断列表' })

-- LSP 缓冲区快捷键
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = '跳转到声明' }))
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = '跳转到定义' }))
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = '显示文档' }))
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = '跳转到实现' }))
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = '显示签名帮助' }))
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, vim.tbl_extend('force', opts, { desc = '添加工作区文件夹' }))
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, vim.tbl_extend('force', opts, { desc = '移除工作区文件夹' }))
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, vim.tbl_extend('force', opts, { desc = '列出工作区文件夹' }))
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, vim.tbl_extend('force', opts, { desc = '类型定义' }))
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = '重命名' }))
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = '代码操作' }))
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = '查找引用' }))
    vim.keymap.set('n', '<leader>fm', function()
      vim.lsp.buf.format { async = true }
    end, vim.tbl_extend('force', opts, { desc = '格式化代码' }))
  end,
})

-- Telescope 快捷键
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '查找文件' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '全局搜索' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '查找缓冲区' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '查找帮助' })

-- 文件树快捷键
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { silent = true, desc = '切换文件树' })

-- Git 快捷键设置函数
local function setup_git_keymaps(bufnr)
  local gs = package.loaded.gitsigns
  
  -- 导航
  vim.keymap.set('n', ']c', function()
    if vim.wo.diff then return ']c' end
    vim.schedule(function() gs.next_hunk() end)
    return '<Ignore>'
  end, { buffer = bufnr, desc = '下一个 Git 修改' })

  vim.keymap.set('n', '[c', function()
    if vim.wo.diff then return '[c' end
    vim.schedule(function() gs.prev_hunk() end)
    return '<Ignore>'
  end, { buffer = bufnr, desc = '上一个 Git 修改' })

  -- Git 操作
  vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { buffer = bufnr, desc = '暂存修改' })
  vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { buffer = bufnr, desc = '重置修改' })
  vim.keymap.set('n', '<leader>hS', gs.stage_buffer, { buffer = bufnr, desc = '暂存整个文件' })
  vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { buffer = bufnr, desc = '撤销暂存' })
  vim.keymap.set('n', '<leader>hR', gs.reset_buffer, { buffer = bufnr, desc = '重置整个文件' })
  vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr, desc = '预览修改' })
  vim.keymap.set('n', '<leader>hb', function() gs.blame_line{full=true} end, { buffer = bufnr, desc = '显示 Git blame' })
  vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame, { buffer = bufnr, desc = '切换行 blame 显示' })
  vim.keymap.set('n', '<leader>hd', gs.diffthis, { buffer = bufnr, desc = '与 HEAD 比较差异' })
  vim.keymap.set('n', '<leader>td', gs.toggle_deleted, { buffer = bufnr, desc = '切换显示已删除行' })
end

-- 缓冲区导航
vim.keymap.set('n', '<leader>bn', ':bnext<CR>', { desc = '下一个缓冲区' })
vim.keymap.set('n', '<leader>bp', ':bprevious<CR>', { desc = '上一个缓冲区' })
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = '关闭当前缓冲区' })

-- 终端相关快捷键
vim.keymap.set('n', '<leader>t', function()
  vim.cmd('split')
  vim.cmd('terminal')
  vim.cmd('startinsert')
end, { desc = '打开终端' })

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = '退出终端插入模式' })
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = '终端模式切换到左窗口' })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', { desc = '终端模式切换到下窗口' })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', { desc = '终端模式切换到上窗口' })
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = '终端模式切换到右窗口' })

-- 导出 Git 快捷键设置函数
return {
  setup_git_keymaps = setup_git_keymaps
}
