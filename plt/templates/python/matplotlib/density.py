import sys
import matplotlib
from math import ceil, sqrt
import matplotlib.pyplot as plt

if "<<FORMAT:pdf>>" == "pdf":
    matplotlib.use('pdf')

# format: <<ID:default_value>>
labels = <<LABELS:None>>
h = <<HEIGHT:None>>
w = <<WIDTH:None>>
vv = <<DATA:[]>>
bins = <<BINS:None>>
resolution = <<RESOLUTION:None>>
xlim = <<XLIM:None>>
ylim = <<YLIM:None>>
dark_background = <<DARK_BACKGROUND:False>>

if dark_background:
    plt.style.use('dark_background')

cm = 1/2.54  # centimeters in inches
if w is not None:
    fig = plt.figure(figsize=(w*cm, h*cm))
elif resolution:
    fig = plt.figure(figsize=(resolution[0]/200, resolution[1]/200-.35))
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
    plt.hist2d(x, y, bins=(bins,bins), range=(xlim, ylim)) # no label suport for hist2d in matplotlib

plt.tight_layout()
if "<<FORMAT:pdf>>" == "pdf":
    plt.savefig(sys.stdout.buffer, bbox_inches='tight', dpi=200)
else:
    dpi=200
    if resolution and not w:
        size = fig.get_size_inches().tolist()
        dpi = min([resolution[0]/(size[0]), resolution[1]/size[1]])
    plt.savefig(sys.stdout, bbox_inches='tight', dpi=dpi)
