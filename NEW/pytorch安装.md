# pytorch安装



[https://pytorch.org/](https://pytorch.org/)



## install



可以从不同的源安装pytorch

* https://download.pytorch.org/whl/torch_stable.html
* conda 
* pypi



###  pytorch_wheel

一键安装脚本

```bash
pip install torch==1.6.0+cpu torchvision==0.7.0+cpu -f https://download.pytorch.org/whl/torch_stable.html

pip install torch==1.6.0+cu101 torchvision==0.7.0+cu101 -f https://download.pytorch.org/whl/torch_stable.html

# 或者
# Python 3.6
pip3 install https://download.pytorch.org/whl/cpu/torch-1.0.1-cp36-cp36m-win_amd64.whl
pip3 install torchvision
# Python 3.7
pip3 install https://download.pytorch.org/whl/cpu/torch-1.0.1-cp37-cp37m-win_amd64.whl
pip3 install torchvision
```



注意：必需指定是cpu版本还是cuda版本

cuda版本有： CUDA 9.2，CUDA 10.0，CUDA 10.1，CUDA 10.2

[https://download.pytorch.org/whl/torch_stable.html](https://download.pytorch.org/whl/torch_stable.html)



```

cu92/torch-0.4.1-cp27-cp27m-linux_x86_64.whl
cu92/torch-0.4.1-cp27-cp27mu-linux_x86_64.whl
cu92/torch-0.4.1-cp35-cp35m-linux_x86_64.whl
cu92/torch-0.4.1-cp35-cp35m-win_amd64.whl
cu92/torch-0.4.1-cp36-cp36m-linux_x86_64.whl
cu92/torch-0.4.1-cp36-cp36m-win_amd64.whl
cu92/torch-0.4.1-cp37-cp37m-linux_x86_64.whl
cu92/torch-0.4.1-cp37-cp37m-win_amd64.whl
cu92/torch-0.4.1.post2-cp37-cp37m-linux_x86_64.whl
cu92/torch-1.2.0%2Bcu92-cp27-cp27m-manylinux1_x86_64.whl
cu92/torch-1.2.0%2Bcu92-cp27-cp27mu-manylinux1_x86_64.whl
cu92/torch-1.2.0%2Bcu92-cp35-cp35m-manylinux1_x86_64.whl
cu92/torch-1.2.0%2Bcu92-cp35-cp35m-win_amd64.whl
cu92/torch-1.2.0%2Bcu92-cp36-cp36m-manylinux1_x86_64.whl
cu92/torch-1.2.0%2Bcu92-cp36-cp36m-win_amd64.whl
cu92/torch-1.2.0%2Bcu92-cp37-cp37m-manylinux1_x86_64.whl
cu92/torch-1.2.0%2Bcu92-cp37-cp37m-win_amd64.whl

cpu/torch-1.0.0-cp27-cp27m-linux_x86_64.whl
cpu/torch-1.0.0-cp27-cp27mu-linux_x86_64.whl
cpu/torch-1.0.0-cp27-none-macosx_10_6_x86_64.whl
cpu/torch-1.0.0-cp35-cp35m-linux_x86_64.whl
cpu/torch-1.0.0-cp35-cp35m-win_amd64.whl
cpu/torch-1.0.0-cp35-none-macosx_10_6_x86_64.whl
cpu/torch-1.0.0-cp36-cp36m-linux_x86_64.whl
cpu/torch-1.0.0-cp36-cp36m-win_amd64.whl
cpu/torch-1.0.0-cp36-none-macosx_10_7_x86_64.whl
cpu/torch-1.0.0-cp37-cp37m-linux_x86_64.whl
cpu/torch-1.0.0-cp37-cp37m-win_amd64.whl
cpu/torch-1.0.0-cp37-none-macosx_10_7_x86_64.whl
```



注意：windows可能需要安装[vc_redist.x64.exe](https://aka.ms/vs/16/release/vc_redist.x64.exe)

###  pypi_linux

注意：仅有linux和macosx版本 ,版本号有1.0.0~1.6.0 



```
torch-1.3.0-cp27-cp27m-manylinux1_x86_64.whl
torch-1.3.0-cp27-cp27mu-manylinux1_x86_64.whl
torch-1.3.0-cp35-cp35m-manylinux1_x86_64.whl
torch-1.3.0-cp35-none-macosx_10_6_x86_64.whl
torch-1.3.0-cp36-cp36m-manylinux1_x86_64.whl
torch-1.3.0-cp36-none-macosx_10_7_x86_64.whl
torch-1.3.0-cp37-cp37m-manylinux1_x86_64.whl
torch-1.3.0-cp37-none-macosx_10_9_x86_64.whl
```



也可以使用镜像：https://pypi.tuna.tsinghua.edu.cn/simple/torch

` pip install torch===1.3.0 torchvision===0.4.1 -i https://pypi.tuna.tsinghua.edu.cn/simple`



### conda

```
conda install pytorch torchvision cpuonly -c pytorch

conda install pytorch torchvision cudatoolkit=10.1 -c pytorch
conda install pytorch torchvision cudatoolkit=10.2 -c pytorch

```



`conda install pytorch-cpu torchvision-cpu -c pytorch # ???`



## 简单测试安装是否成功

```bash
python -c "import torch;print(torch.__version__）"
```

成功会输出版本号: `1.6.0+cpu`

