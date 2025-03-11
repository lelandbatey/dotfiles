#!/usr/bin/env python3

import sys
import os
import stat
from os import path
import datetime

# Takes a full path on the CLI;
# Print a path
#
# If input path's to a file and not a folder, limit the input path to just a folder. e.g. /home/foo/thing.txt becomes /home/foo/
# The path printed will be the first which meets these criteria:
# If there's an '@' symbol in any folder, print the longest path with an '@' symbol in it.
# If there's not a '@' symbol, then print the first ancestor with a .git folder in it
# If there's no ancestor path with a .git folder in it, return the original path

def find_root_path(inpth: str) -> str:
    try:
        statres = os.stat(inpth)
    except OSError:
        statres = None
    if not statres:
        print(f"# Provided path doesn't exist {inpth}", file=sys.stderr)
        return inpth
    if not stat.S_ISDIR(statres.st_mode):
        statres = path.dirname(inpth)

    currentPath = inpth

    while currentPath != "/":
        head, tail = path.split(currentPath)
        gitpath = path.join(currentPath, ".git")
        try:
            statres = os.stat(gitpath)
        except OSError:
            statres = None
        if statres:
            return currentPath

        if "@" in tail:
            return currentPath
        currentPath = head
    return inpth


def main():
    with open("/tmp/getroot_call", "a") as f:
        print(" ".join([str(datetime.datetime.now())] + sys.argv), file=f)
    inpaths = sys.argv[1:]
    outpaths = [find_root_path(inpth) for inpth in inpaths]
    outpaths = sorted(set(outpaths))

    # Do a little dedup of the outpaths. Check if any paths are direct subsets of other paths. We
    # assume all paths in outpaths are normalized and absolute. Then we can check if short paths are
    # contained within each longer path.
    longFirst = sorted(outpaths, key=lambda x: -len(x))
    uniqueChildren = set()
    for idx, pth in enumerate(longFirst):
        remaining = longFirst[idx+1:]
        hasparent = False
        for maybeParent in remaining:
            if pth.startswith(maybeParent):
                hasparent = True
                break
        if not hasparent:
            uniqueChildren.add(pth)

    print(" ".join(x for x in outpaths if x in uniqueChildren))


if __name__ == "__main__":
    main()
