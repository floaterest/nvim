fu MarkdownSyntax()
    setl filetype=markdown
    setl syn=markdown
endf

" au InsertLeave,FocusLost *.* w
au BufRead *.mdx call MarkdownSyntax()

" highlight the output of `:hi`
" usage:
" :redir > file
" :hi
" (scroll to the end)
" :redir END
" open file
" :HiFile
" fu! HiFile()
"     let i = 1
"     while i <= line("$")
"         if strlen(getline(i)) > 0 && len(split(getline(i))) > 2
"             let w = split(getline(i))[0]
"             exe "syn match " . w . " /\\(" . w . "\\s\\+\\)\\@<=xxx/"
"         endif
"         let i += 1
"     endwhile
" endf

" get syntax group under curosr
fu! SynGroup()
    let l:s = synID(line("."), col("."), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endf

" command! HiFile call HiFile()
command! SynGroup call SynGroup()

