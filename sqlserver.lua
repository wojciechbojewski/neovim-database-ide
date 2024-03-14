function RunSQL()

    -- Copy active buf
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local sql = table.concat(lines, '\n')    

    -- Create sql_file 
    local sql_file = os.tmpname ()

    local file,err = io.open(sql_file,'w')
    if file then
        file:write(tostring(sql))
        file:close()
    else
        print("error:", err) -- not so hard?
    end    

    -- Run SQL by python and save to temp file
    local result_file = os.tmpname()
    os.execute("python runme.py " .. sql_file .. " " .. result_file)

    -- Show result on new file
    vim.cmd('vsplit ' .. result_file)

end

vim.api.nvim_set_keymap('n', '<F5>', ":lua RunSQL()<CR>",{})
