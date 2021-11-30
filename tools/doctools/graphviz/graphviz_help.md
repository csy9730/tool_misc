# graphviz


## file arch
- bin/  
- etc/  
- fonts/  
- gtk-2.0/  
- include/  
- lib/  
- pango/  
- share/

### bin/
```
acyclic.exe*   edgepaint.exe*  graphml2gv.exe*  gxl2gv.exe*  patchwork.exe*
bcomps.exe*    fc-cache.exe*   gv2gml.exe*      lefty.exe*   prune.exe*
ccomps.exe*    fc-cat.exe*     gvcolor.exe*     lneato.exe*  sccmap.exe*
circo.exe*     fc-list.exe*    gvedit.exe*      mingle.exe*  sfdp.exe*
diffimg.exe*   fc-match.exe*   gvgen.exe*       mm2gv.exe*   smyrna.exe*
dijkstra.exe*  fdp.exe*        gvmap.exe*       neato.exe*   tred.exe*
dot.exe*       gc.exe*         gvpack.exe*      nop.exe*     twopi.exe*
dotty.exe*     gml2gv.exe*     gvpr.exe*        osage.exe*   unflatten.exe*
```
#### dot.exe
```

$ dot --version
Error: dot: option -- unrecognized

Usage: dot [-Vv?] [-(GNE)name=val] [-(KTlso)<val>] <dot files>
(additional options for neato)    [-x] [-n<v>]
(additional options for fdp)      [-L(gO)] [-L(nUCT)<val>]
(additional options for memtest)  [-m<v>]
(additional options for config)  [-cv]

 -V          - Print version and exit
 -v          - Enable verbose mode
 -Gname=val  - Set graph attribute 'name' to 'val'
 -Nname=val  - Set node attribute 'name' to 'val'
 -Ename=val  - Set edge attribute 'name' to 'val'
 -Tv         - Set output format to 'v'
 -Kv         - Set layout engine to 'v' (overrides default based on command name)
 -lv         - Use external library 'v'
 -ofile      - Write output to 'file'
 -O          - Automatically generate an output filename based on the input filename with a .'format' appended. (Causes all -ofile options to be ignored.)
 -P          - Internally generate a graph of the current plugins.
 -q[l]       - Set level of message suppression (=1)
 -s[v]       - Scale input by 'v' (=72)
 -y          - Invert y coordinate in output

 -n[v]       - No layout mode 'v' (=1)
 -x          - Reduce graph

 -Lg         - Don't use grid
 -LO         - Use old attractive force
 -Ln<i>      - Set number of iterations to i
 -LU<i>      - Set unscaled factor to i
 -LC<v>      - Set overlap expansion factor to v
 -LT[*]<v>   - Set temperature (temperature factor) to v

 -m          - Memory test (Observe no growth with top. Kill when done.)
 -m[v]       - Memory test - v iterations.

 -c          - Configure plugins (Writes $prefix/lib/graphviz/config
               with available plugin information.  Needs write privilege.)
 -?          - Print usage and exit

```
### demo

创建test.gv文件
``` 
digraph test {
	a
	b
	c
	a -> b [color=green]
	b -> c
}

```

``` bash
dot test.gv -o image.jpg -Tpng
```