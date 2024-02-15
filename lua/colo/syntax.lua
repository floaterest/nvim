-- the first-level key names don't matter
--[[ CFG for the values:

           S -> <color> | <link>
     <color> -> <fg> | <fg> <bg> | <color-deco>
<color-deco> -> <fg> <bg> <decoration>
<color-deco> -> <color-deco><decoration>
      <link> -> @<hlgroup>
  <fg>, <bg> -> [a-z]+ | . | -
<decoration> -> u | b | i | .

. means unset
- means NONE
--]]

local ui = {
	Conceal = "- -",
	CursorLineNr = "lightest darker b",
	Folded = "orange dark",
	LineNr = "lighter black",
	MatchParen = "teal darker u",
	ColorColumn = ". darker",
	Noise = "@Delimiter",
	NonText = "light",
	Normal = "white darkest",
	PMenu = "white black",
	Title = "yellow",
	VertSplit = "light black",
	Visual = ". dark",
}
local git = {
	DiffAdd = "lime -",
	DiffChange = "orange -",
	DiffDelete = "pink - u", -- shows above the deleted lines
	GitSignsAdd = "@DiffAdd",
	GitSignsChange = "@DiffChange",
	GitSignsDelete = "@DiffDelete",
}
local syntax = {
	Comment = "gray . i",
	Constant = "purple",
	Delimiter = "gray",
	Directory = "yellow",
	Function = "lime",
	Identifier = "@Normal",
	Statement = "pink",
	PreProc = "@Statement",
	Special = "purple",
	Type = "sky",
	StorageClass = "pink",
	String = "yellow",
	Tag = "pink",
}
local treesitter = {
	["@function.builtin"] = "sky",
	["@function.macro"] = "@@function.builtin",
	["@markup.environment"] = "@Statement",
	["@markup.heading.3"] = "yellow . bu",
	["@markup.heading.4"] = "yellow . b",
	["@markup.heading.5"] = "@Title",
	["@markup.strong"] = ". . b",
	["@module"] = "@Title",
	["@markup.math"] = "@Special",
	["@namespace"] = "@Title",
	["@parameter"] = "orange",
	["@string.documentation"] = "gray",
	["@tag.attribute"] = "@Type",
	["@tag.delimiter"] = "@Delimiter",
	["@text.literal.block"] = "lighter",
	["@type.builtin"] = "@Type",
	["@variable.builtin"] = "@function.builtin",
}
local nvimtree = {
	NvimTreeFolderIcon = "yellow",
	NvimTreeIndentMarker = "@IndentMarker",
	NvimTreeRootFolder = "yellow",
	NvimTreeExecFile = "@Normal",
	NvimTreeGitDirty = "sky",
	NvimTreeGitStaged = "lime",
	NvimTreeGitMerge = "teal",
	NvimTreeGitRenamed = "teal",
	NvimTreeGitNew = "orange",
	NvimTreeGitDeleted = "@Comment",
}
local languages = vim.tbl_flatten({
	css = {
		cssBraces = "@Delimiter",
		cssCustomProp = "@Normal",
		cssIdentifier = "orange . i",
		cssPseudoClassId = "sky . i",
		cssProp = "@Normal",
		cssClassName = "lime . i",
		cssClassNameDot = "@Delimiter",
		cssImportant = "pink",
	},
	sass = {
		sassVariableAssignment = "@Delimiter",
		sassFunctionName = "@Function",
		sassProperty = "@Delimiter",
		sassMixinName = "@TSFuncBuiltin",
	},
	html = {
		htmlTag = "@Delimiter",
		htmlEndTag = "@Delimiter",
	},
	markdown = {
		markdownBold = ". . b",
		markdownItalic = ". . i",
		markdownListMarker = "@Delimiter",
	},
})

return vim.tbl_extend("force", ui, git, syntax, treesitter, nvimtree, languages)
