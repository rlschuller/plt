import sys
import plotext as plt

# format: <<ID:default_value>>
labels = <<LABELS:None>>
h = <<HEIGHT:None>>
w = <<WIDTH:None>>
vv = <<DATA:[]>>

for ii in range(len(vv)):
    v = vv[ii]
    label=""
    if labels and ii < len(labels):
        label = labels[ii]
        plt.plot(v, label=label)
    else:
        plt.plot(v)

plt.canvas_color('black')
plt.axes_color('black')
plt.ticks_color('white')
if w is not None:
    plt.plot_size(w, h)
plt.show()
