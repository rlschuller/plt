#!/usr/bin/env python3

"""Terminal-based plotting utility

Read a list of numbers from stdin (separated by [^0-9.\-]) and print a plot
in stdout. There are three plotting modes available:

    1) line
    2) scatter
    3) histogram

For 1 and 3, the list of numbers is interpreted as a 1D array, i.e.,

    (x1, x2, ..., xn).

For 2, the format is

    (x1, y1, x2, y2, ... , xn, yn)
"""

import argparse
import sys
import os
import re
from math import ceil, sqrt

# env variable to control plot size:
# PLT_SIZE="w:h"
SIZE = os.getenv('PLT_SIZE')

parser = argparse.ArgumentParser(description='read floating points from stdin and plot in stdout')
parser.add_argument("--pdf", action='store_true', default=False, help="output pdf to stdout")
group = parser.add_mutually_exclusive_group()
group.add_argument('--line', '-l',      action='store_true')
group.add_argument('--scatter', '-s',   action='store_true')
group.add_argument('--histogram', '-t', action='store_true')
args = parser.parse_args()

v = []

# put all numbers in v
for line in sys.stdin:
    if 'q' == line.rstrip():
        break
    line = re.sub('[^0-9.\-e]', ' ', line)
    x = [float(s) for s in line.split()]
    v = v + x


if SIZE is not None and len(SIZE) > 0:
    size = SIZE.split(':')
    w = float(size[0])
    h = float(size[1])

if args.pdf:
    import matplotlib
    matplotlib.use('pdf')
    import matplotlib.pyplot as plt
    cm = 1/2.54  # centimeters in inches
    if SIZE is not None and len(SIZE) > 0:
        plt.figure(figsize=(w*cm, h*cm))
    plt.rc('font', size=8)
else:
    import misc.plotext.plot as plt

if not (args.line or args.scatter or args.histogram):
    args.line = True

if args.line:
    plt.plot(v)

if args.scatter:
    x = [v[2*i] for i in range(len(v)//2)]
    y = [v[2*i+1] for i in range(len(v)//2) if 2*i + 1 < len(v)]
    plt.scatter(x, y)

if args.histogram:
    bins = ceil(sqrt(len(v)))
    plt.hist(v, bins)

if args.pdf:
    plt.savefig(sys.stdout.buffer, bbox_inches='tight')
else:
    if SIZE is not None and len(SIZE) > 0:
        plt.figsize(w, h)
    plt.nocolor()
    plt.show()
