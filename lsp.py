import os, re

with open(os.path.expanduser("~/.local/state/nvim/lsp.log"), "r") as f:
    for line in f:
        if not line.startswith('[ERROR]'):
            continue
        line = re.sub(r'.+"stderr"\s+["\']', '', line)
        line = re.sub(r'["\']$', '', line).strip()
        print(line.encode().decode('unicode_escape'), end='')
