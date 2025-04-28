import plotext as plt
from math import ceil, sqrt

# format: <<ID:default_value>>
bins = <<BINS:None>>
labels = <<LABELS:None>>
h = <<HEIGHT:None>>
w = <<WIDTH:None>>
vv = <<DATA:[]>>
xlim = <<XLIM:None>>
ylim = <<YLIM:None>>

min_val = min([min(v) for v in vv])
max_val = max([max(v) for v in vv])

if xlim is not None:
    min_val = xlim[0]
    max_val = xlim[1]

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

if xlim is not None:
    plt.xlim(left=xlim[0], right=xlim[1])

if ylim is not None:
    plt.ylim(lower=ylim[0], upper=ylim[1])


plt.canvas_color('black')
plt.axes_color('black')
plt.ticks_color('white')
if w is not None:
    plt.plot_size(w, h)
plt.show()
