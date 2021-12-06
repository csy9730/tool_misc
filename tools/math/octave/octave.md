# octave

[https://www.gnu.org/software/octave/index](https://www.gnu.org/software/octave/index)

[![Example mesh](https://www.gnu.org/software/octave/img/example-mesh.svg)](https://www.gnu.org/software/octave/index#)

## ![GNU Octave logo](https://www.gnu.org/software/octave/img/octave-logo.svg)GNU Octave

**Scientific Programming Language**

- Powerful mathematics-oriented syntax with built-in 2D/3D plotting and visualization tools
- Free software, runs on GNU/Linux, macOS, BSD, and Microsoft Windows
- Drop-in compatible with many Matlab scripts

###  Syntax Examples

The Octave syntax is largely compatible with Matlab. The Octave interpreter can be run in [GUI mode](https://www.gnu.org/software/octave/index#), as a console, or invoked as part of a shell script. More Octave examples can be found in [the Octave wiki](https://wiki.octave.org/Using_Octave).

Solve systems of equations with linear algebra operations on **vectors** and **matrices**.

```
b = [4; 9; 2] # Column vector
A = [ 3 4 5;
      1 3 1;
      3 5 9 ]
x = A \ b     # Solve the system Ax = b
```

Visualize data with **high-level plot commands** in 2D and 3D.

```
x = -10:0.1:10; # Create an evenly-spaced vector from -10..10
y = sin (x);    # y is also a vector
plot (x, y);
title ("Simple 2-D Plot");
xlabel ("x");
ylabel ("sin (x)");
```

Click here to see the plot output

###  Octave Packages

GNU Octave can be extended by packages. Find them at:

- [Octave Packages](https://gnu-octave.github.io/packages/)
- [Octave Forge](https://octave.sourceforge.io/)

###  Development

Octave is free software licensed under the [GNU General Public License (GPL)](https://www.gnu.org/software/octave/license.html). Assuming you have Mercurial installed on your machine you may obtain the latest development version of Octave sources with the following command:

```
hg clone https://www.octave.org/hg/octave
```

###  [News](https://www.gnu.org/software/octave/news.html)

RSS

**GNU Octave 6.4.0 Released** – Oct 30, 2021

Octave Version 6.4.0 has been released and is now available for [download](https://www.gnu.org/software/octave/download.html). An official [Windows binary installer](https://ftpmirror.gnu.org/octave/windows) is also available. For [macOS](https://wiki.octave.org/Octave_for_macOS) see the installation instructions in the wiki.

Octave is free software under the [GNU General Public License.](https://www.gnu.org/software/octave/license.html)

Copyright © 1998-2021 John W. Eaton. This work is licensed under a [Creative Commons Attribution-NoDerivatives 4.0 International License](https://creativecommons.org/licenses/by-nd/4.0/). Get the [page sources](http://hg.octave.org/web-octave/file/tip).

