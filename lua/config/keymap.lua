vim.g.mapleader = " "
vim.g.maplocalleader = " "
local map = vim.keymap.set

map("n", "-", "<cmd>Oil --float<CR>", { desc = "Open parent directory" }) -- oil
map("n", "_", "<cmd>Dashboard<CR>")                                       -- dashboard
map("n", "<leader>T", "<cmd>Twilight<CR>", { desc = "twilight" })         -- twilight

-- explorer
map("n", "<leader>sE", ":Telescope file_browser<CR>", { desc = "Open Explorer" })
map("n", "<leader>se", function()
    require("telescope").extensions.file_browser.file_browser({
        path = "%:p:h", cwd = vim.fn.expand("%:p:h")
    })
end, { desc = "File Browser (current file dir)" })

-- toggle relative and absolute line numbers
map("n", "<leader>N", function()
    if vim.wo.relativenumber then
        vim.wo.relativenumber = false
        vim.wo.number = true
    else
        vim.wo.relativenumber = true
    end
end, { desc = "toggle relativenumber" })

-- barbar
map("n", "<A-h>", "<cmd>bprev<CR>")
map("n", "<A-l>", "<cmd>bnext<CR>")
map("n", "<A-c>", "<cmd>BufferClose<CR>")
map("n", "<A-C>", "<cmd>BufferRestore<CR>")
map('n', '<A-H>', '<cmd>BufferMovePrevious<CR>')
map('n', '<A-L>', '<cmd>BufferMoveNext<CR>')
map('n', '<A-p>', '<cmd>BufferPick<CR>')
map('n', '<A-P>', '<cmd>BufferPickDelete<CR>')

map('n', '<A-1>', '<cmd>BufferGoto 1<CR>')
map('n', '<A-2>', '<cmd>BufferGoto 2<CR>')
map('n', '<A-3>', '<cmd>BufferGoto 3<CR>')
map('n', '<A-4>', '<cmd>BufferGoto 4<CR>')
map('n', '<A-5>', '<cmd>BufferGoto 5<CR>')
map('n', '<A-6>', '<cmd>BufferGoto 6<CR>')
map('n', '<A-7>', '<cmd>BufferGoto 7<CR>')
map('n', '<A-8>', '<cmd>BufferGoto 8<CR>')
map('n', '<A-9>', '<cmd>BufferGoto 9<CR>')
map('n', '<A-0>', '<cmd>BufferLast<CR>')

map('n', '<leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>', { desc = "Sort Buffers by Number" })
map('n', '<leader>bn', '<Cmd>BufferOrderByName<CR>', { desc = "Sort Buffers by Name" })
map('n', '<leader>bl', '<Cmd>BufferOrderByLanguage<CR>', { desc = "Sort Buffers by Language" })

-- switch windows with CTRL+<hjkl>
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- move windows with CTRL+SHIFT+<hjkl>
map("n", "<C-S-h>", "<C-w>H")
map("n", "<C-S-l>", "<C-w>L")
map("n", "<C-S-j>", "<C-w>J")
map("n", "<C-S-k>", "<C-w>K")

-- telescope keymaps
map("n", "<leader>sf", ":Telescope find_files<CR>", { desc = "[S]earch [F]iles" })
map("n", "<leader>sg", ":Telescope live_grep<CR>", { desc = "[S]earch by [G]rep" })
map("n", "<leader>sb", ":Telescope buffers<CR>", { desc = "[S]earch [B]uffers" })
map("n", "<leader>sh", ":Telescope help_tags<CR>", { desc = "[S]earch [H]elp Tags" })
map("n", "<leader>sr", ":Telescope oldfiles<CR>", { desc = "[S]earch [R]ecent" })
map("n", "<leader>sw", ":Telescope grep_string<CR>", { desc = "[S]earch Current [W]ord" })

-- obsidian keymaps
map("n", "<leader>oo", ":ObsidianQuickSwitch<CR>", { desc = "Obsidian Quick Switch" })
map("n", "<leader>of", ":ObsidianFollowLink<CR>", { desc = "Obsidian open link" })
map("n", "<leader>os", ":ObsidianSearch<CR>", { desc = "Obsidian search" })
map("n", "<leader>ol", ":ObsidianLinks<CR>", { desc = "Obsidian links in current buffer" })
map("n", "<leader>opi", ":ObsidianPasteImg<CR>", { desc = "Obsidian paste image" })

-- lazygit
map("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "lazygit" })
-- render-markdown
map("n", "<leader>rt", "<cmd>RenderMarkdown buf_toggle<CR>")
map("n", "<leader>rp", "<cmd>RenderMarkdown preview<CR>")

-- useful maps
map("n", "<leader>w", "<cmd>update<CR>")
map("n", "<leader>q", "<cmd>q<CR>")
map({ "n", "v" }, "<leader>n", ":norm")
map("n", "<leader>W", ":set wrap!<CR>", { desc = "toggle wrap" })
map("n", "<leader>S", ":%s/")
map("n", "<leader>R", ":so %<CR>")                             -- reload neovim config
map("n", "<Esc>", "<cmd>noh<CR>")                              -- clear search highlights
map('n', '<leader>vs', '<cmd>vsplit<CR> <cmd>bnext<CR>')       -- ver split + open next buffer
map("n", "<leader>f", vim.lsp.buf.format, { desc = "format" }) -- format

map("n", "H", "^")
map("n", "L", "g_")

map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-i>", "<C-i>zz")
map("n", "<C-o>", "<C-o>zz")


vim.keymap.set("n", "<leader>rr", function()
    vim.cmd("w") 
    local file = vim.fn.expand("%")
    local output = vim.fn.expand("%:r")
    vim.cmd(string.format("split | terminal g++ -std=c++20 -O2 %s -o %s && ./%s", file, output, output))
    vim.cmd("startinsert")
end, { desc = "Compile and Run C++" })


vim.keymap.set("n", "<leader>kl", "ggguG<C-o>", { noremap = true, desc = "Lowercase entire file" })
vim.keymap.set("n", "<leader>gp", function()
  vim.cmd("w") 
  local file = vim.fn.expand("%") -- get relative file path
  
  vim.cmd(string.format("split | terminal /home/asitos/!corporateMajdoori/scripts/push.sh %s", file))
  
  vim.cmd("startinsert")
end, { desc = "Push DSA to GitHub" })


vim.keymap.set('n', '<leader>cpp', function()
  local filename = vim.fn.expand('%:t:r')
  
  local func_name = string.match(filename, "^%d+_(.+)$")
  
  if not func_name then
    func_name = filename
  end

  local template = {
    "#include <bits/stdc++.h>",
    "using namespace std;",
    "",
    "class Solution {",
    "public:",
    "  int " .. func_name .. "(int n) {",
    "    int res;",
    "     ", 
    "     ",
    "     ",
    "    return res;",
    "  }",
    "};",
    "",
    "int main() {",
    "  Solution obj;",
    "  int n = 5;",
    "  cout << obj." .. func_name .. "(n);",
    "",
    "  return 0;",
    "}"
  }

  vim.api.nvim_buf_set_lines(0, 0, -1, false, template)

  vim.api.nvim_win_set_cursor(0, {8, 5})
  
  vim.cmd("startinsert")
  
end, { desc = "Inject C++ DSA Boilerplate" })

vim.keymap.set('n', '<leader>cpa', function()
  local filename = vim.fn.expand('%:t:r')
  
  local func_name = string.match(filename, "^%d+_(.+)$")
  
  if not func_name then
    func_name = filename
  end

  local template = {
    "#include <bits/stdc++.h>",
    "using namespace std;",
    "",
    "class Solution {",
    "public:",
    "  vector<int> " .. func_name .. "(vector<int>& nums) {",
    "    vector<int> res;",
    "     ", 
    "     ",
    "     ",
    "    return res;",
    "  }",
    "};",
    "",
    "int main() {",
    "  Solution obj;",
    "  vector<int> nums = {5, 4, 3, 2, 1};",
    "  vector<int> res = obj." .. func_name .. "(nums);",
    "",
    "  for (auto i : res) {",
    "    cout << i << \" \";",
    "  }",
    "  cout << endl;",
    "",
    "  return 0;",
    "}"
  }

  vim.api.nvim_buf_set_lines(0, 0, -1, false, template)

  vim.api.nvim_win_set_cursor(0, {8, 5})
  
  vim.cmd("startinsert")
  
end, { desc = "Inject C++ Array Boilerplate" })

vim.keymap.set({'n', 'v'}, 'B', '^', { noremap = true, desc = "Jump to start of line" })
vim.keymap.set({'n', 'v'}, 'W', '$', { noremap = true, desc = "Jump to end of line" })
vim.keymap.set({"n", "v"}, ";", ";", { noremap = true, desc = "Repeat latest f/t jump" })


map("n", "<leader>r", ":w<CR>:!python %<CR>", { desc = "Run current python file" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<F5>", function()
  vim.cmd("w") 
  local file = vim.fn.expand("%")
  local output = vim.fn.expand("%:r")
  vim.cmd(string.format("split | terminal g++ -std=c++20 -O2 %s -o %s && ./%s", file, output, output))
  vim.cmd("startinsert") 
end, { desc = "Compile and Run C++" })
