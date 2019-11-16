import cv2
from darkflow.net.build import TFNet
import matplotlib.pyplot as plt
import numpy as np

#config InlineBackend.figure_format = 'svg'

# define the model options and run

options = {
    'model': 'cfg/tiny-yolo-voc.cfg',
    'load': 'Weights/tiny-yolo-voc.weights',
    'threshold': 0.3,
    'gpu': 1.0
}

tfnet = TFNet(options)

# read the color image and covert to RGB
colors = [tuple(255 * np.random.rand(3)) for i in range(20)]
img = cv2.imread('11.jpg', cv2.IMREAD_COLOR)
img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

# use YOLO to predict the image
results = tfnet.return_predict  (img)

print(results)

# pull out some info from the results
'''
tl = (result[0]['topleft']['x'], result[0]['topleft']['y'])
br = (result[0]['bottomright']['x'], result[0]['bottomright']['y'])
label = result[0]['label']
'''
## generating bounding boxes

for color, result in zip(colors, results):
    tl = (result['topleft']['x'], result['topleft']['y'])
    br = (result['bottomright']['x'], result['bottomright']['y'])
    label = result['label']
    img = cv2.rectangle(img, tl, br, color, 7)
    img = cv2.putText(img, label, tl, cv2.FONT_HERSHEY_COMPLEX, 1, (255, 255, 255), 2)
'''
cv2.imshow('image',img)
cv2.waitKey(0xFF)
cv2.destroyAllWindows()

'''
plt.imshow(img)
plt.show()
'''
# add the box and label and display it
img = cv2.rectangle(img, tl, br, (0, 255, 0), 10)
img = cv2.putText(img, label, tl, cv2.FONT_HERSHEY_COMPLEX, 1, (255, 255, 255), 2)
plt.imshow(img)
plt.show()
'''
