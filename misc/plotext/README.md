![example](https://raw.githubusercontent.com/piccolomo/plotext/master/images/logo.png)

`plotext` plots directly on terminal, it has no dependencies and the syntax is very similar to `matplotlib`. 

<a name="contents"></a>
## Table of Contents
- [ Installation ](https://github.com/piccolomo/plotext#installation)
- [ Scatter Plot ](https://github.com/piccolomo/plotext#scatter-plot)
- [ Line Plot ](https://github.com/piccolomo/plotext#line-plot)
- [ Histogram Plot ](https://github.com/piccolomo/plotext#histogram-plot)
- [ Multiple Plots ](https://github.com/piccolomo/plotext#multiple-data)
- [ Plot Limits ](https://github.com/piccolomo/plotext#plot-limits)
- [ Data Ticks ](https://github.com/piccolomo/plotext#data-ticks)
- [ Plot Aspect ](https://github.com/piccolomo/plotext#plot-aspect)
- [ Streaming Data ](https://github.com/piccolomo/plotext#streaming-data)
- [ Other Functions ](https://github.com/piccolomo/plotext#other-functions)
- [ Main Updates ](https://github.com/piccolomo/plotext#main-updates)
- [ Future Plans ](https://github.com/piccolomo/plotext#future-plans)


<a name="install"></a>
## Installation
In windows use:
```
pip install plotext --upgrade
```
and in Linux, it is recommended:
```
sudo -H pip install plotext --upgrade
```


<a name="scatter"></a>
# Scatter Plot
Here is a basic example of a scatter plot:
```
import plotext as plt
y = [1, 5, 3, 8, 4, 9, 0, 5]
plt.scatter(y)
plt.show()
```
which prints this on terminal:
![example](https://raw.githubusercontent.com/piccolomo/plotext/master/images/scatter.png)

Note that you could also pass both the `x` and `y` coordinates to the `scatter` function using `plt.scatter(x, y)`.

[ Table of Contents ](https://github.com/piccolomo/plotext#table-of-contents)


<a name="plot"></a>
# Line Plot
For a line plot use the the `plot` function instead:
```
import plotext as plt
y = [1, 5, 3, 8, 4, 9, 0, 5]
plt.plot(y)
plt.show()
```
![example](https://raw.githubusercontent.com/piccolomo/plotext/master/images/plot.png)

Note that you could also pass both the `x` and `y` coordinates to the `plot` function using `plt.plot(x, y)`.

[ Table of Contents ](https://github.com/piccolomo/plotext#table-of-contents)


<a name="multiple"></a>
# Multiple Data
Multiple data sets can be plotted using consecutive `scatter` or `plot` functions. Here is a basic example:
```
import plotext as plt
y = [1, 5, 3, 8, 4, 9, 0, 5]
plt.plot(y, label = "lines")
plt.scatter(y, label = "points", point_color = "red")
plt.show()
```

![example](https://raw.githubusercontent.com/piccolomo/plotext/master/images/multiple.png)

 - Using the `label` parameter inside the plotting calls, a legend is automatically added in the upper left corner of the plot.
 - The function `plt.legend()` provides an alternative way to set all the plot labels. Here is an equivalent version of the previous example:

```
import plotext as plt
y = [1, 5, 3, 8, 4, 9, 0, 5]
plt.plot(y)
plt.scatter(y)
plt.legend(["lines", "points"])
plt.show()
```
- Note: two signals with same label, will be shown in the legend separatelly. 

[ Table of Contents ](https://github.com/piccolomo/plotext#table-of-contents)





<a name="hist"></a>
# Histogram Plot
For a histogram plot use the the `hist` function. Here is an example:
```
import plotext as plt
import random
data = [random.gauss(0, 1) for el in range(50000)]
data2 = [random.gauss(3, 1) for el in range(50000)]
plt.clp()
bins = 60
plt.hist(data, bins, label="mean 0")
plt.hist(data2, bins, label="mean 3")
plt.title("Histogram plot")
plt.xlabel("data bin")
plt.ylabel("frequency")
plt.figsize(100, 30)
plt.show()
```
![example](https://raw.githubusercontent.com/piccolomo/plotext/master/images/hist.png)

Here are the parameters of the `hist` function:

- `bins` defines the number of equal-width bins in the range (default 10).
- `bar_marker` sets the marker used to identify each bar plotted (default █).
- `bar_color` sets the color of the bars.
- If `fill` is True (as by default), the entire bars are plotted (including their body), otherwise only their top.
- `label` sets the label of the current data set, which will appear in the legend at the top left of the plot.
- `orientation` sets the orientation of the bars, either `vertical` or `horizontal`. 

[ Table of Contents ](https://github.com/piccolomo/plotext#table-of-contents)

<a name="limits"></a>
# Plot Limits
The plot limits are set automatically, to set them manually you can use the following functions - to be placed after the plotting calls and before `show()`:

 - `plt.xlim(xmin, xmax)` sets the minimum and maximum limits of the plot on the `x` axis. It requires a list of two numbers, where the first `xmin` sets the left (minimum) limit and the second `xmax` the right (maximum) limit. If one or both values are not provided, they are calculated automatically.
 - `plt.ylim(ymin, ymax)` is the equivalent of `plt.xlim()` but for the `y` axis.

Here is a coded example:
```
import plotext as plt
import numpy as np

l = 1000
x = np.arange(l)
n = 2
f = n * 2 * np.pi / l
y = np.sin(f * x)

plt.scatter(x, y)
plt.xlim(x[0] - 100, x[-1] + 100)
plt.ylim(-1.2, 1.2)
plt.figsize(100, 30)
plt.show()
```
![example](https://raw.githubusercontent.com/piccolomo/plotext/master/images/limits.png)
[ Table of Contents ](https://github.com/piccolomo/plotext#table-of-contents)


<a name="ticks"></a>
# Data Ticks
You can change the numerical ticks on both axes with the following three functions - to be placed after the plotting calls and before `show()`:

 - `plt.ticks(xnum, ynum)` sets `xnum` number of ticks on the `x` axis and `ynum` number of ticks on the `y` axis respectivelly.
 - `plt.xticks(ticks, labels)` manually sets the `x` ticks to the list of `labels` at the list of coordinates provided in `ticks`. If only one list is provided (`ticks`), the labels will correspond to the coordinates.
 - `plt.yticks(ticks, labels)` is the equivalent of `plt.xticks()` but for the `y` axis.

Here is a coded example:
```
import plotext as plt
import numpy as np

l = 1000
x = np.arange(l)
n = 2
f = n * 2 * np.pi / l
y1 = np.sin(f * x)
y2 = y1 * np.exp(-0.25 * f * x)
xticks = np.arange(0, l + l / (2 * n), l / (2 * n))
xlabels = [str(i) + "π" for i in range(2 * n + 1)]
plt.scatter(x, y1, label = "periodic signal")
plt.scatter(x, y2, label = "decaying signal")
plt.figsize(100, 30)
plt.ticks(0, 7)
plt.xticks(xticks, xlabels)
plt.show()
```
![example](https://raw.githubusercontent.com/piccolomo/plotext/master/images/ticks.png)
[ Table of Contents ](https://github.com/piccolomo/plotext#table-of-contents)


<a name="aspect"></a>
# Plot Aspect
You can personalize the plot aspect in many ways. You could use the following parameters - to be placed inside the `scatter` or `plot` calls:

 - `point_marker = marker` sets the marker used to identify each data point to the specified character. For example `plt.scatter(data, point_marker = "x")`. An integer value (up to 9) can also be provided to access special characters.
 - `line_marker = marker` sets the marker, used to identify the lines between consecutive points, to the specified character. For example `plt.plot(data, line_marker = "x")`. An integer value (up to 9) can also be provided to access special characters. 
 - `point_color = color` sets the color of `point_marker` on the plot.
 - `line_color = color` sets the color of `line_marker` on the plot.
 - `fillx = True` fills the area between the data and the `x` axis with data points (if used inside `scatter`) or line points (if used inside `plot`). For example: `plt.plot(data, fillx = True)`. By default `fillx = False`
 - `filly = True` fills the area between the data and the `y` axis with data points (if used inside `scatter`) or line points (if used inside `plot`). For example: `plt.plot(data, filly = True)`. By default `filly = False`

You could also use the following functions - to be placed after the plotting calls and before `show()`:

 - `plt.figsize(width, height)` sets the width and height of the plot to the desired values in terms of number of characters and characters rows on terminal. Note that the plot automatically extends to fill the entire terminal: use this function in order to reduce this size. Note also that the plot dimensions have a minimum value, dependent on the presence of axes, ticks, title etc; the plot dimensions will be set to the minimum value if a smaller size is provided.
 - `plt.width(width)` changes the figure width alone.
 - `plt.height(height)` changes the figure height alone.
 - `plt.title(string)` adds a plot title on the top of the plot.
 - `plt.xlabel(string)` and `plt.ylabel(string)` adds a label for respectively the `x` and `y` axis on the bottom of the plot.
 - `plt.grid(xbool, ybool)` adds the `x` grid lines to the plot if `xbool == True` and the `y` grid lines if `ybool == True`. If only one Boolean value is provided both grid lines are set simultaneously.
 - `plt.axes(xbool, ybool)` adds the `x` axis if `xbool == True` and the `y` axis if `ybool == True`. If only one boolean value is provided both axes are set simultaneously.
 - `plt.frame(True)` adds a frame around the figure. Note that `plt.frame(False)` will remove the frame only if the primary `x` or `y` axis are absent, otherwise only the secondary axes are removed.
 - `plt.canvas_color(color)` sets the color of the plot canvas alone.
 - `plt.axes_color(color)` sets the background color of all the labels surrounding the actual plot, i.e. the axes, ticks, title and axes labels, if present.
 - `plt.ticks_color(color)` sets the (full-ground) color of the axes ticks and of the grid lines, if present.
 - `plt.nocolor()` removes all colors from the plot.

The aspect options for the histogram plot can be seen directly in its section ([ Histogram Plot ](https://github.com/piccolomo/plotext#histogram-plot)). 

Other functions:
 - `plt.terminal_size()` returns the current terminal size.
 - `plt.colors()` prints the available full-ground and background color codes. Here is the output for simplicity:

   ![colors](https://raw.githubusercontent.com/piccolomo/plotext/master/images/colors.png)

Full-ground colors can be set to `point_color` and `line_color` or given as input to `plt.ticks_color()`. Background colors can be given as input to `plt.canvas_color()` and `plt.axes_color()`.
Using `flash` will result in an actually flashing character.
- `plt.markers()` shows the optional integer codes to quickly access special point or line markers. Here is the output for simplicity:

   ![colors](https://raw.githubusercontent.com/piccolomo/plotext/master/images/markers.png)

which can be set to `point_marker` and `line_marker`.

Here is a coded example:
```
import plotext as plt
import numpy as np

l = 1000
x = np.arange(l) + 1
n = 2
f = n * 2 * np.pi / l
y1 = np.sin(f * x)
y2 = y1 * np.exp(-0.25 * f * x)

plt.plot(x, y1, label = "periodic signal", line_color = "tomato")
plt.scatter(x, y2, label = "decaying signal", point_color = "iron", fillx = True)
plt.grid(True)
plt.title("plotext - plot style")
plt.xlabel("x axis")
plt.ylabel("y axis")
plt.canvas_color("cloud")
plt.axes_color("blue")
plt.ticks_color("yellow")
plt.show()
```
![example](https://raw.githubusercontent.com/piccolomo/plotext/master/images/aspect.png)
[ Table of Contents ](https://github.com/piccolomo/plotext#table-of-contents)


<a name="streaming"></a>
# Streaming Data
When streaming a continuos flow of data, consider using the following functions - to be placed before the plotting calls:

 - `plt.clear_plot()` clears the plot and all its internal parameters; it is useful when running the same script several times in order to avoid adding the same data to the plot; it is very similar to `cla()` in `matplotlib`.
 - `plt.clp()` is the shorter but equivalent version of `plt.clear_plot()`.
 - `plt.clear_terminal()` clear the terminal before the actual plot.
 - `plt.clt()` is the shorter but equivalent version of `plt.clear_terminal()`.
 - `plt.sleep(time)` is used in order to reduce a possible screen flickering; for example `plt.sleep(0.01)` would add approximately 10 ms to the computation. Note that the `time` parameters will depend on your processor speed and it needs some manual tweaking. You can place this command also after the plotting calls and `show()` function.

Here is a coded example:
```
import plotext as plt
import numpy as np

l = 1000
n = 2
f = n * np.pi / l
x = np.arange(0, l)
xticks = np.linspace(0, l-1, 5)
xlabels = [str(i) + "π" for i in range(5)]
frames = 500

for i in range(frames):
    y = np.sin(n * f * x + 2 * np.pi / frames * i)

    plt.clp()
    plt.clt()
    plt.scatter(x, y)
    plt.ylim(-1, 1)
    plt.xticks(xticks, xlabels)
    plt.yticks([-1, 0, 1])
    plt.fig_size(150, 40)
    plt.title("plotext - streaming data")
    plt.nocolor()
    plt.sleep(0.001)
    plt.show()
```
![example](https://raw.githubusercontent.com/piccolomo/plotext/master/images/stream.gif)

 - The function `plt.nocolor()` is recommended to make the streaming more responsive.
 - Plotting the same data using `matplotlib` was roughly 10 to 50 times slower on my Linux-based machine (depending on the colors settings and data size).

[ Table of Contents ](https://github.com/piccolomo/plotext#table-of-contents)


<a name="other"></a>
## Other Functions
- `plt.hist_data(data)` returns the frequency data used to create the histogram plot. 
- `plt.savefig(path)` saves the plot as a text file at the `path` provided. Note: no colors are preserved at the moment, when saving.
- `plt.version()` returns the version of the current installed `plotext` package.
- `plt.parameters()` returns all the internal plot parameters.
- `plt.docstrings()` prints all the available doc-strings.

[ Table of Contents ](https://github.com/piccolomo/plotext#table-of-contents)


<a name="updates"></a>
## Main Updates:
- in version 2.3.1: path for histogram error
- in version 2.3.0: added histogram plot, `fillx` and `filly` parameters.
- in version 2.2.2: new project description file, `fig_size` becomes `figsize` and `facecolor` is back to `axes_color` (sorry for confusion), slightly modified behavior under windows.
- in version 2.2.1: new markers that are Windows friendly (when the plot is saved, they occupy one character)
- the plots are printed with a default color combination, instead of default colorless one.
- the `x` axis is now on the left side
- `force_size` parameter removed (please let me know if it is still needed).
- `grid` function added to add optional grid lines. 
- `frame` function added to add a frame (present by default). 
- the only parameters available in the `plot` and `scatter` function are now only those which are dependent on the data set (like `point_marker`, `point_color`, `fill` etc..), all others can be set before the `show()` function with dedicated functions (like `ticks()`, `title()` etc.. )
- `fig_size()` instead of `canvas_size()` to avoid confusion
- `nocolor()` function added
- better algorith for getting the lines between consecutive points and the filling point (when using `fill=True`).
- `clp()` and `clt()` functions created, short versions of `clear_plot()` and `clear_terminal()` respectively. 
- color codes updated.
- `parameters()` function created.
- `docstrings()` function created.

[ Table of Contents ](https://github.com/piccolomo/plotext#table-of-contents)


<a name="plans"></a>
## Future Plans:
- creation of bar plots.
- creation of logarithmic plots
- creation of subplots
- data ticks for time based data
- color and terminal size support for IDLE python editor and compiler.
- same as previous point but for Spider. 
- saving text files with color

Any help or new ideas are welcomed.

[ Table of Contents ](https://github.com/piccolomo/plotext#table-of-contents)