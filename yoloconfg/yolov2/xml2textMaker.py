import lxml.etree as et
import xml.etree.ElementTree as ET
import math


def txt_xml(filename,savdir):
    """ Parse a PASCAL VOC xml file """
    filenames = 'Annotations/'+filename + '.xml'
    tree = ET.parse(filenames)
    objects = []
    for obj in tree.findall('object'):
        # if not check(obj.find('name').text):
        #     continue
        obj_struct = {}
        obj_struct['name'] = obj.find('name').text
        bbox = obj.find('bndbox')
        obj_struct['bbox'] = [int(bbox.find('xmin').text) - 1,
                              int(bbox.find('ymin').text) - 1,
                              int(bbox.find('xmax').text) - 1,
                              int(bbox.find('ymax').text) - 1]
        # Read the original coordination
        x1=int(bbox.find('xmin').text)
        y1=int(bbox.find('ymin').text)
        x2=int(bbox.find('xmax').text)
        y2=int(bbox.find('ymax').text)
        
        # Transformation
        arr ='(' + str(x1)+ ',' + str(y1)+'),('+str(x2)+','+str(y2)+'),'+str(obj_struct['name']) + '\n'
        print (arr)
        #temp = str(temp)+(arr)
        #print(temp)
        #j=j+1
        filenametxt = savdir+filename+'.txt'
        a = open(filenametxt, 'a')
        a.write(str(arr))
        a.close()


#txt_xml("test2.xml")
