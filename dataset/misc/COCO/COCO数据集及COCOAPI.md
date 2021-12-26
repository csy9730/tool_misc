# COCO数据集及COCOAPI

[![无用](https://pic2.zhimg.com/v2-ec1e1e1fad1f88656a8e4fd80bdc0dcb_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/jing-jin-guan-li-ri-ji)

[无用](https://www.zhihu.com/people/jing-jin-guan-li-ri-ji)

人工智障

42 人赞同了该文章

# 一、COCO数据集的结构

假定dataDir的目录结构：annotations，test2014，train2014，val2014

由于annotations文件是一个json文件，所以用json来看看数据基本结构

``` python
import json
dataDir=r'D:\data\coco\coco2014'
dataType='val2014'
annFile='{}/annotations/instances_{}.json'.format(dataDir,dataType)
data=json.load(open(annFile,'r'))
```

先看看最顶层的结构：

``` python
for k in data:
    print(k)
-------------------------------
info
images
licenses
annotations
categories
```

其中最重要的是三个：images，annotations ，categories

1、images的结构：

``` python
for k in data["images"][0]:
    print(k)
-----------------------------
license
file_name
coco_url
height
width
date_captured
flickr_url
id
```

2、annotations 的结构：

``` python
for k in data["annotations "][0]:
    print(k)
------------------------------------
segmentation
area
iscrowd
image_id
bbox
category_id
id
```

3、categories的结构：

```text
for k in data["categories"][0]:
    print(k)
-----------------------------------
supercategory
id
name
```

## 二、cocoapi（[cocoapi](https://link.zhihu.com/?target=https%3A//github.com/cocodataset/cocoapi)）：

pycocotools下有三个模块：coco、cocoeval、mask、_mask。

1、coco模块：

``` python
# The following API functions are defined:
#  COCO       - COCO api class that loads COCO annotation file and prepare data structures.
#  getAnnIds  - Get ann ids that satisfy given filter conditions.
#  getCatIds  - Get cat ids that satisfy given filter conditions.
#  getImgIds  - Get img ids that satisfy given filter conditions.
#  loadAnns   - Load anns with the specified ids.
#  loadCats   - Load cats with the specified ids.
#  loadImgs   - Load imgs with the specified ids.
#  annToMask  - Convert segmentation in an annotation to binary mask.
#  showAnns   - Display the specified annotations.
#  loadRes    - Load algorithm results and create API for accessing them.
#  download   - Download COCO images from mscoco.org server.
# Throughout the API "ann"=annotation, "cat"=category, and "img"=image.
# Help on each functions can be accessed by: "help COCO>function".
```

COCO类定义了10个方法：

（1）获取标注id：

``` python
def getAnnIds(self, imgIds=[], catIds=[], areaRng=[], iscrowd=None):
        """
        Get ann ids that satisfy given filter conditions. default skips that filter
        :param imgIds  (int array)     : get anns for given imgs
               catIds  (int array)     : get anns for given cats
               areaRng (float array)   : get anns for given area range (e.g. [0 inf])
               iscrowd (boolean)       : get anns for given crowd label (False or True)
        :return: ids (int array)       : integer array of ann ids
        """
```

（2）获取类别id：

``` python
def getCatIds(self, catNms=[], supNms=[], catIds=[]):
        """
        filtering parameters. default skips that filter.
        :param catNms (str array)  : get cats for given cat names
        :param supNms (str array)  : get cats for given supercategory names
        :param catIds (int array)  : get cats for given cat ids
        :return: ids (int array)   : integer array of cat ids
        """
```

（3）获取图片id：

``` python
def getImgIds(self, imgIds=[], catIds=[]):
        '''
        Get img ids that satisfy given filter conditions.
        :param imgIds (int array) : get imgs for given ids
        :param catIds (int array) : get imgs with all given cats
        :return: ids (int array)  : integer array of img ids
        '''
```

（4）加载标注：

``` python
def loadAnns(self, ids=[]):
        """
        Load anns with the specified ids.
        :param ids (int array)       : integer ids specifying anns
        :return: anns (object array) : loaded ann objects
        """
```

（5）加载类别：

``` python
def loadCats(self, ids=[]):
        """
        Load cats with the specified ids.
        :param ids (int array)       : integer ids specifying cats
        :return: cats (object array) : loaded cat objects
        """
```

（6）加载图片：

```python
def loadImgs(self, ids=[]):
        """
        Load anns with the specified ids.
        :param ids (int array)       : integer ids specifying img
        :return: imgs (object array) : loaded img objects
        """
```

（7）用matplotlib在图片上显示标注：

``` python
def showAnns(self, anns):
        """
        Display the specified annotations.
        :param anns (array of object): annotations to display
        :return: None
        """
```

（8）加载结果文件：

``` python
def loadRes(self, resFile):
        """
        Load result file and return a result api object.
        :param   resFile (str)     : file name of result file
        :return: res (obj)         : result api object
        """
```

（9）下载数据集（国内用这个真的行吗？还是百度网盘更好吧？）：

``` python
def download(self, tarDir = None, imgIds = [] ):
        '''
        Download COCO images from mscoco.org server.
        :param tarDir (str): COCO results directory name
               imgIds (list): images to be downloaded
        :return:
        '''
```

（10）ann转为rle格式：

``` python
def annToRLE(self, ann):
        """
        Convert annotation which can be polygons, uncompressed RLE to RLE.
        :return: binary mask (numpy 2D array)
        """
```

（11）获取mask：

``` python
def annToMask(self, ann):
        """
        Convert annotation which can be polygons, uncompressed RLE, or RLE to binary mask.
        :return: binary mask (numpy 2D array)
        """
```

2、mask模块下定义了四个函数：

``` python
def encode(bimask)：
def decode(rleObjs):
def area(rleObjs):
def toBbox(rleObjs):
```

3、cocoeval模块定义了COCOeval和Params类：

``` python
    # The usage for CocoEval is as follows:
    #  cocoGt=..., cocoDt=...       # load dataset and results
    #  E = CocoEval(cocoGt,cocoDt); # initialize CocoEval object
    #  E.params.recThrs = ...;      # set parameters as desired
    #  E.evaluate();                # run per image evaluation
    #  E.accumulate();              # accumulate per image results
    #  E.summarize();               # display summary metrics of results
```

4、更底层的模块_mask：（略）



## 三、示例（jupyter notebook）：

``` python
%matplotlib inline
from pycocotools.coco import COCO
from pycocotools.mask import encode,decode,area,toBbox

import numpy as np
import skimage.io as io
import matplotlib.pyplot as plt
import pylab
pylab.rcParams['figure.figsize'] = (8.0, 10.0)

dataDir=r'D:\data\coco\coco2014'
dataType='val2014'
annFile='{}/annotations/instances_{}.json'.format(dataDir,dataType)

coco=COCO(annFile)

imgIds = coco.getImgIds()
imags=coco.loadImgs(imgIds)

annIds = coco.getAnnIds(imgIds=imgIds)
ann = coco.loadAnns(annIds)[0]

mask=coco.annToMask(ann)
rle=coco.annToRLE(ann)

rle=encode(mask)
mask=decode(rle)

area(rle)
toBbox(rle)
```



## 四、segmentation的两种格式：RLE（*run-length encoding*）和polygon：

1、iscrowd=1时表示格式是RLE，iscrowd=0时表示格式是polygon：

polygon:

```text
{"segmentation": [[499.71, 397.28,......342.71, 172.31]], 
"area": 43466.12825, 
"iscrowd": 0, 
"image_id": 182155, 
"bbox": [338.89, 51.69, 205.82, 367.61], 
"category_id": 1, 
"id": 1248258},
```

RLE:

```text
{"segmentation": {"counts": [66916, 6, 587,..... 1, 114303], "size": [594, 640]}, 
"area": 6197, 
"iscrowd": 1, 
"image_id": 284445, 
"bbox": [112, 322, 335, 94], 
"category_id": 1, 
"id": 9.001002844e+11}
```

关于这两个问题的讨论见[The RLE or Polygon format of "segmentation"](https://link.zhihu.com/?target=https%3A//github.com/facebookresearch/Detectron/issues/100).

coco数据集好像都是polygon格式，而[understanding_cloud_organization](https://link.zhihu.com/?target=https%3A//www.kaggle.com/c/understanding_cloud_organization)就用的是RLE。

2、polygon与mask之间的转换：

``` python
import cv2

def mask2polygon(mask):
    contours, hierarchy = cv2.findContours((mask).astype(np.uint8), cv2.RETR_TREE,cv2.CHAIN_APPROX_SIMPLE)
    # mask_new, contours, hierarchy = cv2.findContours((mask).astype(np.uint8), cv2.RETR_TREE,cv2.CHAIN_APPROX_SIMPLE)
    segmentation = []
    for contour in contours:
        contour_list = contour.flatten().tolist()
        if len(contour_list) > 4:# and cv2.contourArea(contour)>10000
            segmentation.append(contour_list)
    return segmentation

def polygons_to_mask(img_shape, polygons):
    mask = np.zeros(img_shape, dtype=np.uint8)
    polygons = np.asarray(polygons, np.int32) # 这里必须是int32，其他类型使用fillPoly会报错
    shape=polygons.shape
    polygons=polygons.reshape(shape[0],-1,2)
    cv2.fillPoly(mask, polygons,color=1) # 非int32 会报错
    return mask
#test------------------------------
import numpy as np
mask = np.ones((100, 100))
for i in range(10):
    for j in range(10):
        mask[i][j]=0
mask2polygon(mask)
--------------------------
[[10, 0, 10, 9, 9, 10, 0, 10, 0, 99, 99, 99, 99, 0]]
```

另外的方法，[binary_mask_to_polygon](https://link.zhihu.com/?target=https%3A//www.cnblogs.com/aimhabo/archive/2018/11/12/9949276.html)（没试过，供参考）。

3、RLE与mask之间的转换：

```python
def mask2rle(img):
    '''
    img: numpy array, 1 - mask, 0 - background
    Returns run length as string formated
    '''
    pixels= img.T.flatten()
    pixels = np.concatenate([[0], pixels, [0]])
    runs = np.where(pixels[1:] != pixels[:-1])[0] + 1
    runs[1::2] -= runs[::2]
    return ' '.join(str(x) for x in runs)

def rle2mask(rle, input_shape):
    width, height = input_shape[:2]
    
    mask= np.zeros( width*height ).astype(np.uint8)
    
    array = np.asarray([int(x) for x in rle.split()])
    starts = array[0::2]
    lengths = array[1::2]

    current_position = 0
    for index, start in enumerate(starts):
        mask[int(start):int(start+lengths[index])] = 1
        current_position += lengths[index]   
    return mask.reshape(height, width).T
```

4、计算mask的bbox：

```python
def bounding_box(img):
    # return max and min of a mask to draw bounding box
    rows = np.any(img, axis=1)
    cols = np.any(img, axis=0)
    rmin, rmax = np.where(rows)[0][[0, -1]]
    cmin, cmax = np.where(cols)[0][[0, -1]]

    return rmin, rmax, cmin, cmax
```



## 五、其他格式的数据集转化为coco格式数据集

参看一个示例：[convert-dataset-to-coco-format-tools](https://link.zhihu.com/?target=https%3A//www.kaggle.com/fmscole/convert-dataset-to-coco-format-tools)





编辑于 2019-09-30

[数据](https://www.zhihu.com/topic/19554449)

[Mask R-CNN](https://www.zhihu.com/topic/20104198)

[人工智能](https://www.zhihu.com/topic/19551275)

赞同 42