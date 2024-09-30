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
    ColorColumn = '. darker',
    LineNr = 'gray black',
    CursorLine = '-',
    CursorLineNr = 'light . b',
    Folded = 'orange dark',
    MatchParen = 'teal darker u',
    Noise = '@Delimiter',
    NonText = 'light',
    NormalFloat = 'lightest darker',
    Normal = 'lightest darkest',
    PMenu = 'white black',
    Title = 'yellow . b',
    VertSplit = 'light black',
    Visual = '. dark',
}

local git = {
    DiffAdd = 'lime -',
    DiffChange = 'orange -',
    DiffDelete = 'pink - u', -- shows above the deleted lines
    GitSignsAdd = '@DiffAdd',
    GitSignsChange = '@DiffChange',
    GitSignsDelete = '@DiffDelete',
}

local syntax = {
    Comment = 'gray . i',
    Constant = 'purple',
    Delimiter = 'gray',
    Directory = 'yellow',
    Function = 'lime',
    Identifier = '@Normal',
    Statement = 'pink',
    PreProc = '@Statement',
    Special = 'purple',
    Type = 'sky',
    StorageClass = 'pink',
    String = 'yellow',
    Tag = 'pink',
}

local treesitter = {
    ['@function.builtin'] = 'sky',
    ['@function.macro'] = '@@function.builtin',

    ['@markup.environment'] = '@Statement',
    ['@markup.heading.1.marker'] = '@Delimiter',
    ['@markup.heading.2.marker'] = '@Delimiter',
    ['@markup.heading.3.marker'] = '@Delimiter',
    ['@markup.heading.4.marker'] = '@Delimiter',
    ['@markup.heading.5.marker'] = '@Delimiter',
    ['@markup.heading.3.marker'] = '@Delimiter',
    ['@markup.heading.1'] = 'yellow . b',
    ['@markup.heading.2'] = '@@markup.heading.1',
    ['@markup.heading.3'] = 'yellow',
    ['@markup.heading.3.latex'] = '@@markup.heading.1',
    ['@markup.heading.4.latex'] = '@@markup.heading.2',
    ['@markup.math'] = '@Special',
    ['@markup.quote'] = '.',
    ['@markup.italic'] = '. . i',
    ['@markup.list'] = '@Delimiter',
    ['@markup.strong'] = '. . b',

    ['@module.latex'] = 'yellow',
    ['@module.builtin'] = '@function.builtin',
    ['@namespace'] = '@@function.builtin',
    ['@parameter'] = 'orange',
    ['@string.documentation'] = 'gray',
    ['@tag.attribute'] = '@Type',
    ['@tag.delimiter'] = '@Delimiter',

    ['@text.environment'] = '@@markup.environment',
    ['@text.literal.block'] = 'lighter',
    ['@text.math'] = '@@markup.math',
    ['@text.emphasis'] = '@@markup.italic',
    ['@text.strong'] = '@@markup.strong',
    ['@text.title.3'] = '@@markup.heading.3',
    ['@text.title.4'] = '@@markup.heading.4',
    ['@text.title.5'] = '@@markup.heading.5',
    ['@type.builtin'] = '@Type',

    ['@variable.builtin'] = '@function.builtin',
    ['@property.yaml'] = '@Statement',
}

local nvimtree = {
    NvimTreeFolderIcon = 'yellow',
    NvimTreeIndentMarker = '@IndentMarker',
    NvimTreeRootFolder = 'yellow',
    NvimTreeExecFile = '@Normal',
    NvimTreeGitDirty = 'sky',
    NvimTreeGitStaged = 'lime',
    NvimTreeGitMerge = 'teal',
    NvimTreeGitRenamed = 'teal',
    NvimTreeGitNew = 'orange',
    NvimTreeGitDeleted = '@Comment',
}

local bufferline = {
    BufferLineTabSelected = 'white . b',
    BufferLineBufferSelected = 'white darkest b',
}

return vim.tbl_extend(
    'force',
    ui,
    git,
    syntax,
    treesitter,
    nvimtree,
    bufferline
)
