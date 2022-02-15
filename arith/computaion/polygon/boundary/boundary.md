# boundary

Boundary of a set of points in 2-D or 3-D

这个函数是求一堆(平面/立体)点的边界，它不是凸包，这里的边界可以凹陷

[http://www.mathworks.com/help/matlab/ref/boundary.html](http://www.mathworks.com/help/matlab/ref/boundary.html)

## Syntax

- `k = boundary(x,y)`

  [example](boundary.html#buh3c7k-6)

- `k = boundary(x,y,z)`

  [example](boundary.html#buiaycj)

- `k = boundary(P)`

  [example](boundary.html#buh3dbb)

- `k = boundary(___,s)`

  [example](boundary.html#buh3c7k-6)

- `[k,v] = boundary(___)`

  [example](boundary.html#buh3dcj)





## Description

[example](boundary.html#buh3c7k-6)

`k = boundary(x,y)` returns a vector of point indices representing a single conforming 2-D boundary around the points `(x,y)`. The points `(x(k),y(k))` form the boundary. Unlike the convex hull, the boundary can shrink towards the interior of the hull to envelop the points.

[example](boundary.html#buiaycj)

`k = boundary(x,y,z)` returns a triangulation representing a single conforming 3-D boundary around the points `(x,y,z)`. Each row of `k` is a triangle defined in terms of the point indices.

[example](boundary.html#buh3dbb)

`k = boundary(P)` specifies points `(x,y)` or `(x,y,z)` in the columns of matrix `P`.

[example](boundary.html#buh3c7k-6)

`k = boundary(___,s)` specifies shrink factor `s` using any of the previous syntaxes. `s` is a scalar between `0` and `1`. Setting `s` to `0` gives the convex hull, and setting `s` to `1` gives a compact boundary that envelops the points. The default shrink factor is `0.5`.

[example](boundary.html#buh3dcj)

`[k,v] = boundary(___)` also returns a scalar `v`, which is the area (2-D) or volume (3-D) which boundary `k` encloses.