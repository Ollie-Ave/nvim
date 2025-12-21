return {
    "xiyaowong/transparent.nvim",
    config = function()
        require("transparent").setup({ -- Optional, you don't have to run setup.
          groups = {
              'Normal',
              'NormalNC',
              -- 'NormalFloat',
              'SignColumn',
              'EndOfBuffer',
              'MsgArea',
              --'FloatBorder',
              'Pmenu',
              'PmenuSel',
              'PmenuSbar',
              'PmenuThumb',
              'StatusLine',
              'StatusLineNC',
              'TabLine',
              'TabLineFill',
              'TabLineSel',
          },

          extra_groups = {
              --'NormalFloat',
              'NvimTreeNormal',
              'TelescopeNormal',
              'TelescopeBorder',
              'TelescopePromptNormal',
              'TelescopePromptBorder',
              'TelescopeResultsNormal',
              'TelescopeResultsBorder',
              'TelescopePreviewNormal',
              'TelescopePreviewBorder',
          }, -- additional groups that should be cleared
          exclude_groups = {}, -- groups you don't want to clear
        })

        vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]
    end
}
