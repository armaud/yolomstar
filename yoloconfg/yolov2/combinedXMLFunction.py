# combined function file
import os
import cv2
from lxml import etree
import xml.etree.cElementTree as ET


# reading file from the database
add=[]
imgAdd=[]
dirpath='dataset/ground truth/'
imgdirpath='dataset/positiveImageSet/'
savedir = 'annotations/'
className=[]
fileAdd=[]
counter=1
if not os.path.isdir(savedir):
        os.mkdir(savedir)
while counter<651:
    
    if counter<10:
        add = dirpath + '0'+'0' + str(counter) + '.txt'
        imgAdd = imgdirpath + '0'+'0' + str(counter) + '.jpg'
        fileAdd = '0'+'0' + str(counter) + '.jpg'
    if counter>9 and counter < 100 :
        add = dirpath + '0' + str(counter) + '.txt'
        imgAdd = imgdirpath + '0'+ str(counter) + '.jpg'
        fileAdd = '0' + str(counter) + '.jpg'
    if counter>99 and counter < 1000:
        add = dirpath + str(counter) + '.txt'
        imgAdd = imgdirpath  + str(counter) + '.jpg'
        fileAdd = str(counter) + '.jpg'

    image = cv2.imread(imgAdd)
    height, width, depth = image.shape

    annotation = ET.Element('annotation')
    ET.SubElement(annotation, 'folder').text = 'dataset/positiveImageSet'
    #ET.SubElement(annotation, 'filename').text = imgAdd
    ET.SubElement(annotation, 'filename').text = fileAdd
    ET.SubElement(annotation, 'segmented').text = '0'
    size = ET.SubElement(annotation, 'size')
    ET.SubElement(size, 'width').text = str(width)
    ET.SubElement(size, 'height').text = str(height)
    ET.SubElement(size, 'depth').text = str(depth)

    
    print(add)
    print(imgAdd)
    print (counter)

    datafile = open(add,'r')
    data= str(datafile.readline())
    data= data.replace(' ','')
    while len(data)>1:
        #print(len(data))
        print(data)
        data = data.replace('(', '')
        data = data.replace(',', ' ')
        data = data.replace(')', '')
        temp = data.split(' ')
    
        #print(temp[0])
    
        x1 = int(temp[0])
        y1 = int(temp[1])
        x2 = int(temp[2])
        y2 = int(temp[3])
        classObj = int(temp[4])
        ## object class creation
        ## object class (1-airplane, 2-ship, 3-storage tank, 4-baseball diamond, 5-tennis court, 6-basketball court, 7-ground track field, 8-harbor, 9-bridge, 10-vehicle)
        if classObj == 1:
            className = 'Airplane'
        if classObj == 2:
            className = 'Ship'
        if classObj == 3:
            className = 'Storage Tank'
        if classObj == 4:
            className = 'Baseball Diamond'
        if classObj == 5:
            className = 'Tennis Court'
        if classObj == 6:
            className = 'Basketball Court'
        if classObj == 7:
            className = 'Ground Track Field'
        if classObj == 8:
            className = 'Harbor'
        if classObj == 9:
            className = 'Bridge'
        if classObj == 10:
            className = 'Vehicle'


        print(x1)
        print(y1)
        print(x2)
        print(y2)
        print(className)

        ob = ET.SubElement(annotation, 'object')
        ET.SubElement(ob, 'name').text = className
        ET.SubElement(ob, 'pose').text = 'Unspecified'
        ET.SubElement(ob, 'truncated').text = '0'
        ET.SubElement(ob, 'difficult').text = '0'
        bbox = ET.SubElement(ob, 'bndbox')
        ET.SubElement(bbox, 'xmin').text = str(x1)
        ET.SubElement(bbox, 'ymin').text = str(y1)
        ET.SubElement(bbox, 'xmax').text = str(x2)
        ET.SubElement(bbox, 'ymax').text = str(y2)
    
        ## repitation function for objects in single class
        data= (datafile.readline())
        data= data.replace(' ','')

    ## Storage file creation
    xml_str = ET.tostring(annotation)
    root = etree.fromstring(xml_str)
    xml_str = etree.tostring(root, pretty_print=True)
    ddir= str(str(counter) + '.xml')
    save_path = os.path.join(savedir, ddir)
    with open(save_path, 'wb') as temp_xml:
        temp_xml.write(xml_str)




    add=[]
    imgAdd=[]
    ddir = []
    fileAdd=[]
    counter=counter+1


datafile.close()
