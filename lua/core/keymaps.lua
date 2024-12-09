-- Markdown specific keymaps
vim.keymap.set('n', '<leader>mp', ':MarkdownPreview<CR>', { desc = 'Markdown 预览' })
vim.keymap.set('n', '<leader>ms', ':MarkdownPreviewStop<CR>', { desc = 'Markdown 预览停止' })

-- General keymaps
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = '保存文件' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = '退出' })
vim.keymap.set('n', '<Esc>', ':noh<CR>', { desc = '清除搜索高亮' })

-- System clipboard
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { desc = '复制到系统剪贴板' })
vim.keymap.set({'n', 'v'}, '<leader>p', '"+p', { desc = '从系统剪贴板粘贴（后）' })
vim.keymap.set({'n', 'v'}, '<leader>P', '"+P', { desc = '从系统剪贴板粘贴（前）' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = '移动到左窗口' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = '移动到下窗口' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = '移动到上窗口' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = '移动到右窗口' })

-- Better indenting
vim.keymap.set('v', '<', '<gv', { desc = '减少缩进并保持选择' })
vim.keymap.set('v', '>', '>gv', { desc = '增加缩进并保持选择' })
