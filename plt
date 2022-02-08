#!/usr/bin/env python3

"""Plotting utility

Read lists of numbers from stdin. 

For each list, numbers are separated by by [^0-9.\-e], and can be used for 3
distinct types of plots:

    1) --line (-l)
    2) --scatter (-s)
    3) --histogram (-t)

With options 1 and 3, the list of numbers is interpreted as a 1D array, i.e.,

    (x1, x2, ..., xn).

For 2, the format is

    (x1, y1, x2, y2, ... , xn, yn)

Lists are separated by PLT_SEPARATOR, whose default value is "&&".
"""

import argparse
import sys
import os
import re
from math import ceil, sqrt
from argparse import RawTextHelpFormatter

# env variable to control plot size:
# PLT_SIZE="w:h"
SIZE = os.getenv('PLT_SIZE')
SCATTER_SIZE = os.getenv('PLT_SCATTER_SIZE')
BINS = os.getenv('PLT_BINS')

# default SEPARATOR is &&
SEPARATOR = os.getenv('PLT_SEPARATOR')
if SEPARATOR is None or len(SEPARATOR) == 0:
    SEPARATOR = '&&'

env_variables_help  = """

environment variables:
  PLT_SIZE              size of the plot with format w:h. w and h are interpreted as cm when using a graphical output and as the number of characters in text mode
  PLT_SEPARATOR         separator for the input strem, default is &&
  PLT_SCATTER_SIZE      size of the scatter dots (graphical output only)
"""
parser = argparse.ArgumentParser(description='read floating points from stdin and plot in stdout'+env_variables_help, formatter_class=RawTextHelpFormatter)

parser.add_argument("out", nargs='?', help="optional output path, with support for the following extensions:\n  * py (matplotlib) \n  * pdf \n  * txt")
#parser.add_argument("--pdf", action='store_true', default=False, help="output pdf to stdout")
parser.add_argument("--input", '-i', metavar="FILE", type=str, help='use FILE as input instead of STDIN')
parser.add_argument("--labels", type=str, nargs='*',
                    help='labels for the colors')



group = parser.add_mutually_exclusive_group()
group.add_argument('--line', '-l',      action='store_true', help='default plot type')
group.add_argument('--scatter', '-s',   action='store_true')
group.add_argument('--histogram', '-t', action='store_true')
group.add_argument('--density', '-d', action='store_true')
args = parser.parse_args()

# file_extension==".pdf" = False

filename, file_extension = None, None

if args.out:
    filename, file_extension = os.path.splitext(args.out)

if file_extension not in [None, '.pdf', '.py', '.txt']:
    raise NotImplementedError(f"no support for file exension {file_extension}")



# vector of vectors
vv = []

str_stdin = ""

# put stdin in a string 
for line in sys.stdin:
    if 'q' == line.rstrip():
        break
    str_stdin += line

# populate vv with vector of vectors of numbers
for str_v in str_stdin.split(SEPARATOR):
    str_v = re.sub('[^0-9.\-e]', ' ', str_v)
    x = [float(s) for s in str_v.split()]
    vv.append(x)


if SIZE is not None and len(SIZE) > 0:
    size = SIZE.split(':')
    w = float(size[0])
    h = float(size[1])

if SCATTER_SIZE is not None:
    scatter_size=float(SCATTER_SIZE)
else:
    scatter_size=1

# import dependencies only if necessary
if file_extension==".pdf":
    import matplotlib
    matplotlib.use('pdf')
    import matplotlib.pyplot as plt
    cm = 1/2.54  # centimeters in inches
    if SIZE is not None and len(SIZE) > 0:
        plt.figure(figsize=(w*cm, h*cm))
    plt.rc('font', size=6) # size=8 works better with LaTeX
else:
    import misc.plotext.plot as plt

# default plot is line
if not (args.line or args.scatter or args.histogram or args.density):
    args.line = True

# make plots
for ii in range(len(vv)):
    v = vv[ii]
    label=""
    if args.labels and ii < len(args.labels):
        label = args.labels[ii]

    if args.line:
        if label != "":
            plt.plot(v, label=label)
        else:
            plt.plot(v)

    if args.scatter:
        x = [v[2*i] for i in range(len(v)//2)]
        y = [v[2*i+1] for i in range(len(v)//2) if 2*i + 1 < len(v)]
        if label == "":

            if file_extension==".pdf":
                plt.scatter(x, y, s=scatter_size)
            else:
                plt.scatter(x, y)
        else:
            if file_extension==".pdf":
                plt.scatter(x, y, label=label, s=scatter_size)
            else:
                plt.scatter(x, y, label=label)

    if args.density:
        x = [v[2*i] for i in range(len(v)//2)]
        y = [v[2*i+1] for i in range(len(v)//2) if 2*i + 1 < len(v)]
        if BINS is not None:
            bins = int(BINS)
        else:
            bins = ceil(sqrt(sqrt(len(v))))
        if label == "":
            if file_extension==".pdf":
                plt.hist2d(x, y, bins=(bins,bins))
            else:
                plt.scatter(x, y)
        else:
            if file_extension==".pdf":
                plt.hist2d(x, y, label=label, bins=(bins,bins))
            else:
                plt.scatter(x, y, label=label)

    if args.histogram:
        if BINS is not None:
            bins = int(BINS)
        else:
            bins = ceil(sqrt(len(v)))

        if label == "":
            plt.hist(v, bins=bins)
        else:
            plt.hist(v, bins=bins, label=label)


if file_extension==".pdf":
    #if args.labels:
    #    plt.legend()
    # plt.savefig(sys.stdout.buffer, bbox_inches='tight')
    plt.savefig(args.out, bbox_inches='tight')
else:
    plt.canvas_color('black')
    plt.axes_color('black')
    plt.ticks_color('white')
    if SIZE is not None and len(SIZE) > 0:
        plt.figsize(w, h)

    if file_extension == ".txt":
        plt.savefig(os.path.realpath(args.out))
    else:
        plt.show()
