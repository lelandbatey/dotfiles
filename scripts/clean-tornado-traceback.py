#!/usr/bin/env python3

import sys

lines = sys.stdin.readlines()

if len(lines) < 2:
    lines = '\n'.join([
        x.replace("   File", "\n   File").replace("     ",
                                                  "\n     ").replace('  During', '\n  During')
        for x in lines
    ]).split('\n')

print('\n'.join(lines), '\n')


def istornadoline(line):
    return 'tornado' in line.lower() or 'ile "<string>"' in line.lower()


goodlines = []

TORNADOLINE = "tornadoline"
LOWNOISELINE = "goodline"

curstate = TORNADOLINE

for line in lines:
    # print(line)
    if line.startswith("Traceback") or line.startswith('  During'):
        # print("othr", line)
        goodlines.append(line)
        continue
    if curstate == TORNADOLINE:
        # print("baad", line)
        if line.startswith("   File") and not istornadoline(line):
            curstate = LOWNOISELINE
            goodlines.append(line)
            continue
    if curstate == LOWNOISELINE:
        # print("good", line)
        # print(istornadoline(line), line)
        if line.startswith("   File") and istornadoline(line):
            curstate = TORNADOLINE
            continue
        goodlines.append(line)
        continue
print("\n".join(goodlines))
