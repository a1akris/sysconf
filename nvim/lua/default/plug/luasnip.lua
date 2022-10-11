local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
    vim.notify("LuaSnip not found")
    return
end

require("luasnip/loaders/from_vscode").lazy_load()

local types = require "luasnip.util.types"

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

local type_filter = function(index)
    return f(function(arg)
        local tmp = string.gsub(arg[1][1], ":(.*),", ",")
        return string.gsub(tmp, ":(.*)$", "")
    end, {index})
end

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

        s("new", fmt([[
          fn new({}) -> Self {{
              Self {{ {} }}
          }}
        ]], {
            i(1), type_filter(1)
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
