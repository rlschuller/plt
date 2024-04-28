import sys
import matplotlib
if "<<FORMAT:pdf>>" == "pdf":
    matplotlib.use('pdf')
from math import ceil, sqrt
import matplotlib.pyplot as plt

# format: <<ID:default_value>>
bins = <<BINS:None>>
labels = <<LABELS:None>>
h = <<HEIGHT:None>>
w = <<WIDTH:None>>
vv = <<DATA:[]>>
alpha = <<ALPHA:1>>

cm = 1/2.54  # centimeters in inches
if w is not None:
    plt.figure(figsize=(w*cm, h*cm))
plt.rc('font', size=6) # size=8 works better with LaTeX

min_val = min([min(v) for v in vv])
max_val = max([max(v) for v in vv])

if bins is None:
    bins = ceil(sqrt(max([len(v) for v in vv])))

# histogram
for ii in range(len(vv)):
    v = vv[ii]
    if labels and ii < len(labels):
        label = labels[ii]
        plt.hist(v, bins=bins, label=label, alpha=alpha, range=(min_val, max_val))
    else:
        plt.hist(v, bins=bins, alpha=alpha, range=(min_val, max_val))

if labels:
    plt.legend(labels)
plt.savefig(sys.stdout, bbox_inches='tight', dpi=200)
