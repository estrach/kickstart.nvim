local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require('luasnip.extras')
local rep = extras.rep

ls.add_snippets("all", {
  s("hello", {
    t('print("hello world, '),
    i(1, "end of the world"),
    t('")'),
    rep(1)
  })
})

