# plt

Read lists of numbers from stdin.

For each list, numbers are separated by by `[^0-9.\-eE+]`, and can be used for 3
distinct types of plots:

    1) --line (-l)
    2) --scatter (-s)
    3) --histogram (-t)

With options 1 and 3, the list of numbers is interpreted as a 1D array, i.e.,

```
    (x1, x2, ..., xn).
```

For 2, the format is

```
    (x1, y1, x2, y2, ... , xn, yn)
```

Lists are separated by `PLT_SEPARATOR`, whose default value is `&&`.
