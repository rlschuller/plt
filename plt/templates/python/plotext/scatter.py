import plotext as plt

# format: <<ID:default_value>>
scatter_size = <<SCATTER_SIZE:1>>
labels = <<LABELS:None>>
h = <<HEIGHT:None>>
w = <<WIDTH:None>>
vv = <<DATA:[]>>

if w is not None:
    plt.figure(figsize=(w*cm, h*cm))

# scatter
for ii in range(len(vv)):
    v = vv[ii]
    x = [v[2*i] for i in range(len(v)//2)]
    y = [v[2*i+1] for i in range(len(v)//2) if 2*i + 1 < len(v)]
    if labels and ii < len(labels):
        label = labels[ii]
        plt.scatter(x, y, label=label)
    else:
        plt.scatter(x, y)

plt.canvas_color('black')
plt.axes_color('black')
plt.ticks_color('white')
if w is not None:
    plt.plot_size(w, h)
plt.show()
