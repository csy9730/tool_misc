# inpolygon
判断点是否在多边形上

> Points located inside or on edge of polygonal region


[collapse all in page](javascript:void(0);)

## Syntax

- `in = inpolygon(xq,yq,xv,yv)`

  [example](inpolygon.html#buanygl-3)

- `[in,on] = inpolygon(xq,yq,xv,yv)`

  [example](inpolygon.html#buanwyh-2_1)





## Description

[example](inpolygon.html#buanygl-3)

`in = inpolygon(xq,yq,xv,yv)` returns `in` indicating if the query points specified by `xq` and `yq` are inside or on the edge of the polygon area defined by `xv` and `yv`.

[example](inpolygon.html#buanwyh-2_1)

`[in,on] = inpolygon(xq,yq,xv,yv)` also returns `on` indicating if the query points are on the edge of the polygon area.