import plotext as plt

# format: <<ID:default_value>>
scatter_size = <<SCATTER_SIZE:1>>
labels = <<LABELS:None>>
h = <<HEIGHT:None>>
w = <<WIDTH:None>>
vv = <<DATA:[]>>
xlim = <<XLIM:None>>
ylim = <<YLIM:None>>

# scatter
for ii in range(len(vv)):
    v = vv[ii]
    x = [v[2*i] for i in range(len(v)//2)]
    y = [v[2*i+1] for i in range(len(v)//2) if 2*i + 1 < len(v)]
    if labels and ii < len(labels):
        label = labels[ii]
        plt.plot(x, y, label=label)
    else:
        plt.plot(x, y)

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
