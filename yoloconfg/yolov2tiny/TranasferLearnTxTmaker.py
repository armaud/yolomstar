import cv2
from darkflow.net.build import TFNet
import matplotlib.pyplot as plt
import numpy as np
from xml2textMaker import txt_xml

#config InlineBackend.figure_format = 'svg'

# define the model options and run

options = {
    'model': 'cfg/tiny-yolo-voc-c7.cfg',
    'load': -1,#'yolov2c10-3330',
    'threshold': 0.001,
    'gpu': 0.5
}

tfnet = TFNet(options)

# read the color image and covert to RGB
#colors = [tuple(255 * np.random.rand(3)) for i in range(20)]


ii=1
#dirx='TestImages/'
dirx = '/home/sabih/Desktop/mstar/MSTAR/Images45/'
savedir='textResultsTiny45/'
#gtdir = 'TextImagesGTTiny/'
imgAdd=[]
gtadd=[]
saveAdd=[]

i=1
while(ii<1061):
    
    imgAdd = dirx + str(ii) + '.jpg'
    saveAdd = savedir +str(ii) + '.txt'

    print(imgAdd)
    
    img = cv2.imread(imgAdd, cv2.IMREAD_COLOR)
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        
    #txt_xml(gtadd,gtdir)
# use YOLO to predict the image
    results = tfnet.return_predict  (img)
    print(len(results))
    j=0
    index=[]
    temp=[]
    while (j<len(results)):

        if results[j]['label'] == '0':
            index=1
        elif results[j]['label'] == '1':
            index=2
        elif results[j]['label'] == '2':
            index=3
        elif results[j]['label'] == '3':
            index=4
        elif results[j]['label'] == '4':
            index=5
        elif results[j]['label'] == '5':
            index=6
        elif results[j]['label'] == '6':
            index=7
#        elif results[j]['label'] == '7':
#            index=7
#        elif results[j]['label'] == '8':
#            index=8
#        elif results[j]['label'] == '9':
#            index=9
        

        # assignment of arrays into text files
        arr =str(index)+'\t'+ str(results[j]['topleft']['x'])+ '\t' + str(results[j]['topleft']['y'])+'\t'+str(results[j]['bottomright']['x'])+'\t'+str(results[j]['bottomright']['y']) + '\t' + str(results[j]['confidence'])+'\n'
        print (arr)
        #temp = str(temp)+(arr)
        #print(temp)
        j=j+1
        a = open(saveAdd, 'a')
        a.write(str(arr))
        a.close()
    i=i+1
    j=0
    ii=ii+1
