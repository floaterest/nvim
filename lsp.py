import os

with open(os.path.expanduser("~/.local/state/nvim/lsp.log"), "r") as f:
    for line in f:
        if not line.startswith('[ERROR]'):
            continue
        i = line.find('"stderr"')
        s = line[i+8:].strip().removeprefix('"').removesuffix('"\n')
        print(s.encode().decode('unicode_escape'),end='')
