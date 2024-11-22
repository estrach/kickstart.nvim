local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node

local function current_date()
  return os.date("%y%m%d")
end

ls.add_snippets("all", {
  s("print_datestamp", {
    f(current_date, {}),
    t(":")
  })
})

ls.add_snippets("all", {
  s("editor_config", {
			t({"# EditorConfig is awesome: https://EditorConfig.org",
        "",
        "# top-most EditorConfig file",
        "root = true",
        "",
        "# Unix-style newlines with a newline ending every file",
        "[*]",
        "end_of_line = lf",
        "insert_final_newline = true",
        "trim_trailing_whitespace = true",
        "insert_final_newline = true",
        "",
        "# Matches multiple files with brace expansion notation",
        "# Set default charset",
        "[*.{js,py}]",
        "charset = utf-8",
        "",
        "# 4 space indentation",
        "[*.py]",
        "indent_style = space",
        "indent_size = 4",
        "",
        "# Tab indentation (no size specified)",
        "[Makefile]",
        "indent_style = tab",
        "",
        "# Indentation override for all JS under lib directory",
        "[lib/**.js]",
        "indent_style = space",
        "indent_size = 2",
        "",
        "# Matches the exact files either package.json or .travis.yml",
        "[{package.json,.travis.yml}]",
        "indent_style = space",
        "indent_size = 2"
    }),
  }),
})

ls.add_snippets("all", {
  s("syslog", {
    i(3),
    t('syslog(LOG_ERR, "[euan] %s, %s, %s, %s, %d'),
    i(1),
    t('", __DATE__, __TIME__, __FILE__, __FUNCTION__, __LINE__'),
    i(2),
    t(');'),
  }),
})
