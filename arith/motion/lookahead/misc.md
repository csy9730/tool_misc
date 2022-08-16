# lookahead misc
能否达到匀速
- 长线段前瞻， S50,S61,S62,S70. 速度范围大，
- 短线段前瞻，速度范围小。

### 融合
- 长线段融合
    - vmax == vseg 可以融合
    - vmax > vseg 无法融合
- 短线段融合
    - vpre < vseg, vpro < vseg
        - v0 < vpre < vpro < v1 
            - 可以融合 v0 < vpre_s23p < vpro_s24p < v1 
            - 无法融合
        - v0 > vpre , vpro > v1
            - 可以融合 v0 < vpre_s25n , vpro_s26n < v1 
            - 无法融合
    - vpre > vseg, vpro > vseg
- 长短线段融合




左右树选择
- 首次分割树时，选择结点最小的分割，（就是避免两颗子树的节点值接近）
- 优先计算最小结点树的限速
- 根据限速来判断另一边的限速是否符合。