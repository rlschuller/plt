import sys
import matplotlib
import matplotlib.pyplot as plt

if "<<FORMAT:pdf>>" == "pdf":
    matplotlib.use('pdf')

# format: <<ID:default_value>>
scatter_size = <<SCATTER_SIZE:1>>
labels = <<LABELS:None>>
h = <<HEIGHT:None>>
w = <<WIDTH:None>>
vv = <<DATA:[]>>
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

if xlim is not None:
    plt.xlim(xlim)

if ylim is not None:
    plt.ylim(ylim)


if labels:
    plt.legend(labels)

plt.tight_layout()
if "<<FORMAT:pdf>>" == "pdf":
    plt.savefig(sys.stdout.buffer, bbox_inches='tight', dpi=200)
else:
    dpi=200
    if resolution and not w:
        size = fig.get_size_inches().tolist()
        dpi = min([resolution[0]/(size[0]), resolution[1]/size[1]])
    plt.savefig(sys.stdout, bbox_inches='tight', dpi=dpi)
