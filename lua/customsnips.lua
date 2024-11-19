local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node

local function current_date()
  return os.date("%y%m%d")
end

ls.add_snippets("all", {
  s("print_datestamp", {
    f(current_date, {}),
    t(":")
  })
})
