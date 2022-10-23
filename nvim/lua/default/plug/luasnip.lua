local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
    vim.notify("LuaSnip not found")
    return
end

require("luasnip/loaders/from_vscode").lazy_load()

local s = ls.s
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

ls.config.set_config {
    history = true,
    enable_autosnippets = true,
}

ls.add_snippets("rust", {
    s("fn", fmt([[
          fn {}({}) {}{{
              {}
          }}
        ]], {
        i(1, "name"), i(2),
        c(3, { t "", fmt("-> {} ", { i(1) }) }),
        i(0, "todo!()")
    })),

    s("afn", fmt([[
          async fn {}({}) {}{{
              {}
          }}
        ]], {
        i(1, "name"), i(2),
        c(3, { t "", fmt("-> {} ", { i(1) }) }),
        i(0, "todo!()")
    })),

    s("modtest", fmt([[
          #[cfg(test)]
          mod tests {{
          {}
              {}
          }}
        ]], { c(1, { t "    use super::*;", t "", }), i(0) })),
}, { key = "rust" }
)
