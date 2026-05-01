-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
---@module 'lazy'
---@type LazySpec
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    -- Global shortcut to open/toggle the tree
    { '<leader>e', ':Neotree toggle<CR>', desc = 'Neo-tree [E]xplorer', silent = true },
  },
  ---@module 'neo-tree'
  ---@type neotree.Config
  opts = {
    filesystem = {
      window = {
        mappings = {
          -- Allow pressing leader-e inside the tree to close it
          ['<leader>e'] = 'close_window',

          -- Custom Tab behavior: Open file but stay in Neo-tree
          ['<tab>'] = function(state)
            local node = state.tree:get_node()
            if not node then
              return
            end
            if node.type == 'file' then
              -- Open the file but don't move the cursor
              state.commands['open'](state)
              -- Force focus back to the explorer
              vim.cmd('Neotree focus')
            else
              -- If it's a folder, just expand/collapse
              state.commands['toggle_node'](state)
            end
          end,
        },
      },
    },
  },
}
