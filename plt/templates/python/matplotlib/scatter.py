import sys
import matplotlib
matplotlib.use('pdf')
import matplotlib.pyplot as plt

# format: <<ID:default_value>>
scatter_size = <<SCATTER_SIZE:1>>
labels = <<LABELS:None>>
h = <<HEIGHT:None>>
w = <<WIDTH:None>>
vv = <<DATA:[]>>

cm = 1/2.54  # centimeters in inches
if w is not None:
    plt.figure(figsize=(w*cm, h*cm))
plt.rc('font', size=6) # size=8 works better with LaTeX

# scatter
for ii in range(len(vv)):
    v = vv[ii]
    x = [v[2*i] for i in range(len(v)//2)]
    y = [v[2*i+1] for i in range(len(v)//2) if 2*i + 1 < len(v)]
    if labels and ii < len(labels):
        label = labels[ii]
        plt.scatter(x, y, label=label, s=scatter_size)
    else:
        plt.scatter(x, y, s=scatter_size)

if labels:
    plt.legend(labels)
plt.savefig(sys.stdout.buffer, bbox_inches='tight')
