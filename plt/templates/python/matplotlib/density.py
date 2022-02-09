import sys
import matplotlib
from math import ceil, sqrt
matplotlib.use('pdf')
import matplotlib.pyplot as plt

# format: <<ID:default_value>>
labels = <<LABELS:None>>
h = <<HEIGHT:None>>
w = <<WIDTH:None>>
vv = <<DATA:[]>>
bins = <<BINS:None>>

cm = 1/2.54  # centimeters in inches
if w is not None:
    plt.figure(figsize=(w*cm, h*cm))
plt.rc('font', size=6) # size=8 works better with LaTeX

# density
for ii in range(len(vv)):
    v = vv[ii]
    x = [v[2*i] for i in range(len(v)//2)]
    y = [v[2*i+1] for i in range(len(v)//2) if 2*i + 1 < len(v)]
    x = [v[2*i] for i in range(len(v)//2)]
    y = [v[2*i+1] for i in range(len(v)//2) if 2*i + 1 < len(v)]
    if bins is None:
        bins = ceil(sqrt(sqrt(len(v))))
    plt.hist2d(x, y, bins=(bins,bins)) # no label suport for hist2d in matplotlib

plt.savefig(sys.stdout.buffer, bbox_inches='tight')
