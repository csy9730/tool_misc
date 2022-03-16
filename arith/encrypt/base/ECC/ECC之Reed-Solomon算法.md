# ECC之Reed-Solomon算法

[![starimpact](https://pic1.zhimg.com/v2-4d55d9222d7e64f1f45888e01c469783_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/zhang-ming-28-20)

[starimpact](https://www.zhihu.com/people/zhang-ming-28-20)



计算视觉



79 人赞同了该文章

## 写在前头

很多年前，大约还在学校的时候，我曾有些疑问：磁头在读磁盘信息的时候如果不小心读错一个字节怎么办？为什么一个光盘即使有一些污渍，依然可以正确地读取出来内容？

前几个月当我看到ECC这个算法的时候，我张大了嘴~~~~~~

信息在传输的过程中是不能保证无错误的，就如同相机拍照永远都会有噪声一样。

有意思的地方在于，牛逼数学大师们解决了这样的传输错误问题，我们现在知道的所有有关信息传输存储读取相关的技术都有ECC的身影。

ECC的算法们，太牛逼了。它让整个世界可以无错地运转起来。

在这里，我会介绍一下ECC领域里一个牛逼的算法：RS纠错算法。

本文大部分内容将是对一篇英文博客的翻译。要讲好ECC这玩意，需要系统的知识，恰好我没有这样的能力去系统地讲，只能从一个算法工程师的角度去说清楚RS算法是怎么回事，然后附带一些基础知识的讲解。

翻译原文：[Reed-Solomon error-correcting code decoder](https://link.zhihu.com/?target=https%3A//www.nayuki.io/page/reed-solomon-error-correcting-code-decoder%23preliminaries)

Galois Field解释，长除解释，余项解释，参考文章：[Error Correction Coding](https://link.zhihu.com/?target=https%3A//www.thonky.com/qr-code-tutorial/error-correction-coding)

系统基础知识参考书籍：清华大学出版社的《纠错码的代数理论》

*在这新冠病毒流行的日子里，如此的工作可以为待在家中的我解解闷了。*

由于不是数学专业出身，所以了，如果有些专有名词翻译错了，请指正，不要喷我哟~

## 简介

Reed-Solomon编码允许任意信息用冗余内容进行扩展，这样的加长信息经过有噪声地传输后，只要出错数量少于事先定义的值，就能被完美地纠错解码。这使RS编码在有噪声的媒介上（比如电波，电话线路，磁盘，闪存等）可以保持信息的完整性，即所有的被传输信息在接收后都可以正确重建，即使是接收过来的是有一些错误的。

在这篇文章里，作者会用到一些数学知识来解释RS code和decode的过程。嗯，代码了，作者也是开源了的（良心啊~）。涉及到的主要数学知识有：简单代数，多项式算术，线性代数，有限域算术。

## 预备知识

1. RS过程是作用在用户选择的域 ![[公式]](https://www.zhihu.com/equation?tex=F) 里的。通常为了计算机处理的方便，这种域是 ![[公式]](https://www.zhihu.com/equation?tex=GF%282%5E%7B8%7D%29) 。但是，也有像 ![[公式]](https://www.zhihu.com/equation?tex=GF%282%5E4%29) ， ![[公式]](https://www.zhihu.com/equation?tex=GF%282%5E%7B12%7D%29) 之类的域。 ![[公式]](https://www.zhihu.com/equation?tex=GF) 即Galois Field，这是一种有限域，即能用的数值是有限的。在这个域里会有自己特有的加减乘除等算术规则，比如在这个域里，加减是一回事，加法和异或操作是一回事等等。总之，在这种有限域里，你不能用你平时在自然数域那种思维去思考问题了。在这个域里，我们还需要一种叫primitive element/generator的量 ![[公式]](https://www.zhihu.com/equation?tex=%5Calpha) 。域里的数值必需可以表示成{ ![[公式]](https://www.zhihu.com/equation?tex=0%EF%BC%8C%5Calpha%5E%7B0%7D%EF%BC%8C%5Calpha%5E%7B1%7D%EF%BC%8C%5Calpha%5E%7B2%7D%EF%BC%8C...%EF%BC%8C%5Calpha%5E%7B%7CF%7C-2%7D) }，它们是非零的，且都是以 ![[公式]](https://www.zhihu.com/equation?tex=%5Calpha) 为底的 ![[公式]](https://www.zhihu.com/equation?tex=n) 次方(外加一个0元素)， ![[公式]](https://www.zhihu.com/equation?tex=n) 最大为域的大小 ![[公式]](https://www.zhihu.com/equation?tex=%7CF%7C-2) (注： ![[公式]](https://www.zhihu.com/equation?tex=%5Calpha%5E%7B%7CF%7C-1%7D%3D1) )。其实在 ![[公式]](https://www.zhihu.com/equation?tex=GF) 里，幂运算都是非常特殊的，注意啦。
2. 咱们选择变量 ![[公式]](https://www.zhihu.com/equation?tex=k) 为消息的长度。它是一个整数，范围是 ![[公式]](https://www.zhihu.com/equation?tex=1%7B%5Cleq%7Dk%3C%7CF%7C) 。被编码的一段消息(sequence/block)都是从域 ![[公式]](https://www.zhihu.com/equation?tex=F) 里选择的 ![[公式]](https://www.zhihu.com/equation?tex=k) 个数值。比如当 ![[公式]](https://www.zhihu.com/equation?tex=k%3D25) 时，表示每个码字表达25个值。这有点抽像，暂且理解成要发送一段消息，每段消息的长度是25吧。这里会有一个问题：为啥码字长度不能超过域的大小了？这是一个和多项式长度有关的问题，在限定域里幂的指数是不能超过域的大小的，否则就会强制通过求余数运算再变小。这样说还是不好明白，后面看到多项式表示应该会清楚一点。
3. 咱们再选择变量 ![[公式]](https://www.zhihu.com/equation?tex=m) ，它表示纠错码的长度，而这个纠码是要被附加到消息后面的。是滴，直接加到消息后面。 ![[公式]](https://www.zhihu.com/equation?tex=m) 要满足 ![[公式]](https://www.zhihu.com/equation?tex=1%7B%5Cleq%7Dm%3C%7CF%7C-k) 。如果 ![[公式]](https://www.zhihu.com/equation?tex=m%3D0) ，那就说明消息没有被保护起来了。纠错码长度虽然是 ![[公式]](https://www.zhihu.com/equation?tex=m) ，但是它顶多只能纠正 ![[公式]](https://www.zhihu.com/equation?tex=floor%28m%2F2%29) 个错误。为啥了？这是有证明的，请看《纠错码的代数理论》前面的章节。
4. 最终哩， ![[公式]](https://www.zhihu.com/equation?tex=n%3Dk%2Bm) 即是编码后的码字长度(或称为块大小)。 ![[公式]](https://www.zhihu.com/equation?tex=n) 的范围是 ![[公式]](https://www.zhihu.com/equation?tex=2%7B%5Cleq%7Dn%3C%7CF%7C) 。所以，如果我们需要一个很大纠错能力的block或码字，那么就要对应更大的域 ![[公式]](https://www.zhihu.com/equation?tex=F) 作为基础。

## 系统的编码(Systematic encoder)

1. 为啥叫“系统的编码”，有一种翻译错了一个专有名词的感觉(心里好慌张)。它的意思是原始消息被当成一个多项式的一系列系数，然后了编码过程是将纠错码数据变成一个新的多项式直接加到这个原多项式后面，构成一个新的编码后的多项式。这种编码是不是特别帅？瞧，它并不是将原来的消息数据改得面目全非，而是在后面接上一块新数据。
2. 定义一个基于 ![[公式]](https://www.zhihu.com/equation?tex=m) 和 ![[公式]](https://www.zhihu.com/equation?tex=%5Calpha) 的**生成多项式**：
   ![[公式]](https://www.zhihu.com/equation?tex=g%28x%29%3D%5Cprod_%7Bi%3D0%7D%5E%7Bm-1%7D%7Bx-%7B%5Calpha%7D%5E%7Bi%7D%7D%3D%28x-%7B%5Calpha%7D%5E%7B0%7D%29%28x-%7B%5Calpha%7D%5E%7B1%7D%29...%28x-%7B%5Calpha%7D%5E%7Bm-1%7D%29)
   它的度(或叫阶数)是 ![[公式]](https://www.zhihu.com/equation?tex=m) ，即最大幂指数是 ![[公式]](https://www.zhihu.com/equation?tex=m) ，最大幂指数项对应的项的系数是1。
3. 假设原始消息是由![[公式]](https://www.zhihu.com/equation?tex=k)个值组成 的序列 ![[公式]](https://www.zhihu.com/equation?tex=%28M_%7B0%7D%2CM_%7B1%7D%2C...%2CM_%7Bk-1%7D%29) ，其中 ![[公式]](https://www.zhihu.com/equation?tex=M_%7Bi%7D) 是有限域 ![[公式]](https://www.zhihu.com/equation?tex=F) 中的元素。用这 ![[公式]](https://www.zhihu.com/equation?tex=k) 值作为系数，定义如下**原始消息多项式**：
   ![[公式]](https://www.zhihu.com/equation?tex=M%28x%29%3D%5Csum_%7Bi%3D0%7D%5E%7Bk-1%7D%7BM_%7Bi%7Dx%5E%7Bi%7D%7D%3DM_%7B0%7Dx%5E%7B0%7D%2BM_%7B1%7Dx%5E%7B1%7D%2B...%2BM_%7Bk-1%7Dx%5E%7Bk-1%7D)
4. 先直接给出计算RS码字的表达式，即编码公式：
   ![[公式]](https://www.zhihu.com/equation?tex=s%28x%29%3DM%28x%29x%5E%7Bm%7D-%5B%28M%28x%29x%5E%7Bm%7D%29%5Cmod+g%28x%29%5D)
   其中 ![[公式]](https://www.zhihu.com/equation?tex=mod) 代表求余，那么 ![[公式]](https://www.zhihu.com/equation?tex=%5B%28M%28x%29x%5E%7Bm%7D%29%5Cmod+g%28x%29%5D) 的结果是一个余数多项式，它的阶数最大为 ![[公式]](https://www.zhihu.com/equation?tex=m-1) 。然后，这个余数多项式就被加到了 ![[公式]](https://www.zhihu.com/equation?tex=M%28x%29x%5E%7Bm%7D) 后面。有人会说这明明是减号啊，而且你怎么能说“加到后面”了？前面说过了，在选定的限定域 ![[公式]](https://www.zhihu.com/equation?tex=F) 里加和减是一回事。而这个 ![[公式]](https://www.zhihu.com/equation?tex=M%28x%29x%5Em) 多项式的最小幂指数为 ![[公式]](https://www.zhihu.com/equation?tex=m) ，余数多项式的最高幂指数是 ![[公式]](https://www.zhihu.com/equation?tex=m-1) ，所以两个多项式整合后，每项互不干扰，也就相当于将两个多项式拼了起来，自然地，更低阶的余数多项式接在了高阶多项式的“后面“，最终变成了 ![[公式]](https://www.zhihu.com/equation?tex=s%28x%29) 。这个 ![[公式]](https://www.zhihu.com/equation?tex=s%28x%29) 的阶数最高为 ![[公式]](https://www.zhihu.com/equation?tex=n-1) 。
   另外，编码后的多项式有一个很重要的性质： ![[公式]](https://www.zhihu.com/equation?tex=s%28x%29%5Cmod+g%28x%29%3D0) 。
   或者，这么写： ![[公式]](https://www.zhihu.com/equation?tex=s%28x%29%5Cequiv%7B0%7D%5Cmod+g%28x%29)
   问题来了，为啥要多乘一个 ![[公式]](https://www.zhihu.com/equation?tex=x%5Em) ？因为要达到“加到后面”的效果呗~自己推公式去^_^
5. 好啦！看上去编码的任务快要大功告成了！再整理一下 ![[公式]](https://www.zhihu.com/equation?tex=s%28x%29) ，将它写成多项式的形式：
   ![[公式]](https://www.zhihu.com/equation?tex=s%28x%29%3D%5Csum_%7Bi%3D0%7D%5E%7Bn-1%7D%7Bs_%7Bi%7Dx%5E%7Bi%7D%7D%3Ds_%7B0%7Dx%5E%7B0%7D%2Bs_%7B1%7Dx%5E%7B1%7D%2B...%2Bs_%7Bn-1%7Dx%5E%7Bn-1%7D)
   上面的多项式系数序列 ![[公式]](https://www.zhihu.com/equation?tex=%28s_0%2C+s_1%2C...%2Cs_%7Bn-1%7D%29) 就是最终要发送出去的编码好的消息了。其中，每一个元素 ![[公式]](https://www.zhihu.com/equation?tex=s_i) 都是限定域 ![[公式]](https://www.zhihu.com/equation?tex=F) 的成员。

## PGZ解码(Peterson-Gorenstein-Zierler decoder)

**计算典型值(Calculating syndromes)**

1. 假定，我们接收到的码字是 ![[公式]](https://www.zhihu.com/equation?tex=%28r_0%2C+r_1%2C+%5Cldots%2C+r_%7Bn-1%7D%29) ，其中的每个值都是域 ![[公式]](https://www.zhihu.com/equation?tex=F) 中的元素。那么，先直接定义一下接收码字多项式：
   ![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Balign%7D+%09%09r%28x%29+%26%3D+%5Cdisplaystyle+%5Csum_%7Bi%3D0%7D%5E%7Bn-1%7D+r_i+x%5Ei+%5C%5C+%09%09%26%3D+r_0+x%5E0+%2B+r_1+x%5E1+%2B+%5Ccdots+%2B+r_%7Bn-1%7D+x%5E%7Bn-1%7D.+%09%09%5Cend%7Balign%7D)
2. 在接收端，我们并不知道真实发送的值 ![[公式]](https://www.zhihu.com/equation?tex=s_0%2C+s_1%2C+%5Cldots%2C+s_%7Bn-1%7D) 是多少。但是为了要解决问题，先定义一下误差。误差是指实际值与真实值之间的差值，即 ![[公式]](https://www.zhihu.com/equation?tex=e_0+%3D+r_0+%5C%21-%5C%21+s_0) ， ![[公式]](https://www.zhihu.com/equation?tex=e_1+%3D+r_1+%5C%21-%5C%21+s_1) ， ![[公式]](https://www.zhihu.com/equation?tex=%5Cldots) ， ![[公式]](https://www.zhihu.com/equation?tex=e_%7Bn-1%7D+%3D+r_%7Bn-1%7D+%5C%21-%5C%21+s_%7Bn-1%7D) 。然后给出误差多项式（明确一点，误差目前是未知的）：
   ![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Balign%7D+%09%09e%28x%29+%26%3D+r%28x%29+-+s%28x%29+%3D+%5Cdisplaystyle+%5Csum_%7Bi%3D0%7D%5E%7Bn-1%7D+e_i+x%5Ei+%5C%5C+%09%09%26%3D+e_0+x%5E0+%2B+e_1+x%5E1+%2B+%5Ccdots+%2B+e_%7Bn-1%7D+x%5E%7Bn-1%7D.+%09%09%5Cend%7Balign%7D)
3. 有意思的地方到了：定义典型值 ![[公式]](https://www.zhihu.com/equation?tex=S_i) ，它是以 ![[公式]](https://www.zhihu.com/equation?tex=%5Calpha%5Ei) ( ![[公式]](https://www.zhihu.com/equation?tex=%5Calpha) 是generator，看预备知识里的解释)为参数代入到接收码字多项式函数 ![[公式]](https://www.zhihu.com/equation?tex=r%28x%29) 中去得到的。典型值的个数为 ![[公式]](https://www.zhihu.com/equation?tex=m) ， ![[公式]](https://www.zhihu.com/equation?tex=0+%E2%89%A4+i+%3C+m) 。
   ![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Balign%7D+%09%09S_i+%26%3D+r%28%CE%B1%5Ei%29+%3D+s%28%CE%B1%5Ei%29+%2B+e%28%CE%B1%5Ei%29+%5C%5C+%09%09%26%3D+0+%2B+e%28%CE%B1%5Ei%29+%3D+e%28%CE%B1%5Ei%29+%5C%5C+%09%09%26%3D+e_0+%CE%B1%5E%7B0i%7D+%2B+e_1+%CE%B1%5E%7B1i%7D+%2B+%5Cldots+%2B+e_%7Bn-1%7D+%CE%B1%5E%7B%28n-1%29i%7D.+%09%09%5Cend%7Balign%7D)
   有没有发现，上式中认为 ![[公式]](https://www.zhihu.com/equation?tex=s%28%CE%B1%5Ei%29+%3D+0) ，这是为啥了？因为 ![[公式]](https://www.zhihu.com/equation?tex=s%28x%29+%E2%89%A1+0+%5Ctext%7B+mod+%7D+g%28x%29) ，而 ![[公式]](https://www.zhihu.com/equation?tex=g%28x%29%3D%28x+-+%CE%B1%5E0%29%28x+-+%CE%B1%5E1%29+%5Ccdots+%28x+-+%CE%B1%5E%7Bm-1%7D%29) 。再细点： ![[公式]](https://www.zhihu.com/equation?tex=s) 可以认为是 ![[公式]](https://www.zhihu.com/equation?tex=g) 的倍数，而 ![[公式]](https://www.zhihu.com/equation?tex=g%28%5Calpha%5Ei%29%5Cequiv+0) ，明白了吧。
   由此，我们可以看出来，典型值只和消息码字传输过程中产生的误差相关。
   如果，所有的典型值都是0，那么说明接收到的码字是无误差的，就是原始消息码字。这样一来，真是好走运啊~但是凡事还得多往坏处想想，如果典型值里有不是0的了？接着往下走……
4. 我们把所有典型值表达式写成一个方程组的形式(PS:自从掌握了对公式复制粘贴的方法后，输入公式好惬意呀~)：
   ![[公式]](https://www.zhihu.com/equation?tex=%5Cleft%5C%7B+%09%09%5Cbegin%7Balign%7D+%09%09S_0+%26%3D+e_0+%CE%B1%5E%7B0+%C3%97+0%7D+%2B+e_1+%CE%B1%5E%7B1+%C3%97+0%7D+%2B+%5Ccdots+%2B+e_%7Bn-1%7D+%CE%B1%5E%7B%28n-1%29+%C3%97+0%7D.+%5C%5C+%09%09S_1+%26%3D+e_0+%CE%B1%5E%7B0+%C3%97+1%7D+%2B+e_1+%CE%B1%5E%7B1+%C3%97+1%7D+%2B+%5Ccdots+%2B+e_%7Bn-1%7D+%CE%B1%5E%7B%28n-1%29+%C3%97+1%7D.+%5C%5C+%09%09%5Ccdots+%5C%5C+%09%09S_%7Bm-1%7D+%26%3D+e_0+%CE%B1%5E%7B0%28m-1%29%7D+%2B+e_1+%CE%B1%5E%7B1%28m-1%29%7D+%2B+%5Ccdots+%2B+e_%7Bn-1%7D+%CE%B1%5E%7B%28n-1%29%28m-1%29%7D.+%09%09%5Cend%7Balign%7D+%09%09%5Cright.)
5. 再改写成矩阵形式表达：
   ![[公式]](https://www.zhihu.com/equation?tex=%5Cleft%5B+%09%09%5Cbegin%7Bmatrix%7D+%09%09e_0+%CE%B1%5E%7B0+%C3%97+0%7D+%2B+e_1+%CE%B1%5E%7B1+%C3%97+0%7D+%2B+%5Ccdots+%2B+e_%7Bn-1%7D+%CE%B1%5E%7B%28n-1%29+%C3%97+0%7D+%5C%5C+%09%09e_0+%CE%B1%5E%7B0+%C3%97+1%7D+%2B+e_1+%CE%B1%5E%7B1+%C3%97+1%7D+%2B+%5Ccdots+%2B+e_%7Bn-1%7D+%CE%B1%5E%7B%28n-1%29+%C3%97+1%7D+%5C%5C+%09%09%5Cvdots+%5C%5C+%09%09e_0+%CE%B1%5E%7B0%28m-1%29%7D+%2B+e_1+%CE%B1%5E%7B1%28m-1%29%7D+%2B+%5Ccdots+%2B+e_%7Bn-1%7D+%CE%B1%5E%7B%28n-1%29%28m-1%29%7D+%09%09%5Cend%7Bmatrix%7D+%09%09%5Cright%5D+%3D+%5Cleft%5B+%09%09%5Cbegin%7Bmatrix%7D+%09%09S_0+%5C%5C+S_1+%5C%5C+%5Cvdots+%5C%5C+S_%7Bm-1%7D+%09%09%5Cend%7Bmatrix%7D+%09%09%5Cright%5D)
6. 最后把误差项系数单独列出来：
   ![[公式]](https://www.zhihu.com/equation?tex=%5Cleft%5B+%09%09%5Cbegin%7Bmatrix%7D+%09%09%CE%B1%5E%7B0+%C3%97+0%7D+%26+%CE%B1%5E%7B1+%C3%97+0%7D+%26+%5Ccdots+%26+%CE%B1%5E%7B%28n-1%29+%C3%97+0%7D+%5C%5C+%09%09%CE%B1%5E%7B0+%C3%97+1%7D+%26+%CE%B1%5E%7B1+%C3%97+1%7D+%26+%5Ccdots+%26+%CE%B1%5E%7B%28n-1%29+%C3%97+1%7D+%5C%5C+%09%09%5Cvdots+%26+%5Cvdots+%26+%5Cddots+%26+%5Cvdots+%5C%5C+%09%09%CE%B1%5E%7B0%28m-1%29%7D+%26+%CE%B1%5E%7B1%28m-1%29%7D+%26+%5Ccdots+%26+%CE%B1%5E%7B%28n-1%29%28m-1%29%7D+%09%09%5Cend%7Bmatrix%7D+%09%09%5Cright%5D+%5Cleft%5B+%09%09%5Cbegin%7Bmatrix%7D+%09%09e_0+%5C%5C+e_1+%5C%5C+%5Cvdots+%5C%5C+e_%7Bn-1%7D+%09%09%5Cend%7Bmatrix%7D+%09%09%5Cright%5D+%3D+%5Cleft%5B+%09%09%5Cbegin%7Bmatrix%7D+%09%09S_0+%5C%5C+S_1+%5C%5C+%5Cvdots+%5C%5C+S_%7Bm-1%7D+%09%09%5Cend%7Bmatrix%7D+%09%09%5Cright%5D)
   看到这里，这个误差 ![[公式]](https://www.zhihu.com/equation?tex=e_i) 看上去可以被解出来， ![[公式]](https://www.zhihu.com/equation?tex=%5Calpha) 是已经知的(一般的， ![[公式]](https://www.zhihu.com/equation?tex=%5Calpha%3D2) )， ![[公式]](https://www.zhihu.com/equation?tex=S_i) 也是已知的(通过 ![[公式]](https://www.zhihu.com/equation?tex=r%28%5Calpha%5Ei%29) 计算得到)。但是有没有发现，这个方程组是欠定的，因为 ![[公式]](https://www.zhihu.com/equation?tex=n%3Em) 。如何求解 ![[公式]](https://www.zhihu.com/equation?tex=e_i) 也是RS算法最精彩的部分了……

**找出误差位置(Finding error locations)**

1. 你没看错，先要找到接收的消息多项式中哪些项出错了，而不是直接求解误差值。在这一节里，我们要定义好多新的变量，说实话，我都有点晕了。
   假设接收的消息多项式中有 ![[公式]](https://www.zhihu.com/equation?tex=%5Cnu) 项是有错的，它的范围满足 ![[公式]](https://www.zhihu.com/equation?tex=1+%E2%89%A4+%CE%BD+%E2%89%A4+%5Cleft%5Clfloor+m%2F2+%5Cright%5Crfloor) 。至于，为什么只能纠正一半纠错码长度的错误，这个可以参考一下**《纠错码的代数理论》**，这里面**定理1.2.4**会有证明。可能在理解上有一点绕弯，但是我觉得本文的码字和书中的码字的意思是差不多的。
   除非有时间和空间上的限制，否则要尽量让 ![[公式]](https://www.zhihu.com/equation?tex=%5Cnu) 更大些，这样可以捕捉并纠正更多的信息错误，也就说可以抵抗更大的传输噪声。
2. 接下来，我们还要假设代表错码位置的变量： ![[公式]](https://www.zhihu.com/equation?tex=I_0)，![[公式]](https://www.zhihu.com/equation?tex=I_1) ， ![[公式]](https://www.zhihu.com/equation?tex=%5Cldots) ， ![[公式]](https://www.zhihu.com/equation?tex=I_%7B%5Cnu-1%7D) 。它们满足 ![[公式]](https://www.zhihu.com/equation?tex=0+%E2%89%A4+I_i+%3C+n) ，并且各个 ![[公式]](https://www.zhihu.com/equation?tex=I_i) 之间是没有顺序的。
   有了误差位置变量，那么在这些位置上的误差可以表示为： ![[公式]](https://www.zhihu.com/equation?tex=e_%7BI_0%7D) ， ![[公式]](https://www.zhihu.com/equation?tex=e_%7BI_1%7D) ， ![[公式]](https://www.zhihu.com/equation?tex=%5Cldots) ， ![[公式]](https://www.zhihu.com/equation?tex=e_%7BI_%7B%5Cnu-1%7D%7D) 。这个序列里的误差是有可能存在为0的值的，但是码字多项式其它位置上的系数误差 ![[公式]](https://www.zhihu.com/equation?tex=e_i) 一定是0，因为我们已经定义了有误差的位置只能发生在 ![[公式]](https://www.zhihu.com/equation?tex=I_i) 上。
3. 继续定义新的变量，为了后面的便利：
   ![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Balign%7D+%09%09X_i+%26%3D+%CE%B1%5E%7BI_i%7D.+%5C%5C+%09%09Y_i+%26%3D+e_%7BI_i%7D.+%09%09%5Cend%7Balign%7D)
   这两个新的变量，可以理解为： ![[公式]](https://www.zhihu.com/equation?tex=X_i) 是错码位置上的变量 ![[公式]](https://www.zhihu.com/equation?tex=x) 项， ![[公式]](https://www.zhihu.com/equation?tex=Y_i) 是错码位置上系数项。
4. 由于除了错码位置外的其它项都是没错的，即 ![[公式]](https://www.zhihu.com/equation?tex=e_i%3D0) ，所以上面的典型值矩阵方程可以进行化相应的化简，再用新变量 ![[公式]](https://www.zhihu.com/equation?tex=X_i) 与 ![[公式]](https://www.zhihu.com/equation?tex=Y_i) 替换老的变量，可以得到：
   ![[公式]](https://www.zhihu.com/equation?tex=%5Cleft%5B+%09%09%5Cbegin%7Bmatrix%7D+%09%09X_0%5E0+%26+X_1%5E0+%26+%5Ccdots+%26+X_%7B%CE%BD-1%7D%5E0+%5C%5C+%09%09X_0%5E1+%26+X_1%5E1+%26+%5Ccdots+%26+X_%7B%CE%BD-1%7D%5E1+%5C%5C+%09%09%5Cvdots+%26+%5Cvdots+%26+%5Cddots+%26+%5Cvdots+%5C%5C+%09%09X_0%5E%7Bm-1%7D+%26+X_1%5E%7Bm-1%7D+%26+%5Ccdots+%26+X_%7B%CE%BD-1%7D%5E%7Bm-1%7D+%09%09%5Cend%7Bmatrix%7D+%09%09%5Cright%5D+%5Cleft%5B+%09%09%5Cbegin%7Bmatrix%7D+%09%09Y_0+%5C%5C+Y_1+%5C%5C+%5Cvdots+%5C%5C+Y_%7B%CE%BD-1%7D+%09%09%5Cend%7Bmatrix%7D+%09%09%5Cright%5D+%3D+%5Cleft%5B+%09%09%5Cbegin%7Bmatrix%7D+%09%09S_0+%5C%5C+S_1+%5C%5C+%5Cvdots+%5C%5C+S_%7Bm-1%7D+%09%09%5Cend%7Bmatrix%7D+%09%09%5Cright%5D)
   看上去事情变得更糟糕了，这里面除了 ![[公式]](https://www.zhihu.com/equation?tex=m) 、![[公式]](https://www.zhihu.com/equation?tex=%5Cnu) 和 ![[公式]](https://www.zhihu.com/equation?tex=S_i) ，其它的都变成未知的了……我的天……
5. 神奇的事情快要发生，我不知道这个所谓的**定位多项式**是被什么样的思想火花给点着的，不过它真地解决了问题：
   ![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Balign%7D+%09%09%CE%9B%28x%29+%26%3D+%5Cdisplaystyle+%5Cprod_%7Bi%3D0%7D%5E%7B%CE%BD-1%7D+%281+-+X_i+x%29+%5C%5C+%09%09%26%3D+1+%2B+%CE%9B_1+x+%2B+%CE%9B_2+x%5E2+%2B+%5Ccdots+%2B+%CE%9B_%CE%BD+x%5E%CE%BD.+%09%09%5Cend%7Balign%7D)
6. 通过上面的构造，当 ![[公式]](https://www.zhihu.com/equation?tex=0%5Cleq%7Bi%7D%3C%5Cnu) 时，会有：
   ![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Balign%7D+%09%090+%26%3D+%CE%9B%28X_i%5E%7B-1%7D%29+%5C%5C+%09%09%26%3D+1+%2B+%CE%9B_1+X_i%5E%7B-1%7D+%2B+%CE%9B_2+X_i%5E%7B-2%7D+%2B+%5Ccdots+%2B+%CE%9B_%CE%BD+X_i%5E%7B-%CE%BD%7D.+%09%09%5Cend%7Balign%7D)
   这是一个显而易见的结果，因为 ![[公式]](https://www.zhihu.com/equation?tex=%281+-+X_i+X_i%5E%7B-1%7D%29+%3D+1+-+1+%3D+0) ，看上去有点面熟？在本文上面什么地方有一个类似的式子？呵呵……
   但是到这里，还是看不出来想干啥。
7. 由上面的0等式，两边同乘以 ![[公式]](https://www.zhihu.com/equation?tex=Y_i+X_i%5E%7Bj%2B%CE%BD%7D) 得：
   ![[公式]](https://www.zhihu.com/equation?tex=%28Y_i+X_i%5E%7Bj%2B%CE%BD%7D%290+%3D+%28Y_i+X_i%5E%7Bj%2B%CE%BD%7D%29+%CE%9B%28X_i%5E%7B-1%7D%29+%3D+%28Y_i+X_i%5E%7Bj%2B%CE%BD%7D%29%281+%2B+%CE%9B_1+X_i%5E%7B-1%7D+%2B+%CE%9B_2+X_i%5E%7B-2%7D+%2B+%5Ccdots+%2B+%CE%9B_%CE%BD+X_i%5E%7B-%CE%BD%7D%29.+%5C%5C+%090+%3D+Y_i+X_i%5E%7Bj%2B%CE%BD%7D+%CE%9B%28X_i%5E%7B-1%7D%29+%3D+Y_i+X_i%5E%7Bj%2B%CE%BD%7D+%2B+%CE%9B_1+Y_i+X_i%5E%7Bj%2B%CE%BD-1%7D+%2B+%CE%9B_2+Y_i+X_i%5E%7Bj%2B%CE%BD-2%7D+%2B+%5Ccdots+%2B+%CE%9B_%CE%BD+Y_i+X_i%5Ej.)
8. 继续，对于每一种 ![[公式]](https://www.zhihu.com/equation?tex=i%3D%5B0%2C1%2C...%2C%5Cnu-1%5D) 的等式，将它们相加：
   ![[公式]](https://www.zhihu.com/equation?tex=%5Cbegin%7Balign%7D+%09%090+%26%3D+%5Cdisplaystyle+%5Csum_%7Bi%3D0%7D%5E%7B%CE%BD-1%7D+Y_i+X_i%5E%7Bj%2B%CE%BD%7D+%CE%9B%28X_i%5E%7B-1%7D%29+%5C%5C+%09%09%26%3D+%5Csum_%7Bi%3D0%7D%5E%7B%CE%BD-1%7D+%5Cleft%28+Y_i+X_i%5E%7Bj%2B%CE%BD%7D+%2B+%CE%9B_1+Y_i+X_i%5E%7Bj%2B%CE%BD-1%7D+%2B+%CE%9B_2+Y_i+X_i%5E%7Bj%2B%CE%BD-2%7D+%2B+%5Ccdots+%2B+%CE%9B_%CE%BD+Y_i+X_i%5Ej+%5Cright%29+%5C%5C+%09%09%26+%3D+%5Cleft%28%5Csum_%7Bi%3D0%7D%5E%7B%CE%BD-1%7D+Y_i+X_i%5E%7Bj%2B%CE%BD%7D%5Cright%29+%2B+%CE%9B_1+%5Cleft%28%5Csum_%7Bi%3D0%7D%5E%7B%CE%BD-1%7D+Y_i+X_i%5E%7Bj%2B%CE%BD-1%7D%5Cright%29+%2B+%CE%9B_2+%5Cleft%28%5Csum_%7Bi%3D0%7D%5E%7B%CE%BD-1%7D+Y_i+X_i%5E%7Bj%2B%CE%BD-2%7D%5Cright%29+%2B+%5Ccdots+%2B+%CE%9B_%CE%BD+%5Cleft%28%5Csum_%7Bi%3D0%7D%5E%7B%CE%BD-1%7D+Y_i+X_i%5Ej%5Cright%29+%5C%5C+%09%09%26+%3D+S_%7Bj%2B%CE%BD%7D+%2B+%CE%9B_1+S_%7Bj%2B%CE%BD-1%7D+%2B+%CE%9B_2+S_%7Bj%2B%CE%BD-2%7D+%2B+%5Ccdots+%2B+%CE%9B_%CE%BD+S_j.+%09%09%5Cend%7Balign%7D)
9. 再继续调整项的位置有，其中 ![[公式]](https://www.zhihu.com/equation?tex=0%5Cleq%7Bj%7D%3C%5Cnu) ：
   ![[公式]](https://www.zhihu.com/equation?tex=%CE%9B_%CE%BD+S_j+%2B+%CE%9B_%7B%CE%BD-1%7D+S_%7Bj%2B1%7D+%2B+%5Ccdots+%2B+%CE%9B_1+S_%7Bj%2B%CE%BD-1%7D+%3D+-S_%7Bj%2B%CE%BD%7D.)
10. 为每一种 ![[公式]](https://www.zhihu.com/equation?tex=j%3D%5B0%2C1%2C...%2C%5Cnu-1%5D) 列一个等式，得到一个方程组：
    ![[公式]](https://www.zhihu.com/equation?tex=%5Cleft%5C%7B+%09%09%5Cbegin%7Balign%7D+%09%09%CE%9B_%CE%BD+S_0+%2B+%CE%9B_%7B%CE%BD-1%7D+S_1+%2B+%5Ccdots+%2B+%CE%9B_1+S_%7B%CE%BD-1%7D+%26+%3D+-S_%CE%BD.+%5C%5C+%09%09%CE%9B_%CE%BD+S_1+%2B+%CE%9B_%7B%CE%BD-1%7D+S_2+%2B+%5Ccdots+%2B+%CE%9B_1+S_%CE%BD+%26+%3D+-S_%7B%CE%BD%2B1%7D.+%5C%5C+%09%09%5Cvdots+%26+%5C%5C+%09%09%CE%9B_%CE%BD+S_%7B%CE%BD-1%7D+%2B+%CE%9B_%7B%CE%BD-1%7D+S_%CE%BD+%2B+%5Ccdots+%2B+%CE%9B_1+S_%7B2%CE%BD-2%7D+%26+%3D+-S_%7B2%CE%BD-1%7D.+%09%09%5Cend%7Balign%7D+%09%09%5Cright.)
11. 用矩阵的形式重新表达一下：
    ![[公式]](https://www.zhihu.com/equation?tex=%5Cleft%5B+%09%09%5Cbegin%7Bmatrix%7D+%09%09S_0+%26+S_1+%26+%5Ccdots+%26+S_%7B%CE%BD-1%7D+%5C%5C+%09%09S_1+%26+S_2+%26+%5Ccdots+%26+S_%CE%BD+%5C%5C+%09%09%5Cvdots+%26+%5Cvdots+%26+%5Cddots+%26+%5Cvdots+%5C%5C+%09%09S_%7B%CE%BD-1%7D+%26+S_%CE%BD+%26+%5Ccdots+%26+S_%7B2%CE%BD-2%7D+%09%09%5Cend%7Bmatrix%7D+%09%09%5Cright%5D+%5Cleft%5B+%09%09%5Cbegin%7Bmatrix%7D+%09%09%CE%9B_%CE%BD+%5C%5C+%CE%9B_%7B%CE%BD-1%7D+%5C%5C+%5Cvdots+%5C%5C+%CE%9B_1+%09%09%5Cend%7Bmatrix%7D+%09%09%5Cright%5D+%3D+%5Cleft%5B+%09%09%5Cbegin%7Bmatrix%7D+%09%09-S_%CE%BD+%5C%5C+-S_%7B%CE%BD%2B1%7D+%5C%5C+%5Cvdots+%5C%5C+-S_%7B2%CE%BD-1%7D+%09%09%5Cend%7Bmatrix%7D+%09%09%5Cright%5D)
    我们知道 ![[公式]](https://www.zhihu.com/equation?tex=S_i) 是已知的。左边一个方阵出来了，看上去很特别，方程组是适定的，所以可以将 ![[公式]](https://www.zhihu.com/equation?tex=%5CLambda_i) 给解出来了？
12. 现在构造一个增广矩阵，即：
    ![[公式]](https://www.zhihu.com/equation?tex=%5Cleft%5B+%09%09%5Cbegin%7Bmatrix%7D+%09%09S_0+%26+S_1+%26+%5Ccdots+%26+S_%7B%CE%BD-1%7D+%26+-S_%5Cnu+%5C%5C+%09%09S_1+%26+S_2+%26+%5Ccdots+%26+S_%CE%BD+%26+-S_%7B%5Cnu%2B1%7D+%5C%5C+%09%09%5Cvdots+%26+%5Cvdots+%26+%5Cddots+%26+%5Cvdots+%26+%5Cvdots+%5C%5C+%09%09S_%7B%CE%BD-1%7D+%26+S_%CE%BD+%26+%5Ccdots+%26+S_%7B2%CE%BD-2%7D+%26+-S_%7B2%5Cnu-1%7D+%09%09%5Cend%7Bmatrix%7D+%09%09%5Cright%5D+)
    将它送入Gauss-Jordan求解器就可以得到 ![[公式]](https://www.zhihu.com/equation?tex=%5CLambda_i) 。
    由此， ![[公式]](https://www.zhihu.com/equation?tex=%5CLambda%28x%29) 的多项式具体表达就出来了。接下来，将 ![[公式]](https://www.zhihu.com/equation?tex=%5Calpha%5E%7B-i%7D) ( ![[公式]](https://www.zhihu.com/equation?tex=0%5Cleq+i+%3C+n) )代入这个多项式，如果出现 ![[公式]](https://www.zhihu.com/equation?tex=%5CLambda%28%5Calpha%5E%7B-i%7D%29%3D0) 那么说明接收消息多项式的第 ![[公式]](https://www.zhihu.com/equation?tex=i) 的位置有误差，即![[公式]](https://www.zhihu.com/equation?tex=e%5Ei) 不为0。通过这种方式，我们就找到了所有误差项所在位置： ![[公式]](https://www.zhihu.com/equation?tex=I_0)，![[公式]](https://www.zhihu.com/equation?tex=I_1) ， ![[公式]](https://www.zhihu.com/equation?tex=%5Cldots) ， ![[公式]](https://www.zhihu.com/equation?tex=I_%7B%5Cnu-1%7D)。
13. 对于最终 ![[公式]](https://www.zhihu.com/equation?tex=I_i) 的分布，有些情况需要说明一下。有可能将所有的 ![[公式]](https://www.zhihu.com/equation?tex=%5Calpha%5E%7B-i%7D)代入![[公式]](https://www.zhihu.com/equation?tex=%5CLambda%28x%29)后，会有多于 ![[公式]](https://www.zhihu.com/equation?tex=%5Cnu) 个的0值。如果出现这样的情况，那么表示接收码字中错误项数量已经超过了预设的值 ![[公式]](https://www.zhihu.com/equation?tex=%5Cnu) ，此时也就代表不太可能恢复原信息了，也就是说无法完成纠错任务了。如果出错位置数少于 ![[公式]](https://www.zhihu.com/equation?tex=%5Cnu) 个，那么这没什么大不了的，错误数比预想的少，在解码方程里去掉对应的误差 ![[公式]](https://www.zhihu.com/equation?tex=e_i) 等于0的项即可。
    总之，搞了这么多新变量，奇妙的构造后，我们终于得到了误差项在接收消息多项式 ![[公式]](https://www.zhihu.com/equation?tex=r%28x%29) 中对应的位置了。接下来就是纠错解码喽~~~~

**计算错误值(Calculating error values)**

1. 上面千辛万苦得到了错码的位置索引：![[公式]](https://www.zhihu.com/equation?tex=I_0)，![[公式]](https://www.zhihu.com/equation?tex=I_1) ， ![[公式]](https://www.zhihu.com/equation?tex=%5Cldots) ， ![[公式]](https://www.zhihu.com/equation?tex=I_%7B%5Cnu-1%7D)。我们也知道 ![[公式]](https://www.zhihu.com/equation?tex=X_i+%3D+%CE%B1%5E%7BI_i%7D) ， ![[公式]](https://www.zhihu.com/equation?tex=0+%E2%89%A4+i+%3C+%CE%BD) ，也知道 ![[公式]](https://www.zhihu.com/equation?tex=Y_i+%3D+e_%7BI_i%7D) ，再列下这前的纠错方程组：
   ![[公式]](https://www.zhihu.com/equation?tex=%5Cleft%5B+%09%09%5Cbegin%7Bmatrix%7D+%09%09X_0%5E0+%26+X_1%5E0+%26+%5Ccdots+%26+X_%7B%CE%BD-1%7D%5E0+%5C%5C+%09%09X_0%5E1+%26+X_1%5E1+%26+%5Ccdots+%26+X_%7B%CE%BD-1%7D%5E1+%5C%5C+%09%09%5Cvdots+%26+%5Cvdots+%26+%5Cddots+%26+%5Cvdots+%5C%5C+%09%09X_0%5E%7Bm-1%7D+%26+X_1%5E%7Bm-1%7D+%26+%5Ccdots+%26+X_%7B%CE%BD-1%7D%5E%7Bm-1%7D+%09%09%5Cend%7Bmatrix%7D+%09%09%5Cright%5D+%5Cleft%5B+%09%09%5Cbegin%7Bmatrix%7D+%09%09Y_0+%5C%5C+Y_1+%5C%5C+%5Cvdots+%5C%5C+Y_%7B%CE%BD-1%7D+%09%09%5Cend%7Bmatrix%7D+%09%09%5Cright%5D+%3D+%5Cleft%5B+%09%09%5Cbegin%7Bmatrix%7D+%09%09S_0+%5C%5C+S_1+%5C%5C+%5Cvdots+%5C%5C+S_%7Bm-1%7D+%09%09%5Cend%7Bmatrix%7D+%09%09%5Cright%5D)
   ![[公式]](https://www.zhihu.com/equation?tex=S_i) 是可以通过 ![[公式]](https://www.zhihu.com/equation?tex=r%28x%29) 计算得到的，这也是一个适定的线性方程组，于是 ![[公式]](https://www.zhihu.com/equation?tex=Y_i) 就可以求解得到了。
2. 有了出错项的位置和对应项的误差值，复原原始信息值就很简单啦：
   ![[公式]](https://www.zhihu.com/equation?tex=r%27_%7BI_i%7D+%3D+r_%7BI_i%7D+%5C%21-%5C%21+Y_i+%3D+r_%7BI_i%7D+%5C%21-%5C%21+e_%7BI_i%7D) ， ![[公式]](https://www.zhihu.com/equation?tex=0+%E2%89%A4+i+%3C+%CE%BD)
   对于其它非错误位置的值，直接用 ![[公式]](https://www.zhihu.com/equation?tex=r%27_i+%3D+r_i) (![[公式]](https://www.zhihu.com/equation?tex=0%5Cleq+i+%3C+n) )就好了。
3. 看来，已经大功告成了！但是有了解码纠错后的正确值，我们有必要再用典型值多项式 ![[公式]](https://www.zhihu.com/equation?tex=S%28%5Calpha%5Ei%29) ，![[公式]](https://www.zhihu.com/equation?tex=0+%E2%89%A4+i+%3C+m)，再验证一下是不是解码纠错成功了。

## 文末费话

至此，整个RS编解码算法的主要部分就讲完了！由于能力有限，有些表达可能也不太严谨，也会存在某些地方没有理解深入，没有举一反三，希望有朋友可以交流指教和指正！

ECC中RS算法的魅力在于通过为码字附加一些特殊值，就可以达到对有限数量任意位置错码进行修复的目标！其中的深层原理，还是值得去细究的。如果可以举一反三，兴许还能尝试将ECC技术应用在实际生活中的更多地方，再针对不同应用做针对性改进也未尝不可。

个人经历了从图像处理，到传统机器学习，到摄影测量，再到深度学习的过程，现在知道了些ECC的皮毛。但是这点皮毛，却让人可以暂时从深度学习中的调参工作中解放出来，重新体验那种清晰明快的感觉！

如果将工作比做长跑，深度学习就像是兴奋剂一样让你可以马上取得很好的成绩，而其它机器学习和ECC等技术就像是一个个教练在指导你如何突破自己！

技术的价值在于可以解决生活中的问题，做为一名算法工程师的责任也在于此。

编辑于 2022-02-28 09:39

纠错

信息

算法