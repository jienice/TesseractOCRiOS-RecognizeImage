<h3>OCR图形扫描识别</h3>

此为[维基百科](https://zh.wikipedia.org/wiki/%E5%85%89%E5%AD%A6%E5%AD%97%E7%AC%A6%E8%AF%86%E5%88%AB)对OCR的定义。

本项目主要使用的开源库[MAImagePickerController-of-InstaPDF](https://github.com/mmackh/MAImagePickerController-of-InstaPDF)以及[TesseracrOCRiOS](https://github.com/tesseract-ocr)。

<h3>MAImagePickerController-of-InstaPDF</h3>

[MAImagePickerController-of-InstaPDF](https://github.com/mmackh/MAImagePickerController-of-InstaPDF) 主要用来进行视图的采集，以及对图形的倾斜修正，自带的有3种滤镜，主要使用了[OpenCV](http://opencv.org/)技术。本项目使用时对部分的图标进行了替换，显得更加扁平化一点，替换了一些已经废弃的方法。

该项目的作者在GitHub上重新发布了一个开源的项目[IPDFCameraViewController](https://github.com/mmackh/IPDFCameraViewController)用来替换[MAImagePickerController-of-InstaPDF](https://github.com/mmackh/MAImagePickerController-of-InstaPDF)，但是不带有原项目中自行选择图片范围的功能，所以未使用新的项目。

<h3>TesseracrOCRiOS</h3>

[TesseracrOCRiOS](https://github.com/tesseract-ocr)是谷歌开源的一个OCR项目。

下载后请重新Pod关联库，并且设置[TesseracrOCRiOS](https://github.com/tesseract-ocr)`Enable BitCode = NO`。

