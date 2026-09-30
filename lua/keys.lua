-- Vimspector
vim.cmd([[
nmap <F9> <cmd>call vimspector#Launch()<cr>
nmap <F5> <cmd>call vimspector#StepOver()<cr>
nmap <F8> <cmd>call vimspector#Reset()<cr>
nmap <F11> <cmd>call vimspector#StepOver()<cr>")
nmap <F12> <cmd>call vimspector#StepOut()<cr>")
nmap <F10> <cmd>call vimspector#StepInto()<cr>")
]])

local map = vim.keymap.set

map('n', "Db", ":call vimspector#ToggleBreakpoint()<cr>")
map('n', "Dw", ":call vimspector#AddWatch()<cr>")
map('n', "De", ":call vimspector#Evaluate()<cr>")
-- FloaTerm configuration
map('n', "<leader>ft", ":FloatermNew --name=myfloat --height=0.8 --width=0.7 --autoclose=2 fish <CR> ")
map('n', "t", ":FloatermToggle myfloat<CR>")
map('t', "<Esc>", "<C-\\><C-n>:q<CR>")

-- Abrir/Cerrar Tagbar con Espacio + t
map('n', 't', function() vim.cmd("TagbarToggle") end, { desc = "Abrir/Cerrar Tagbar" })
-- Buscar todos los TODOs/FIXMEs del proyecto usando Telescope
map('n', 'ft', function() vim.cmd("TodoTelescope") end, { desc = "Buscar TODOs con Telescope" })
-- Saltar al siguiente o anterior TODO en el archivo actual
map('n', ']t', function() require("todo-comments").jump_next() end, { desc = "Siguiente TODO" })
map('n', '[t', function() require("todo-comments").jump_prev() end, { desc = "Anterior TODO" })

-- Abrir/Cerrar el panel de errores y advertencias del proyecto
map('n', 'xx', function() require("trouble").toggle("diagnostics") end, { desc = "Toggle Trouble Diagnostics" })

-- Ver solo los errores/warnings del archivo actual
map('n', 'xd', function() require("trouble").toggle("buffer_diagnostics") end, { desc = "Buffer Diagnostics" })

-- Ver los TODOs en el panel de Trouble
map('n', 'xt', function() require("trouble").toggle("todo") end, { desc = "Trouble TODOs" })

