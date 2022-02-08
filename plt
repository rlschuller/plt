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
# BEGIN py
import sys
# END py
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

parser.add_argument("--pdf", action='store_true', default=False, help="output pdf to stdout")
parser.add_argument("--py", action='store_true', default=False, help="output py program to stdout")
parser.add_argument("--labels", type=str, nargs='*',
                    help='labels for the colors')


group = parser.add_mutually_exclusive_group()
group.add_argument('--line', '-l',      action='store_true', help='default plot type')
group.add_argument('--scatter', '-s',   action='store_true')
group.add_argument('--histogram', '-t', action='store_true')
group.add_argument('--density', '-d', action='store_true')
args = parser.parse_args()

# set up variables
str_stdin = ""

# put stdin in a string 
for line in sys.stdin:
    if 'q' == line.rstrip():
        break
    str_stdin += line

if SIZE is not None and len(SIZE) > 0:
    size = SIZE.split(':')
    w = float(size[0])
    h = float(size[1])
else:
    w = None
    h = None

if SCATTER_SIZE is not None:
    scatter_size=float(SCATTER_SIZE)
else:
    scatter_size=1

separator = SEPARATOR
labels = args.labels

if BINS is not None:
    bins = int(BINS)
else:
    bins = None

# default plot is line
if not (args.line or args.scatter or args.histogram or args.density):
    args.line = True

# vector of vectors
vv = []

# populate vv with vector of vectors of numbers
for str_v in str_stdin.split(separator):
    str_v = re.sub('[^0-9.\-e]', ' ', str_v)
    x = [float(s) for s in str_v.split()]
    vv.append(x)

# import dependencies only if necessary
if args.pdf:
    # BEGIN py
    import matplotlib
    matplotlib.use('pdf')
    import matplotlib.pyplot as plt
    cm = 1/2.54  # centimeters in inches
    if w is not None:
        plt.figure(figsize=(w*cm, h*cm))
    plt.rc('font', size=6) # size=8 works better with LaTeX

    # END py
else:
    import misc.plotext.plot as plt


# make plots

if args.line:
    # BEGIN py# line
    for ii in range(len(vv)):
        v = vv[ii]
        label=""
        if labels and ii < len(labels):
            label = labels[ii]
            plt.plot(v, label=label)
        else:
            plt.plot(v)
    # END py

if args.scatter:
    # BEGIN py# scatter
    for ii in range(len(vv)):
        v = vv[ii]
        x = [v[2*i] for i in range(len(v)//2)]
        y = [v[2*i+1] for i in range(len(v)//2) if 2*i + 1 < len(v)]
        if labels and ii < len(labels):
            label = labels[ii]
            if args.pdf:
                plt.scatter(x, y, label=label, s=scatter_size)
            # BEGIN ignore
            else:
                plt.scatter(x, y, label=label)
            # END ignore
        else:
            if args.pdf:
                plt.scatter(x, y, s=scatter_size)
            # BEGIN ignore
            else:
                plt.scatter(x, y)
            # END ignore
    # END py

if args.density:
    # BEGIN py# density
    for ii in range(len(vv)):
        v = vv[ii]
        x = [v[2*i] for i in range(len(v)//2)]
        y = [v[2*i+1] for i in range(len(v)//2) if 2*i + 1 < len(v)]
        x = [v[2*i] for i in range(len(v)//2)]
        y = [v[2*i+1] for i in range(len(v)//2) if 2*i + 1 < len(v)]
        if bins is None:
            bins = ceil(sqrt(len(v)))
        if labels and ii < len(labels):
            label = labels[ii]
            if args.pdf:
                plt.hist2d(x, y, bins=(bins,bins)) # no label suport for hist2d in matplotlib
            # BEGIN ignore
            else:
                plt.scatter(x, y, label=label)
            # END ignore
        else:
            if args.pdf:
                plt.hist2d(x, y, bins=(bins,bins))
            # BEGIN ignore
            else:
                plt.scatter(x, y)
            # END ignore
    # END py

if args.histogram:
    # BEGIN py# histogram
    for ii in range(len(vv)):
        v = vv[ii]
        if bins is None:
            bins = ceil(sqrt(len(v)))
        if labels and ii < len(labels):
            label = labels[ii]
            plt.hist(v, bins=bins, label=label)
        else:
            plt.hist(v, bins=bins)
    # END py 

if args.pdf:
    # BEGIN py
    if labels:
        plt.legend(labels)
    plt.savefig(sys.stdout.buffer, bbox_inches='tight')
    # END py

# IGNORE bellow
elif args.py:
    with open(__file__,'r') as f:
        this_program = f.read()
        out = re.sub('# IGNORE bellow(.|\n)*', '', this_program)
        out = "# END py\n"+out + "\n# BEGIN py\n"
        out = re.sub('\s+# BEGIN ignore(.|\n)*?# END ignore', '', out)

        if not args.histogram:
            out = re.sub('# BEGIN py# histogram(.|\n)*?# END py', '', out)
        if not args.scatter:
            out = re.sub('# BEGIN py# scatter(.|\n)*?# END py', '', out)
        if not args.density:
            out = re.sub('# BEGIN py# density(.|\n)*?# END py', '', out)
        if not args.line:
            out = re.sub('# BEGIN py# line(.|\n)*?# END py', '', out)

        out = re.sub('# END py(.|\n)*?# BEGIN py', '', out)
        out = re.sub('\n {4}', '\n', out)
        #out = re.sub('args.pdf', 'True', out)
        out = re.sub(' *if args.pdf:\n {4}', '', out)
        
        out = f"vv = {vv}\n" + out
        out = f"w = {w}\n" + out
        out = f"h = {h}\n" + out
        #out = f"separator = '{separator}'\n" + out
        if not args.density and labels:
            out = f"labels = {labels}\n" + out
        else:
            out = f"labels = None\n" + out

        if args.histogram:
            out = f"bins = {bins}\n" + out
        if args.scatter:
            out = f"scatter_size = {scatter_size}\n" + out
        print(out)

else:
    plt.canvas_color('black')
    plt.axes_color('black')
    plt.ticks_color('white')
    if w is not None:
        plt.figsize(w, h)
    plt.show()
