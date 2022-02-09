import plotext as plt
from math import ceil, sqrt

# format: <<ID:default_value>>
bins = <<BINS:None>>
labels = <<LABELS:None>>
h = <<HEIGHT:None>>
w = <<WIDTH:None>>
vv = <<DATA:[]>>

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

plt.canvas_color('black')
plt.axes_color('black')
plt.ticks_color('white')
if w is not None:
    plt.plot_size(w, h)
plt.show()
