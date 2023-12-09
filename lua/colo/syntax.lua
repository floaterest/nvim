-- the first-level key names don't matter
--[[ CFG for the values:

           S -> <color> | <link>
     <color> -> <fg> <bg> <decoration>
      <link> -> @<hlgroup>
  <fg>, <bg> -> [a-z]+ | . | -
<decoration> -> u | b | i | . | -

. means unset
- means NONE
--]]
return {
    plugins = {
        VirtColumn = 'dark . .', -- virt-column
    },
    ui = {
        Conceal = '- - .',
        CursorLineNr = 'lightest darker b',
        Folded = 'orange dark .',
        LineNr = 'lighter black .',
        MatchParen = 'teal darker u',
        Noise = '@Delimiter',
        NonText = 'light . .',
        Normal = 'white darkest .',
        PMenu = 'white black .',
        Title = 'yellow . .',
        Underlined = 'yellow . u',
        VertSplit = 'light black .',
        Visual = '. dark .',
    },
    git = {
        DiffAdd = 'lime - .',
        DiffChange = 'orange - .',
        -- it shows above the deleted lines
        DiffDelete = 'pink - u',
        GitSignsAdd = '@DiffAdd',
        GitSignsChange = '@DiffChange',
        GitSignsDelete = '@DiffDelete',
    },
    syntax = {
        Comment = 'gray . i',
        Constant = 'purple . .',
        Delimiter = 'gray . .',
        Directory = 'yellow . .',
        Function = 'lime . .',
        Identifier = '@Normal',
        Statement = 'pink . -',
        PreProc = '@Statement',
        Special = 'purple . .',
        Type = 'sky . -',
        StorageClass = 'pink . .',
        String = 'yellow . .',
        Tag = 'pink . .',
    },
    treesitter = {
        ['@function.builtin'] = 'sky . .',
        ['@function.macro'] = '@@function.builtin',
        ['@parameter'] = 'orange . .',
        ['@tag.delimiter'] = '@Delimiter',
        ['@tag.attribute'] = '@Type',
        ['@text.literal.block'] = 'lighter . .',
        ['@type.builtin'] = '@Type',
        ['@variable.builtin'] = '@function.builtin',
    },
    nvimtree = {
        NvimTreeFolderIcon = 'yellow . .',
        NvimTreeIndentMarker = '@IndentMarker',
        NvimTreeRootFolder = 'yellow . .',
        NvimTreeExecFile = '@Normal',
        NvimTreeGitDirty = 'sky . .',
        NvimTreeGitStaged = 'lime . .',
        NvimTreeGitMerge = 'teal . .',
        NvimTreeGitRenamed = 'teal . .',
        NvimTreeGitNew = 'orange . .',
        NvimTreeGitDeleted = '@Comment',
    },
    -- #region languages
    css = {
        cssBraces = '@Delimiter',
        cssCustomProp = '@Normal',
        cssIdentifier = 'orange . i',
        cssPseudoClassId = 'sky . i',
        cssProp = '@Normal',
        cssClassName = 'lime . i',
        cssClassNameDot = '@Delimiter',
        cssImportant = 'pink . .',
    },
    sass = {
        sassVariableAssignment = '@Delimiter',
        sassFunctionName = '@Function',
        sassProperty = '@Delimiter',
        sassMixinName = '@TSFuncBuiltin',
    },
    html = {
        htmlTag = '@Delimiter',
        htmlEndTag = '@Delimiter',
    },
    markdown = {
        markdownBold = '. . b',
        markdownItalic = '. . i',
        markdownListMarker = '@Delimiter',
    },
    -- #endregion languages
}
