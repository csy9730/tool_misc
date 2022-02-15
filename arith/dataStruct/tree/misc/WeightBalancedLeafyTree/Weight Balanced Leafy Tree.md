# [Weight Balanced Leafy Tree](https://www.cnblogs.com/Tian-Xing-Sakura/p/13098111.html)



# 1.11.1 Leafy TreeLeafy Tree

### 定义

> Leafy TreeLeafy Tree 是一种二叉树，其每个节点要么为叶子，要么有两个儿子。其信息完全储
> 存在叶子上面，每个非叶节点存储的信息是其儿子的信息的合并。

例如线段树就是一种Leafy TreeLeafy Tree，每个节点上存的信息是左右子节点的信息之和。

在用Leafy TreeLeafy Tree实现重量平衡树的功能的时候，每个节点的权值为其右子节点的权值，重量为左右节点重量之和，每个叶子节点的权值为集合中的数。

使用Leafy TreeLeafy Tree实现重量平衡树的方法叫WBLT(Weight Balanced Tree+Leafy Tree)WBLT(Weight Balanced Tree+Leafy Tree)。

因为只有叶子节点存储集合中的数，所以WBLTWBLT使用的节点数是别的种类的平衡树的两倍。

但是WBLTWBLT可持久化比较方便，速度也很快，一般来讲比SplaySplay快，和替罪羊树差不多。

# 1.21.2 加权平衡树

### 定义

> 加权平衡树（Weight Balanced TreeWeight Balanced Tree，也叫 BB[α]BB[α] 树，重量平衡树）是一种储存子树大小的二叉搜索树。即一个结点包含以下字段：值、左儿子、右儿子、子树大小。

> 重量平衡树中如果一个节点xx满足min(weightx.left,weightx.right)≥α×weightxmin(weightx.left,weightx.right)≥α×weightx,则称这个节点是αα加权平衡的，显然0<α≤120<α≤12。一棵含有nn个元素的加权平衡树的高度hh满足h≤log11−αn=O(logn)h≤log11−α⁡n=O(log⁡n)。

替罪羊树就是一种重量平衡树。

当节点的某个儿子xx的大小小于了α×α×节点xx的大小，就需要进行操作使其平衡。

在替罪羊树里我们通过重构整个xx节点的子树使其αα加权平衡。

在WBLTWBLT中我们通过旋转或者重构的方式使其αα加权平衡。

通过旋转使节点平衡的WBLTWBLT有单旋和双旋的写法，虽然单旋也挺快但是单旋的复杂度是错误的，而且一般比双旋慢。

不过单旋倒是应该也没有人卡。

# 2.12.1 Leafy TreeLeafy Tree实现二叉搜索树

首先先来看不用加权平衡的操作。

### PushupPushup

```cpp
void Pushup(int k) 
{ 
   tr[k].v = tr[tr[k].son[1]].v; 
   tr[k].siz = tr[tr[k].son[0]].siz + tr[tr[k].son[1]].siz; 
   return; 
}
```

按照定义进行PushupPushup即可。

### RecycleRecycle和IdId

```cpp
int Id() { return poolsize ? pool[poolsize--] : ++num; };

void Recycle(int x) { pool[++poolsize] = x; return; }
```

因为WBLTWBLT使用节点比较多，为了节省空间可以对删掉的节点进行回收操作。开一个栈表示可以使用的编号，每次删除时把编号丢进栈里即可。

### NewnodeNewnode

```cpp
int Newnode(int x)
{
    int k = Id();
    tr[k].siz = 1;
    tr[k].v = x;
    tr[k].son[0] = tr[k].son[1] = 0;
    return k;
}
```

新建一个权值为xx的节点，返回其标号。

### MergeMerge

```cpp
int Merge(int x, int y)
{
    int k = Id();
    tr[k].son[0] = x; tr[k].son[1] = y;
    Pushup(k);
    return k;
}
```

新建一个节点将两个节点的信息合并，返回新建的节点的编号。

### InsertInsert

```cpp
void Insert(int &k, int x)
{
    if (!k) { k = Newnode(x); return; }
    if (tr[k].siz == 1) 
    { 
    	k = x > tr[k].v ? Merge(k, Newnode(x)) : Merge(Newnode(x), k); 		 
        return;
    }
    else Insert(tr[k].son[x > tr[tr[k].son[0]].v], x);
    Pushup(k); Maintain(k);
    return;
}
```

WBLTWBLT里的节点不是叶子节点就一定有两个子节点，按顺序走到叶子节点然后建立一个新的节点，其儿子是新插入的节点和原来该位置上的节点。

### DeleteDelete

```cpp
void Delete(int &k, int x)
{
    if (tr[k].siz == 1) { Recycle(k); k = 0; return; }
    int d = x > tr[tr[k].son[0]].v;
    if (tr[tr[k].son[d]].siz == 1) Recycle(k), Recycle(tr[k].son[d]), k = tr[k].son[d ^ 1];
    else Delete(tr[k].son[d], x), Pushup(k), Maintain(k);
    return;
}
```

一路往下走找到要删除的节点的父亲节点，然后用父亲节点的另外一个儿子代替父亲节点。

其它基础操作和普通二叉搜索树的操作基本类似这里不再赘述，只需记住WBLTWBLT每个节点用于比较的权值不是该节点的权值而是该节点的左儿子的权值，因为左儿子的权值是左儿子所在子树的最大值，若最大值都没有贡献更小的值必然没有贡献。

# 2.22.2 WBLTWBLT

WBLTWBLT出现的不平衡状态大致分为两种。

![img](https://cdn.luogu.com.cn/upload/image_hosting/s7om6vtn.png)

这种情况，只存在节点xx有子节点weightx.son<α×weightxweightx.son<α×weightx，进行一次单旋即可。

![img](https://cdn.luogu.com.cn/upload/image_hosting/hds58ra8.png)

这种情况，既存在节点xx有子节点weightx.son<α×weightxweightx.son<α×weightx，又存在该子节点的另一侧节点weightx.son.son⊕1×1−2×α1−αweightx.son.son⊕1×1−2×α1−α，就进行两次旋转。

αα一般设为0.290.29，相对应的1−2×α1−α1−2×α1−α一般为0.60.6，不同的平衡树题可以将αα进行微调，效率会发生变化。

### RotateRotate

```cpp
void Rotate(int k, int d)
{
    int temp = tree[k].son[d ^ 1];
    tree[k].son[d ^ 1] = tree[k].son[d];
    tree[k].son[d] = tree[tree[k].son[d ^ 1]].son[d];
    tree[tree[k].son[d ^ 1]].son[d] = tree[tree[k].son[d ^ 1]].son[d ^ 1];
    tree[tree[k].son[d ^ 1]].son[d ^ 1]=temp;
    Pushup(tree[k].son[d ^ 1]);
    Pushup(k);
}
```

因为不同于SplaySplay和TreapTreap，我们不需要再使用该节点的编号，所以直接旋转完之后将编号交换。

可以通过上面的MergeMerge函数简化RotateRotate操作。

```cpp
void Rotate(int k, int d)
{
    if (d)
    {
        tr[k].son[0] = Merge(tr[k].son[0], tr[tr[k].son[1]].son[0]);
        Recycle(tr[k].son[1]); 
        tr[k].son[1] = tr[tr[k].son[1]].son[1];
        Pushup(tr[k].son[0]); Pushup(k); 
    }
    else
    {
        tr[k].son[1] = Merge(tr[tr[k].son[0]].son[1], tr[k].son[1]);
        Recycle(tr[k].son[0]);
        tr[k].son[0] =  tr[tr[k].son[0]].son[0];
        Pushup(tr[k].son[1]); Pushup(k);
    }
    return;
}
```

### MaintainMaintain

```cpp
void Maintain(int k)
{
    int d;
    if (tr[tr[k].son[0]].siz < tr[k].siz * alpha) d = 1;
    else if (tr[tr[k].son[1]].siz < tr[k].siz * alpha) d = 0;
    else return; 
    if (tr[tr[tr[k].son[d]].son[d ^ 1]].siz >= tr[tr[k].son[d]].siz * aalpha) Rotate(tr[k].son[d], d ^ 1);
    Rotate(k, d);
    return;
}
```

在插入和删除的时候从叶子节点往上依次维护平衡即可。

# 参考资料

我是从成都七中王思齐的IOI2018IOI2018国家集训队论文学习的WBLTWBLT，具体的复杂度证明可以去看看这篇论文。



分类: [笔记](https://www.cnblogs.com/Tian-Xing-Sakura/category/1785716.html)

标签: [数据结构](https://www.cnblogs.com/Tian-Xing-Sakura/tag/数据结构/), [平衡树](https://www.cnblogs.com/Tian-Xing-Sakura/tag/平衡树/), [WBLT](https://www.cnblogs.com/Tian-Xing-Sakura/tag/WBLT/)