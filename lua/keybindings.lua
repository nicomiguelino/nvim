local module = {}
local set_keymap = vim.api.nvim_set_keymap

local function init_tab_keymaps()
    set_keymap('n', '<leader>to', ':tabnew<CR>', {noremap = true})
    set_keymap('n', '<leader>tx', ':tabclose<CR>', {noremap = true})
    set_keymap('n', '<leader>th', ':tabprevious<CR>', {noremap = true})
    set_keymap('n', '<leader>tl', ':tabnext<CR>', {noremap = true})
    set_keymap('n', '<leader>tj', ':+tabmove<CR>', {noremap = true})
    set_keymap('n', '<leader>tk', ':-tabmove<CR>', {noremap = true})
end

function module.init()
    set_keymap('n', '<leader>w', '<C-w>', {noremap = true})
    set_keymap('n', '<leader>hn', ':nohlsearch<CR>', {noremap = true})
    init_tab_keymaps()
end

return module
