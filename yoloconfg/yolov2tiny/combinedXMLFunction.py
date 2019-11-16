# combined function file
import os
import cv2
from lxml import etree
import xml.etree.cElementTree as ET

# reading file from the database
add=[]
imgAdd=[]
dirpath='/home/sabih/Desktop/mstar/MSTAR/ImagesTrainingChiSquare/'
imgdirpath='/home/sabih/Desktop/mstar/MSTAR/ImagesTrainingChiSquare/'
savedir = 'Annotations/'
className=[]
fileAdd=[]
counter=1
if not os.path.isdir(savedir):
        os.mkdir(savedir)
while counter<10601:
    
    fileAdd = str(counter) + '.jpg'
    add = dirpath + str(counter) + '.txt'
    imgAdd = imgdirpath  + str(counter) + '.jpg'
    fileAdd = str(counter) + '.jpg'

    image = cv2.imread(imgAdd)
    height, width, depth = image.shape

    annotation = ET.Element('annotation')
    ET.SubElement(annotation, 'folder').text = imgdirpath
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
#        i=0
#        temp=[0,0,0,0,0]
#        print(type(temp))
#        for elements in data.split('\t'):
#                print(type(elements))
#                temp[i] = int(elements)
#                i=i+1

#        data = data.replace('(', '')
#        data = data.replace(',', ' ')
#        data = data.replace(')', '')
        temp = data.split('\t')
    
        print(temp)
    
        x1 = int(temp[1])
        y1 = int(temp[2])
        x2 = int(temp[3])+int(temp[1])
        y2 = int(temp[4])+int(temp[2])
        classObj = int(temp[0])
        ## object class creation
        ## object class (1-airplane, 2-ship, 3-storage tank, 4-baseball diamond, 5-tennis court, 6-basketball court, 7-ground track field, 8-harbor, 9-bridge, 10-vehicle)
#        if classObj == 1:
 #           className = '2S1'
  #      if classObj == 2:
   #         className = 'BRDM_2'
    #    if classObj == 3:
#            className = 'BTR_60'
 #       if classObj == 4:
  #          className = 'D7'
   #     if classObj == 5:
#            className = 'T62'
 #       if classObj == 6:
  #          className = 'ZIL131'
   #     if classObj == 7:
#            className = 'ZSU_23_4'


        print(x1)
        print(y1)
        print(x2)
        print(y2)
        print(classObj-1)

        ob = ET.SubElement(annotation, 'object')
        ET.SubElement(ob, 'name').text = str(classObj-1)
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
