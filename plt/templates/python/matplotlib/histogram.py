import sys
import matplotlib
matplotlib.use('pdf')
from math import ceil, sqrt
import matplotlib.pyplot as plt

# format: <<ID:default_value>>
bins = <<BINS:None>>
labels = <<LABELS:None>>
h = <<HEIGHT:None>>
w = <<WIDTH:None>>
vv = <<DATA:[]>>

cm = 1/2.54  # centimeters in inches
if w is not None:
    plt.figure(figsize=(w*cm, h*cm))
plt.rc('font', size=6) # size=8 works better with LaTeX

# histogram
for ii in range(len(vv)):
    v = vv[ii]
    if bins is None:
        bins = ceil(sqrt(len(v)))
    if labels and ii < len(labels):
        label = labels[ii]
        plt.hist(v, bins=bins, label=label)
    else:
        plt.hist(v, bins=bins)

if labels:
    plt.legend(labels)
plt.savefig(sys.stdout.buffer, bbox_inches='tight')
