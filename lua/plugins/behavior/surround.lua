require('surround').setup({
    mappings_style = 'surround',
    prefix = 's',
	prompt = false,
	map_insert_mode = false,
    pairs = {
        nestable = {
			p = { '(', ')' }, b = { '[', ']' }, B = { '{', '}' },
			a = { '<', '>' }, s = { '*', '*' },
		},
        linear = {
			q = { "'", "'" }, t = { '`', '`' }, d = { '"', '"' },
			m = { '$', '$' }, M = { '$$', '$$' }
		},
    },
})
