# Weight-balanced tree

作者：派玄瑞

链接：https://www.zhihu.com/question/27940474/answer/637005569

来源：知乎

著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

Weight-balanced tree。Weight-balanced tree（又叫Adams tree）是一种纯函数式的平衡二分搜索树，发明于1972年，且实现非常简单，大约50行以下Standard ML或Haskell就可以完成。具体可以看Stephen Adams的technical report或Journal of Functional Programming论文（weight-balanced tree虽然不是Adams最早发明，但却因此而得名为Adams tree）。Haskell的containers库实现Set和Map使用的数据结构就是weight-balanced tree。



[http://citeseerx.ist.psu.edu/viewdoc/download;jsessionid=34E6F401C5FEB1EAADAF70FC304A77A2?doi=10.1.1.501.8427&rep=rep1&type=pdfciteseerx.ist.psu.edu/viewdoc/download;jsessionid=34E6F401C5FEB1EAADAF70FC304A77A2?doi=10.1.1.501.8427&rep=rep1&type=pdf](https://link.zhihu.com/?target=http%3A//citeseerx.ist.psu.edu/viewdoc/download%3Bjsessionid%3D34E6F401C5FEB1EAADAF70FC304A77A2%3Fdoi%3D10.1.1.501.8427%26rep%3Drep1%26type%3Dpdf)



从该文中可以看到，实现weight-balanced tree需要选择两个平衡常数（Adams称为 ![[公式]](https://www.zhihu.com/equation?tex=w) 和 ![[公式]](https://www.zhihu.com/equation?tex=%5Calpha) ，而其他文献中有称为 ![[公式]](https://www.zhihu.com/equation?tex=%5CGamma) 和 ![[公式]](https://www.zhihu.com/equation?tex=%5CDelta) 的），这两个常数必须取值适当才能保证weight-balanced tree足够平衡，进而才能保证 ![[公式]](https://www.zhihu.com/equation?tex=O%28%5Clog+n%29) 的时间复杂度。不同的文献对这两个常数的取值并不相同：最早的版本里参数取值是 ![[公式]](https://www.zhihu.com/equation?tex=%281+%2B+%5Csqrt+2%2C+%5Csqrt+2%29) ，但这样会使实现非常复杂。Adams选取了(4, 1)，但文献中并没有给出证明。Adams在论文中还表示a可以取任意不小于3.75的整数，但有Haskell开发者按照论文中的描述实现weight-balanced tree，结果却出了bug。究竟是实现中出了不为人知的错误，还是Adams的论文有错？

这一问题历经39年，直到2011才被日本的平井洋一（Yoichi HIRAI）和山本和彦（Kazuhiko YAMAMOTO）解决。两人在他们发表于Journal of Functional Programming的论文（[https://yoichihirai.com/bst.pdf](https://link.zhihu.com/?target=https%3A//yoichihirai.com/bst.pdf)）中用Coq证明了能使得WBT平衡的整数对(a, b)只有(3, 2)一对，其证明长达15773行。在此之后，Haskell用户终于可以放心的使用Map和Set了。