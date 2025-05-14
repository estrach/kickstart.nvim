-- Set the default shell to PowerShell on windows only
if vim.fn.has('win32') == 1 then
    vim.o.shell = 'powershell.exe'
end

-- Disable inline errors
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false
    }
)

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.opt.listchars:append{eol = "↵"}
vim.opt.listchars:append{trail = "~"}
vim.opt.listchars:append{tab = ">-"}
vim.opt.listchars:append{nbsp = "␣"}

-- Nvimtree setup with options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
vim.api.nvim_set_keymap('n', '<leader>f', ':NvimTreeToggle<CR>',
  { noremap = true, silent = true, desc = 'Toggle the [f]ile browser' })

-- Enable tree-sitter context
require'treesitter-context'.setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

-- Catppuccin setup
require("catppuccin").setup({
    flavour = "mocha",
    config = function()
      vim.cmd([[let &colorcolumn="80,".join(range(120,999),",")]])
    end,
})
vim.cmd.colorscheme "catppuccin"

-- Git keymaps
vim.api.nvim_set_keymap('n', '<leader>gb', ':Git blame<CR>',
  { noremap = true, silent = true, desc = 'Git [b]lame' })
vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_status, { desc = 'Search [G]it [S]status' })
vim.api.nvim_set_keymap('n', '<leader>gd', ':Gdiffsplit<CR>',
  { noremap = true, silent = true, desc = 'Git [d]iff tool' })
vim.api.nvim_set_keymap('n', '<leader>gl', ':Git log<CR>',
  { noremap = true, silent = true, desc = 'Git [l]og' })

-- Add keymap for copy current file path and line number to the global clipboard
vim.api.nvim_set_keymap('n', '<leader>k', [[<Cmd>let @* = join([expand('%'),  line(".")], ':')<CR>]],
  { desc = 'Copy filename and line number', noremap = true, silent = true })

-- Add keymap for show/hide line numbers
vim.api.nvim_set_keymap('n', '<leader>n', ':set nu!<CR>',
  { noremap = true, silent = true, desc = 'Toggle line [n]umbers' })

-- Add keymap for toggle relative line numbers
vim.api.nvim_set_keymap('n', '<leader>m', ':set relativenumber!<CR>',
  { noremap = true, silent = true, desc = 'Toggle relative line nu[m]bers' })

-- Add keymap for show/hide whitespace
vim.api.nvim_set_keymap('n', '<leader>lw', ':set list!<CR>',
  { noremap = true, silent = true, desc = 'Toggle whitespace' })

-- Add keymap for display file as syslog
vim.api.nvim_set_keymap('n', '<leader>lm', ':set filetype=messages<CR>',
  { noremap = true, silent = true, desc = 'Syslog syntax highlight' })
vim.api.nvim_command('autocmd BufRead,BufNewFile *.log set filetype=messages')

-- Add keymaps for set fold methods
vim.api.nvim_set_keymap('n', '<leader>zi', ':set foldmethod=indent<CR>',
  { noremap = true, silent = true, desc = 'Set fold method indent' })
vim.api.nvim_set_keymap('n', '<leader>zm', ':set foldmethod=manual<CR>',
  { noremap = true, silent = true, desc = 'Set fold method manual' })

-- Add doxygen keymaps
local opts = { noremap = true, silent = true, desc = 'Add doxygen comments'}
vim.api.nvim_set_keymap("n", "<Leader>dc", ":lua require('neogen').generate()<CR>", opts)

vim.api.nvim_set_keymap('n', '<leader>dl', ':ALEToggle<CR>',
  { noremap = true, silent = true, desc = 'Toggle the [l]inter' })

vim.api.nvim_set_keymap('n', '<leader>df', ':Neoformat<CR>',
  { noremap = true, silent = true, desc = 'Format the document' })

vim.api.nvim_set_keymap('n', '<leader>de', ':bufdo e!<CR>',
  { noremap = true, silent = true, desc = 'Reload all open buffers' })

vim.api.nvim_set_keymap('n', '<leader>dw', ':bufdo w!<CR>',
  { noremap = true, silent = true, desc = 'Write all open buffers' })

vim.api.nvim_set_keymap('n', '<leader>dt', ':TodoQuickFix<CR>',
  { noremap = true, silent = true, desc = 'Open todo list' })

vim.api.nvim_set_keymap('n', '<leader>j', '<c-w>s<c-w>j<c-w>J:terminal<CR>',
  { noremap = true, silent = true, desc = 'Open terminal buffer' })

vim.api.nvim_set_keymap('n', '<leader>bd', ':bd!<CR>',
  { noremap = true, silent = true, desc = 'Close current buffer' })

-- vim.api.nvim_set_keymap('n', '<leader>bn', ':e ~/sandbox/Notepad/Notepad.md<CR>',
--   { noremap = true, silent = true, desc = 'Open Notepad' })

vim.api.nvim_set_keymap('n', '<leader>lr', ':set wrap!<CR>',
  { noremap = true, silent = true, desc = 'Toggle wrap' })

_G.last_searched_line = nil
_G.find_duplicate = function(search_direction)
  local current_line = vim.fn.getline(".")
  if _G.last_searched_line and string.find(current_line, _G.last_searched_line, 1, true) then
    current_line = _G.last_searched_line
  else
    _G.last_searched_line = current_line
  end
  local lnum = vim.fn.search(current_line, search_direction)
  if lnum > 0 then
    print("Line repeat found at line: " .. lnum)
  else
    print("No line repeats found")
  end
end

function FoldCodeBlock()
  -- Get the current cursor position
  local current_line = vim.fn.line('.')

  -- Search forwards for the next "```"
  local end_line = vim.fn.search('^```$', 'n')
  if end_line == 0 then
    print("No ending marker found")
    return
  end

  -- Go to the end line and search backwards for the previous "```\\w"
  vim.fn.cursor(end_line, 0)
  local start_line = vim.fn.search('^```\\w', 'bn')
  if start_line == 0 then
    print("No starting marker found")
    return
  end

  -- Set the fold
  print("Folding lines: " .. start_line .. ", " .. end_line)
  vim.cmd(start_line .. ',' .. end_line .. 'fold')

  -- Move the cursor back to the original position
  vim.fn.cursor(current_line, 0)
end

-- Create a Vim command to call the function
vim.api.nvim_create_user_command('FoldCodeBlock', FoldCodeBlock, {})

function YankCodeBlock()
  -- Get the current cursor position
  local current_line = vim.fn.line('.')

  -- Search forwards for the next "```"
  local end_line = vim.fn.search('^```$', 'n')
  if end_line == 0 then
    print("No ending marker found")
    return
  end

  -- Go to the end line and search backwards for the previous "```\\w"
  vim.fn.cursor(end_line, 0)
  local start_line = vim.fn.search('^```\\w', 'bn')
  if start_line == 0 then
    print("No starting marker found")
    return
  end

  start_line = start_line + 1
  end_line = end_line - 1

  -- Yank the lines
  print("Yanking lines: " .. start_line .. ", " .. end_line)
  vim.cmd(start_line .. ',' .. end_line .. 'y +')

  -- Move the cursor back to the original position
  vim.fn.cursor(current_line, 0)
end

-- Create a Vim command to call the function
vim.api.nvim_create_user_command('YankCodeBlock', YankCodeBlock, {})

function VisualCodeBlock()
  -- Get the current cursor position
  local current_line = vim.fn.line('.')

  -- Search forwards for the next "```"
  local end_line = vim.fn.search('^```$', 'n')
  if end_line == 0 then
    print("No ending marker found")
    return
  end

  -- Go to the end line and search backwards for the previous "```\\w"
  vim.fn.cursor(end_line, 0)
  local start_line = vim.fn.search('^```\\w', 'bn')
  if start_line == 0 then
    print("No starting marker found")
    return
  end

  start_line = start_line + 1
  end_line = end_line - 1

  -- Select the lines
  vim.api.nvim_command('normal! ' .. start_line .. 'GV' .. end_line .. 'G')
end

-- Create a Vim command to call the function
vim.api.nvim_create_user_command('VisualCodeBlock', VisualCodeBlock, {})

-- Navigate to next/previous file
_G.GotoNextFile = function(jump)
  local full_path = vim.api.nvim_buf_get_name(0)
  local current_filename = vim.fn.fnamemodify(full_path, ":t")

  local i, t, popen = 0, {}, io.popen
  local pfile = popen('ls .')
  local j = 0
  for filename in pfile:lines() do
    i = i + 1
    t[i] = filename
    if t[i] == current_filename then
      j = i
    end
  end
  file_idx = j + jump
  if file_idx >= #t then
    file_idx = #t
  end
  if file_idx < 0 then
    file_idx = 0
  end
  vim.api.nvim_command('e ' .. t[file_idx])
end
vim.api.nvim_set_keymap('n', '[f', ':lua _G.GotoNextFile(-1)<CR>',
  { noremap = true, silent = true, desc = 'Open previous file' })
vim.api.nvim_set_keymap('n', ']f', ':lua _G.GotoNextFile(1)<CR>',
  { noremap = true, silent = true, desc = 'Open next file' })
_G.GotoFileIndex = function(index)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen('ls .')
  for filename in pfile:lines() do
    print(filename .. " " .. i .. " " .. index)
    if i == index then
      vim.api.nvim_command('e ' .. filename)
      return
    end
    i = i + 1
  end
end
vim.api.nvim_set_keymap('n', '<leader>bm', ':lua _G.GotoFileIndex(0)<CR>',
  { noremap = true, silent = true, desc = 'Open first file' })

-- Search for the current line in all files in the working directory and place
-- the results in the quick fix list
function SearchCurrentLine()
  local current_line = vim.fn.getline(".")
  local current_filename = vim.api.nvim_buf_get_name(0)
  require('telescope.builtin').live_grep{
      additional_args = function()
          return { '--sort-files' }
      end,
      default_text = current_line,

      -- Send the results to the quick fix list on close with RETURN
      attach_mappings = function(prompt_bufnr, map)
        local function send_to_qflist_and_close()
          require('telescope.actions').send_to_qflist(prompt_bufnr)
          local qflist = vim.fn.getqflist()
          print("current file path: " .. current_filename)
          local target_idx = 1
          for i, item in ipairs(qflist) do
            if item.module then
              local item_filename = vim.fn.bufname(item.bufnr)
              if item_filename:match(current_filename) then
                print("current file path: " .. current_filename .. " found file path: " .. item_filename .. " index: " .. i)
                target_idx = i
                break
              end
            end
          end
          vim.fn.setqflist({}, 'r', { items = qflist, idx = target_idx })
          vim.cmd('cclose')
          local selected_entry = require('telescope.actions.state').get_selected_entry()
          vim.cmd('e ' .. selected_entry.value)
        end
        map('i', '<CR>', send_to_qflist_and_close)
        map('n', '<CR>', send_to_qflist_and_close)
        return true
      end
  }
end
vim.api.nvim_create_user_command('SearchCurrentLine', SearchCurrentLine, {})
vim.api.nvim_set_keymap('n', '<leader>lf', ':SearchCurrentLine<CR>',
  { noremap = true, silent = true, desc = 'Next line repeat' })

-- Create a new file with the current date stamp and header this file (do this
-- only if it does not already exist, otherwise open it)
function OpenTodaysNotepad()
  vim.api.nvim_command('e ~/sandbox/Notepad/Notes/' .. os.date("%y%m%d") .. ".md")
end
vim.api.nvim_create_user_command('OpenTodaysNotepad', OpenTodaysNotepad, {})
vim.api.nvim_set_keymap('n', '<leader>bn', ':OpenTodaysNotepad<CR>',
  { noremap = true, silent = true, desc = 'Next line repeat' })

vim.api.nvim_set_keymap('n', ']r', ':lua _G.find_duplicate("W")<CR>',
  { noremap = true, silent = true, desc = 'Next line repeat' })

vim.api.nvim_set_keymap('n', '[r', ':lua _G.find_duplicate("bW")<CR>',
  { noremap = true, silent = true, desc = 'Previous line repeat' })

vim.api.nvim_set_keymap('n', ']b', ':bn<CR>',
  { noremap = true, silent = true, desc = 'Next buffer' })

vim.api.nvim_set_keymap('n', '[b', ':bp<CR>',
  { noremap = true, silent = true, desc = 'Previous buffer' })

vim.api.nvim_set_keymap('n', ']q', ':cn<CR>',
  { noremap = true, silent = true, desc = 'Next quick fix item' })

vim.api.nvim_set_keymap('n', '[q', ':cp<CR>',
  { noremap = true, silent = true, desc = 'Previous quick fix item' })

-- text and markdown specific keybindings
vim.api.nvim_create_augroup('FileTypeKeybindings', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'FileTypeKeybindings',
  pattern = {'text', 'markdown'},
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', ']w', '/^\\d\\{6\\}:\\|^\\# \\d\\{6\\}\\|^\\#\\# \\d\\{6\\}<CR>',
      { noremap = true, silent = true, desc = 'Next datestamp' })

    vim.api.nvim_buf_set_keymap(0, 'n', '[w', '?^\\d\\{6\\}:\\|^\\# \\d\\{6\\}\\|^\\#\\# \\d\\{6\\}<CR>',
      { noremap = true, silent = true, desc = 'Previous datestamp' })

    vim.api.nvim_buf_set_keymap(0, 'n', ']t', '/^\\#\\# [A-Z0-9]\\+-[0-9]\\+<CR>',
      { noremap = true, silent = true, desc = 'Next ticket' })

    vim.api.nvim_buf_set_keymap(0, 'n', '[t', '?^\\#\\# [A-Z0-9]\\+-[0-9]\\+<CR>',
      { noremap = true, silent = true, desc = 'Previous ticket' })

    vim.api.nvim_buf_set_keymap(0, 'n', ']h', '/^\\#\\+\\s<CR>',
      { noremap = true, silent = true, desc = 'Next heading' })

    vim.api.nvim_buf_set_keymap(0, 'n', '[h', '?^\\#\\+\\s<CR>',
      { noremap = true, silent = true, desc = 'Previous heading' })

    vim.api.nvim_buf_set_keymap(0, 'n', ']e', '/```$<CR>',
      { noremap = true, silent = true, desc = 'Code block end' })

    vim.api.nvim_buf_set_keymap(0, 'n', '[e', '?```\\w\\+$<CR>',
      { noremap = true, silent = true, desc = 'Code block start' })

    vim.api.nvim_buf_set_keymap(0, 'n', 'zF', ':FoldCodeBlock<CR>',
      { noremap = true, silent = true, desc = 'Fold code block' })

    vim.api.nvim_buf_set_keymap(0, 'n', 'yc', ':YankCodeBlock<CR>',
      { noremap = true, silent = true, desc = 'Yank code block' })

    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>lve', ':VisualCodeBlock<CR>',
      { noremap = true, silent = true, desc = 'Visual code block' })
  end
})

-- Function for turning off editor features
local original_filetype = ''
function TogglePlaintext()
  if vim.bo.filetype == 'none' then
    vim.bo.filetype = original_filetype
  else
    original_filetype = vim.bo.filetype
    vim.bo.filetype = 'none'
  end
end

vim.api.nvim_create_user_command('TogglePlaintext', TogglePlaintext, {})
vim.api.nvim_set_keymap('n', '<leader>ls', ':TogglePlaintext<CR>',
  { noremap = true, silent = true, desc = 'Toggle plain text' })

-- Change colorscheme
function ToggleColorScheme()
  if vim.g.colors_name == 'catppuccin-mocha' then
    vim.cmd('colorscheme catppuccin-latte')
  else
    vim.cmd('colorscheme catppuccin-mocha')
  end
end
vim.api.nvim_create_user_command('ToggleColorScheme', ToggleColorScheme, {})
vim.api.nvim_set_keymap('n', '<leader>la', ':ToggleColorScheme<CR>',
  { noremap = true, silent = true, desc = 'Toggle colorscheme' })

-- Highlight the currently selected line
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'

-- [[ Basic Keymaps ]]
local wk = require('which-key')
wk.add({
  {'<leader>c', desc = '[C]ode' },
  {'<leader>d', desc = '[D]ocument' },
  {'<leader>g', desc = '[G]it' },
  {'<leader>h', desc = 'More git' },
  {'<leader>r', desc = '[R]ename' },
  {'<leader>s', desc = '[S]earch' },
  {'<leader>w', desc = '[W]orkspace' }
})
