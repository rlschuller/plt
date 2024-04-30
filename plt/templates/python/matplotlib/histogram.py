import sys
import matplotlib
import matplotlib.pyplot as plt
if "<<FORMAT:pdf>>" == "pdf":
    matplotlib.use('pdf')
else:
    plt.style.use('dark_background')
from math import ceil, sqrt

# format: <<ID:default_value>>
bins = <<BINS:None>>
labels = <<LABELS:None>>
h = <<HEIGHT:None>>
w = <<WIDTH:None>>
vv = <<DATA:[]>>
alpha = <<ALPHA:1>>
resolution = <<RESOLUTION:None>>

cm = 1/2.54  # centimeters in inches
if w is not None:
    fig = plt.figure(figsize=(w*cm, h*cm))
elif resolution:
    fig = plt.figure(figsize=(resolution[0]/200, resolution[1]/200-.35))
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

plt.tight_layout()
if "<<FORMAT:pdf>>" == "pdf":
    plt.savefig(sys.stdout.buffer, bbox_inches='tight', dpi=200)
else:
    dpi=200
    if resolution and not w:
        size = fig.get_size_inches().tolist()
        dpi = min([resolution[0]/(size[0]), resolution[1]/size[1]])
    plt.savefig(sys.stdout, bbox_inches='tight', dpi=dpi)
