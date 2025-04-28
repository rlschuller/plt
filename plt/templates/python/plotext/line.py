import sys
import plotext as plt

# format: <<ID:default_value>>
labels = <<LABELS:None>>
h = <<HEIGHT:None>>
w = <<WIDTH:None>>
vv = <<DATA:[]>>
xlim = <<XLIM:None>>
ylim = <<YLIM:None>>

for ii in range(len(vv)):
    v = vv[ii]
    label=""
    if labels and ii < len(labels):
        label = labels[ii]
        plt.plot(v, label=label)
    else:
        plt.plot(v)

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
