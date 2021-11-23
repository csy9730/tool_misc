# KNN



KNN 算法是对模板匹配算法的扩展。
核心要素 包括： 匹配池，距离函数，投票函数。
``` python

def knnCore(dist_list, label_list):
    K = 3
    idx = sorted(range(len(dist_list)), lambda x:dist_list[x])
    pck = idx[0:K]
    return getMostFreq(label_list[pck])


def knnWrap(x, pool, dist, knnCore):
    d = []
    l = []
    for i, t in pool:
        d.append(dist(i, x))
        l.append(t)
    return knnCore(d, l)

```

分类类别为 M，

模板匹配的 匹配池数量为M，通过对每个类别数据取平均，得到模板样本。

KNN算法的 匹配池不做修改处理，



## misc
1、K越小越容易过拟合，当K=1时，这时只根据单个近邻进行预测，如果离目标点最近的一个点是噪声，就会出错，此时模型复杂度高，稳健性低，决策边界崎岖。

2、但是如果K取的过大，这时与目标点较远的样本点也会对预测起作用，就会导致欠拟合，此时模型变得简单，决策边界变平滑。

3、如果K=N的时候，那么就是取全部的样本点，这样预测新点时，最终结果都是取所有样本点中某分类下最多的点，分类模型就完全失效了。
4、k值的选取，既不能太大，也不能太小，何值为最好，需要实验调整参数确定！

K 这个参数，相当于模型的正则系数？