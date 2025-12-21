return {
    'nvim-telescope/telescope.nvim',
    tag = 'v0.2.0',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')

        --vim.keymap.set('n', '<leader>f', builtin.git_files, {})

        vim.keymap.set('n', '<leader>f', function()
          local ok = pcall(builtin.git_files)
          if not ok then
            builtin.find_files()
          end
        end, {})

        vim.keymap.set('n', '<leader>pa', builtin.find_files, {})
        vim.keymap.set('n', '<leader>ps', function() 
            builtin.grep_string({ search = vim.fn.input("Grep > ") });
        end)
    end
}
