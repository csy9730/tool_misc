# csape

> csape:Cubic spline interpolation with end conditions

三次样条函数


### demo

```matlab
csape(xx,yy,[1,1])

csape(xx,[0,yy,0],[1,1])

```

### 边界条件
- Clamped 紧压样条/完全三次样条，一阶导数条件
- second 二阶导数条件
- Natural 自然边界条件，二阶导数为0
- periodic 周期样条，左端点的微分等于右端点的微分，左端点的二次微分等于右端点的二次微分
- not a knot 无结三次样条





