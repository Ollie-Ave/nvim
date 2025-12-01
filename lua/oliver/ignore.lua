local old_deprecate = vim.deprecate

vim.deprecate = function(name, replacement, version, plugin)
    if name == "vim.tbl_islist()" then
        return
    end
    old_deprecate(name, replacement, version, plugin)
end

