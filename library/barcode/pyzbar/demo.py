
import cv2 as cv
from pyzbar import pyzbar as pyzbar


def decodeDisplay(image):
    barcodes = pyzbar.decode(image)
    for barcode in barcodes:
        # 提取二维码的边界框的位置
        # 画出图像中条形码的边界框
        (x, y, w, h) = barcode.rect
        cv.rectangle(image, (x, y), (x + w, y + h), (0, 0, 255), 2)

        # 提取二维码数据为字节对象，所以如果我们想在输出图像上
        # 画出来，就需要先将它转换成字符串
        barcodeData = barcode.data.decode("UTF8")
        barcodeType = barcode.type

        # 绘出图像上条形码的数据和条形码类型
        text = "{} ({})".format(barcodeData, barcodeType)
        cv.putText(image, text, (x, y - 10), cv.FONT_HERSHEY_SIMPLEX,.5, (0, 0, 125), 2)
        # 向终端打印条形码数据和条形码类型
        print("[INFO] Found {} barcode: {}".format(barcodeType, barcodeData))
    return image

def demo():
    pfn = 'a.png'
    pfn = r"H:\Project\works\zmcProj\bak\barcode\IMG_20220207_190830.jpg"
    pfn = r"H:\Project\works\zmcProj\bak\barcode\IMG_20220207_141928.jpg"
    img = cv.imread(pfn)
    img = cv.cvtColor(img, cv.COLOR_BGR2GRAY)
    im = decodeDisplay(img)
    cv.imshow("camera", im)

def main():
    demo()

if __name__ == '__main__':
    main()
