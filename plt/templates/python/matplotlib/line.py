import sys
import matplotlib
matplotlib.use('pdf')
import matplotlib.pyplot as plt

# format: <<ID:default_value>>
labels = <<LABELS:None>>
h = <<HEIGHT:None>>
w = <<WIDTH:None>>
vv = <<DATA:[]>>

cm = 1/2.54  # centimeters in inches
if w is not None:
    plt.figure(figsize=(w*cm, h*cm))
plt.rc('font', size=6) # size=8 works better with LaTeX

for ii in range(len(vv)):
    v = vv[ii]
    label=""
    if labels and ii < len(labels):
        label = labels[ii]
        plt.plot(v, label=label)
    else:
        plt.plot(v)

if labels:
    plt.legend(labels)

plt.savefig(sys.stdout.buffer, bbox_inches='tight')
