require('util.luasnip')
List = require('plenary/collections/py_list')

local snips = {
    main = "if __name__ == '__main__':\n\t{}",
}


return ifmts(snips)
