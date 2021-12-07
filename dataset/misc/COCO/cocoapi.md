# cocoapi


[COCO API](https://github.com/cocodataset/cocoapi)

> The COCO API assists in loading, parsing, and visualizing annotations in COCO. The API 
> supports multiple annotation formats (please see the data format page). For additional details see: CocoApi.m, coco.py, and CocoApi.lua for Matlab, Python, and Lua code, respectively, and also the Python API demo.


## install

```
pip install pycocotools
```

cocoapi 基本没有特殊依赖，依赖了 cython，通过cython编译_mask.pyx，_mask.pyx仅依赖了numpy。windows下也可以轻易安装。

## source

cocoapi 包含三个文件：coco文件，cocoeval文件，mask文件。
mask文件实现图像分割的rle编码和多边形编码的转换。


### coco

The COCO API assists in loading, parsing, and visualizing annotations in COCO. The API supports multiple annotation formats (please see the [data format](https://cocodataset.org/#format-data) page). For additional details see: [CocoApi.m](https://github.com/cocodataset/cocoapi/blob/master/MatlabAPI/CocoApi.m), [coco.py](https://github.com/cocodataset/cocoapi/blob/master/PythonAPI/pycocotools/coco.py), and [CocoApi.lua](https://github.com/cocodataset/cocoapi/blob/master/LuaAPI/CocoApi.lua) for Matlab, Python, and Lua code, respectively, and also the [Python API demo](https://github.com/cocodataset/cocoapi/blob/master/PythonAPI/pycocoDemo.ipynb).

Throughout the API "ann"=annotation, "cat"=category, and "img"=image.
- getAnnIdsGet ann ids that satisfy given filter conditions. 
- getCatIdsGet cat ids that satisfy given filter conditions. 
- getImgIdsGet img ids that satisfy given filter conditions. 
- loadAnnsLoad anns with the specified ids. 
- loadCatsLoad cats with the specified ids. 
- loadImgsLoad imgs with the specified ids. 
- loadResLoad algorithm results and create API for accessing them. 
- showAnnsDisplay the specified annotations.

#### coco demo
[https://github.com/cocodataset/cocoapi/blob/master/PythonAPI/pycocoDemo.ipynb](https://github.com/cocodataset/cocoapi/blob/master/PythonAPI/pycocoDemo.ipynb)

### cocoeval
cocoeval 怎么使用？
``` python
#initialize COCO ground truth api
dataDir='../'
dataType='val2014'
annFile = '%s/annotations/%s_%s.json'%(dataDir,prefix,dataType)
cocoGt=COCO(annFile)

#initialize COCO detections api
resFile='%s/results/%s_%s_fake%s100_results.json'
resFile = resFile%(dataDir, prefix, dataType, annType)
cocoDt=cocoGt.loadRes(resFile)


# running evaluation
cocoEval = COCOeval(cocoGt,cocoDt,annType)
cocoEval.params.imgIds  = imgIds
cocoEval.evaluate()
cocoEval.accumulate()
cocoEval.summarize()
```
需要把预测结果，保存成coco格式，cocoEval可以比较两个coco格式的json文件结果。

[https://github.com/cocodataset/cocoapi/blob/master/PythonAPI/pycocoEvalDemo.ipynb](https://github.com/cocodataset/cocoapi/blob/master/PythonAPI/pycocoEvalDemo.ipynb)

### mask api
COCO provides segmentation masks for every object instance. This creates two challenges: storing masks compactly and performing mask computations efficiently. We solve both challenges using a custom Run Length Encoding (RLE) scheme. The size of the RLE representation is proportional to the number of boundaries pixels of a mask and operations such as area, union, or intersection can be computed efficiently directly on the RLE. Specifically, assuming fairly simple shapes, the RLE representation is O(√n) where n is number of pixels in the object, and common computations are likewise O(√n). Naively computing the same operations on the decoded masks (stored as an array) would be O(n).

The MASK API provides an interface for manipulating masks stored in RLE format. The API is defined below, for additional details see: MaskApi.m, mask.py, or MaskApi.lua. Finally, we note that a majority of ground truth masks are stored as polygons (which are quite compact), these polygons are converted to RLE when needed.

- encodeEncode binary masks using RLE. 
- decodeDecode binary masks encoded via RLE. 
- mergeCompute union or intersection of encoded masks. 
- iouCompute intersection over union between masks. 
- areaCompute area of encoded masks. 
- toBboxGet bounding boxes surrounding encoded masks. 
- frBboxConvert bounding boxes to encoded masks. 
- frPolyConvert polygon to encoded mask.