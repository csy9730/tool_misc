# https://github.com/cocodataset/cocoapi/blob/master/PythonAPI/pycocoDemo.ipynb

from pycocotools.coco import COCO
import numpy as np
import skimage.io as io
import matplotlib.pyplot as plt
import pylab
pylab.rcParams['figure.figsize'] = (8.0, 10.0)

dataDir=r'U:\csy\Project\Dataset\coco2017'
dataType='val2017'
annFile='{}/annotations/instances_{}.json'.format(dataDir,dataType)

# initialize COCO api for instance annotations
coco=COCO(annFile)


# display COCO categories and supercategories
cats = coco.loadCats(coco.getCatIds())
nms=[cat['name'] for cat in cats]
print('COCO categories: \n{}\n'.format(' '.join(nms)))

nms = set([cat['supercategory'] for cat in cats])
print('COCO supercategories: \n{}'.format(' '.join(nms)))

# get all images containing given categories, select one at random
catIds = coco.getCatIds(catNms=['person','dog','skateboard']); # 映射类别字符为类别序数。 返回 [1, 18, 41]
imgIds = coco.getImgIds(catIds=catIds ); # 人和狗和滑板的交集查询 ,返回 [549220, 324158, 279278]
imgIds = coco.getImgIds(imgIds = [324158])
img = coco.loadImgs(imgIds[np.random.randint(0,len(imgIds))])[0]

# load and display image
# I = io.imread('%s/images/%s/%s'%(dataDir,dataType,img['file_name']))
# use url to load image
I = io.imread(img['coco_url'])
plt.axis('off')
plt.imshow(I)
plt.show()

# load and display instance annotations
plt.imshow(I); plt.axis('off')
annIds = coco.getAnnIds(imgIds=img['id'], catIds=catIds, iscrowd=None)
anns = coco.loadAnns(annIds)
# {'area': 17376.91885, 'bbox': [388.66, 69.92, 109.41, 277.62], 'category_id': 1, 'id': 200887, 'image_id': 397133, 'iscrowd': 0, 
# 'keypoints': [433, 94, 2, 434, 90, 2, 0, 0, 0, ...], 'num_keypoints': 13, 'segmentation': [[...]]}
# keypoints 共有17个点，每个点含有x坐标，y坐标，类型信息，总长度为51，
#   部分点可以缺失，缺失点的值为[0,0,0]

coco.showAnns(anns)

# initialize COCO api for person keypoints annotations
annFile = '{}/annotations/person_keypoints_{}.json'.format(dataDir, dataType)
coco_kps=COCO(annFile)