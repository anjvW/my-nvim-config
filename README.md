# Neovim 配置说明

这是一个为多语言开发优化的 Neovim 配置，支持 PHP、Python、Go、Rust、JavaScript、HTML 等语言的开发。

## 重要说明

在本配置中，`<Leader>`（空格键）被设置为 Leader 键。在后续文档中：

- `<Leader>` 表示空格键
- 例如 `<Leader>ff` 表示先按空格键，再按两次 f 键
- 所有需要按 Leader 键的操作都可以用空格键代替

## 功能特性

- LSP 支持（代码补全、跳转、提示）
- 现代化主题和界面
- Markdown 实时预览
- 模糊搜索
- 文件树
- 自动补全
- 代码提示
- 代码格式化
- Git 集成
- 快捷键提示 (which-key)
- 智能括号配对
- 代码注释支持
- 缩进指示线

## 依赖要求

使用前请确保系统已安装：

- Neovim >= 0.8.0
- Git
- Node.js >= 14
- npm 或 yarn
- Python3
- ripgrep (用于全局搜索)
- 一个 Nerd Font 字体 (用于图标显示)

## 快捷键说明

### 通用操作

- `<Leader>` - Leader 键（空格键）
- `<Leader>w` - 保存文件
- `<Leader>q` - 关闭当前窗口
- `<Esc>` - 清除搜索高亮

### 导航操作

- `gl` - 移动到行尾（普通模式和可视模式）
- `gh` - 移动到行首（普通模式和可视模式）
- `ge` - 移动到文件末尾的行尾（普通模式和可视模式）
- `gg` - 移动到文件开头的行首（普通模式和可视模式）

### 剪贴板操作

- `<Leader>y` - 复制到系统剪贴板
- `<Leader>p` - 从系统剪贴板粘贴（在光标后）
- `<Leader>P` - 从系统剪贴板粘贴（在光标前）

### 文件操作

- `<Leader>e` - 打开/关闭文件树
- `<Leader>ff` - 搜索文件
- `<Leader>fg` - 全局搜索（内容搜索）
- `<Leader>fb` - 搜索打开的缓冲区
- `<Leader>fh` - 搜索帮助文档

### LSP 功能

- `gd` - 跳转到定义
- `gD` - 跳转到声明
- `gr` - 查看引用
- `gi` - 查看实现
- `K` - 查看文档
- `<Leader>fm` - 格式化代码
- `<Leader>rn` - 重命名变量/函数
- `<Leader>ca` - 代码操作菜单
- `<Leader>D` - 查看类型定义
- `[d` - 上一个诊断信息
- `]d` - 下一个诊断信息
- `<Leader>e` - 显示诊断信息
- `<Leader>q` - 显示诊断列表

### 代码编辑

- `<C-Space>` - 触发代码补全
- `<C-b>` - 补全文档向上滚动
- `<C-f>` - 补全文档向下滚动
- `<C-e>` - 关闭补全窗口
- `<CR>` - 确认补全
- 
- ### 智能选择
- 
- - `Ctrl-w` - 开始选择/扩大选区
- - `Ctrl-Shift-w` - 缩小选区
- 
- 使用方法：
- 1. 将光标放在要选择的代码上
- 2. 按 `Ctrl-w` 开始选择最小范围
- 3. 继续按 `Ctrl-w` 逐步扩大选区
- 4. 按 `Ctrl-Shift-w` 缩小选区
- 5. 基于语法树的智能选择，比普通的文本选择更准确

### Markdown 相关

- `<Leader>mp` - 打开 Markdown 预览
- `<Leader>ms` - 关闭 Markdown 预览
- `<Leader>mf` - 格式化 Markdown 文件

### 窗口操作

- `<C-h>` - 移动到左窗口
- `<C-j>` - 移动到下窗口
- `<C-k>` - 移动到上窗口
- `<C-l>` - 移动到右窗口

### 代码注释

- `gcc` - 注释/取消注释当前行
- `gc` - 在可视模式下注释/取消注释选中区域
- `Ctrl-/` - 注释/取消注释当前行（类似 VSCode）

使用方法：
1. 普通模式下，使用 `gcc` 或 `Ctrl-/` 注释/取消注释当前行
2. 可视模式下，选择多行后使用 `gc` 或 `Ctrl-/` 注释/取消注释所选行
3. 支持多种语言的注释格式，会自动识别文件类型

### Git 操作

- `]c` - 下一个 Git 修改
- `[c` - 上一个 Git 修改
- `<Leader>hs` - 暂存当前修改
- `<Leader>hr` - 重置当前修改
- `<Leader>hS` - 暂存整个文件
- `<Leader>hu` - 撤销暂存
- `<Leader>hR` - 重置整个文件
- `<Leader>hp` - 预览修改
- `<Leader>hb` - 显示 Git blame
- `<Leader>tb` - 切换行 blame 显示
- `<Leader>hd` - ��� HEAD 比较差异
- `<Leader>td` - 切换显示已删除行

### 缓冲区操作

- `<Leader>bn` - 切换到下一个缓冲区
- `<Leader>bp` - 切换到上一个缓冲区
- `<Leader>bd` - 关闭当前缓冲区

### 插件管理

- `<Leader>L` - 打开插件管理器

### 多行编辑

- `Ctrl-n` - 选择当前单词/开始多光标编辑
- `Shift-Up/Down` - 向上/向下添加光标
- `Ctrl-Up/Down` - 向上/向下选择
- `\\A` - 选择所有匹配项
- `\\a` - 添加光标到当前位置
- `\\c` - 在每行末尾添加光标
- `\\f` - 查找并选择
- `\\h` - 向左扩展选择
- `\\l` - 向右扩展选择
- `Esc` - 退出多光标模式

使用方法：
1. 使用 `Ctrl-n` 选择一个单词
2. 继续按 `Ctrl-n` 选择下一个相同的单词
3. 或使用 `Shift-Up/Down` 在上下方向添加光标
4. 使用 `\\A` 选择所有匹配项
5. 直接编辑，所有选中的位置会同时改变

### 终端操作

- `<Leader>t` - 在底部打开终端
- `<Esc>` - 退出终端插入模式（回到终端普通模式）
- `i` 或 `a` - 在终端普通模式下进入插入模式
- `<C-h/j/k/l>` - 从终端窗口切换到其他窗口

使用说明：
1. 按 `<Leader>t` 打开终端
2. 终端默认处于插入模式，可以直接输入命令
3. 按 `<Esc>` 可以退出插入模式进入终端普通模��
4. 在普通模式下可以使用 Vim 的普通操作（如复制粘贴）
5. 使用 `<C-hjkl>` 可以在终端和其他窗口间切换

### 文件树操作

基础操作：
- `<Leader>e` - 打开/关闭文件树
- `a` - 新建文件/文件夹
  - 输入文件名直接创建文件
  - 输入路径以 `/` 结尾创建文件夹
  - 支持创建多级目录，如 `folder1/folder2/file.txt`
- `d` - 删除文件/文件夹
- `r` - 重命名
- `c` - 复制到其他位置
- `m` - 移动到其他位置
- `R` - 刷新文件树
- `?` - 显示帮助文档
- `空格` - 展开/折叠目录
- `q` - 关闭文件树

高级功能：
- `<bs>` - 返回上级目录
- `.` - 设置根目录
- `H` - 切换隐藏文件显示
- `/` - 模糊查找文件
- `D` - 模糊查找目录
- `f` - 应用过滤器
- `<c-x>` - 清除过滤器
- `[g` - 上一个 Git 修改
- `]g` - 下一个 Git 修改

Git 操作：
- `A` - 暂存所有文件
- `gu` - 取消暂存文件
- `ga` - 暂存文件
- `gr` - 还原文件修改
- `gc` - 提交更改
- `gp` - 推送到远程
- `gg` - 提交并推送

多视图支持：
- 文件树视图 - 浏览和管理文件系统
- 缓冲区视图 - 管理打开的文件
- Git 状态视图 - 查看和管理 Git 变更
- 文档符号视图 - 浏览文件结构

使用技巧：
1. 创建文件时支持路径补全，按 `Tab` 键可以补全路径
2. 可以使用 `v` 进入可视模式选择多个文件，然后进行批量操作
3. 创建多级目录时会自动创建所有必要的父目录
4. 文件树会自动跟随当前编辑的文件定位
5. 空目录会自动分组显示
6. 支持文件监视，自动刷新变更
7. 可以在不同视图间快速切换
8. Git 集成让你可以直接在文件树中进行版本控制操作

### 启动界面操作

- `n` - 新建文件
- `f` - 查找文件
- `r` - 打开最近文件
- `t` - 查找文本
- `c` - 打开配置文件
- `p` - 打开插件管理
- `q` - 退出 Neovim

启动界面会显示：
- 美观的 NEOVIM Logo
- 常用操作快捷键
- 已加载的插件数量
- 当前时间

### 标签页操作

- `<Leader>1-9` - 切换到第 1-9 个标签页
- `<Leader>$` - 切换到最后一个标签页
- `<Leader>H` - 向左移动标签页
- `<Leader>L` - 向右移动标签页
- `<Leader>bp` - 选择标签页
- `<Leader>bc` - 选择要关闭的标签页
- `<Leader>bse` - 按文件扩展名排序标签页
- `<Leader>bsd` - 按目录排序标签页

使用说明：
1. 标签页会显示在顶部，包含文件名和图标
2. 鼠标悬停可以预览文件内容
3. 点击标签页可以切换文件
4. 点击标签页上的 x 可以关闭文件
5. 标签页上会显示 LSP 诊断信息

## LSP 支持的语言

- PHP (intelephense)
- Python (pyright)
- Go (gopls)
- Rust (rust-analyzer)
- HTML
- Lua

## 插件列表

- lazy.nvim - 包管理器
- nvim-lspconfig - LSP 配置
- mason.nvim - LSP 安装管理
- nvim-cmp - 代码补全
- telescope.nvim - 模糊搜索
- neo-tree.nvim - 文件树
- markdown-preview.nvim - Markdown 预览
- none-ls.nvim - 格式化支持
- gitsigns.nvim - Git 集成
- nvim-treesitter - 语法高亮
- tokyonight.nvim - 主题
- lualine.nvim - 状态栏
- indent-blankline.nvim - 缩进指示线
- nvim-autopairs - 自动括号配对
- Comment.nvim - 代码注释
- which-key.nvim - 快捷键提示

## 自定义配置

如需自定义配置，可以修改以下文件：

- `init.lua` - 主配置文件
- `lua/plugins/init.lua` - 插件配置
- `lua/core/keymaps.lua` - 快捷键配置

## 问题排查

如果遇到问题：

1. 运行 `:checkhealth` 检查环境
2. 确保所有依赖都已正确安装
3. 检查 LSP 服务器是否正确安装（`:Mason`）
4. 查看日志（`:messages`）

## 更新

更新插件：

1. 打开 Neovim
2. 按 `<Leader>L` 打开插件管理器
3. 按 `U` 更新所有插件

## 格式化支持

通过 prettier 支持以下文件类型的格式化：

- Markdown
- JSON
- YAML
- HTML
- CSS
- JavaScript

通过 black 支持：
- Python

### ChatGPT 集成

基础操作：
- `<Leader>cc` - 打开 ChatGPT 对话窗口
- `<Leader>ce` - 使用 GPT 编辑当前文本
- `<Leader>cg` - GPT 语法修正
- `<Leader>ct` - GPT 翻译
- `<Leader>ck` - 提取关键词
- `<Leader>cd` - 生成文档字符串
- `<Leader>ca` - GPT 角色扮演
- `<Leader>cm` - 选择 GPT 模型

可用模型：
- DeepSeek Chat - 通用对话模型
- DeepSeek Coder - 代码专用模型
- DeepSeek Coder 6.7B - 大型代码模型
- DeepSeek Coder 1.3B - 轻量级代码模型

使用说明：
1. 需要设置环境变量 `deepseek_key`（DeepSeek API 密钥）
2. 使用 `<Leader>cm` 可以随时切换不同的模型
3. 支持对话模式和编辑模式
4. 可以选中文本后使用 GPT 进行编辑
5. 支持多种预设任务（翻译、语法修正等）
6. 支持自定义 GPT 角色扮演提示词

注意事项：
1. 使用前请确保有可用的 DeepSeek API 密钥
2. API 调用会产生费用，请注意使用频率
3. 建议使用代理以提高连接稳定性
4. 不同模型有不同的特点，可以根据需求选择
   - Chat 模型适合通用对话
   - Coder 模型更适合代码相关任务
