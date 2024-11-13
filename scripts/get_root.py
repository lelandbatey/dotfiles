#!/usr/bin/env python3

import sys
import os
import stat
from os import path

# Takes a full path on the CLI;
# Print a path
#
# If input path's to a file and not a folder, limit the input path to just a folder. e.g. /home/foo/thing.txt becomes /home/foo/
# The path printed will be the first which meets these criteria:
# If there's an '@' symbol in any folder, print the longest path with an '@' symbol in it.
# If there's not a '@' symbol, then print the first ancestor with a .git folder in it
# If there's no ancestor path with a .git folder in it, return the original path
#
# /home/leland/foo@v1.2/xyz/thing/foo.pqr => /home/leland/foo@v1.2/
# /home/leland/foo@v1.2/xyz/thing/foo.pqr => /home/leland/foo@v1.2/


def main():
    inpth = sys.argv[1]

    try:
        statres = os.stat(inpth)
    except OSError:
        statres = None
    if not statres:
        print(f"# Provided file doesn't exist {inpth}", file=sys.stderr)
        print(inpth)
        sys.exit(2)
    if not stat.S_ISDIR(statres.st_mode):
        statres = path.dirname(inpth)

    currentPath = inpth

    while currentPath != "/":
        head, tail = path.split(currentPath)
        if "@" in tail:
            print(currentPath)
            return
        gitpath = path.join(currentPath, ".git")
        try:
            statres = os.stat(gitpath)
        except OSError:
            statres = None
        if statres:
            print(f"{head=} {tail=} {statres=}", file=sys.stderr)
            print(head)
            return
        currentPath = head
    print(inpth)
    return

    # iterate backwards from final index to form longest path not yet checked.
    # for idx in range(len(pieces), 0, -1):
    # ancestorPath = path.join(*pieces[:idx])
    # path.dirname
    # gitpath = path.join(ancestorPath, ".git")


if __name__ == "__main__":
    main()
