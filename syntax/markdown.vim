setl wrap
setl sw=2
syn include @tex syntax/tex.vim

syn region math start="\$" end="\$" contains=@tex
syn region math start="^\$\$" end="\$\$$" contains=@tex

syn region code start="`" end="`"
syn region code start="^\s*```.*$" end="^\s*```\ze\s*$"
