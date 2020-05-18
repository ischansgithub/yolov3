# coding=utf-8
import os
import os.path as osp
import xml.dom.minidom as minidom
# import matplotlib.pyplot as plt
import numpy as np
import shutil
import cv2
import pdb

from random import shuffle


'''
function:  从图片和标注文件放在一起的文件夹中，生成对应的yolo格式的标注txt，并且每个cls带有id
img_root
│   
└───cls1
│   │   1.jpg
│   │   2.xml
|
└───cls2
    │   3.jpg
    │   3.xml
    
output_txt_root
│   
└───cls1
│   │   1.txt
│   │   2.txt
|
└───cls2
    │   3.txt
    │   4.txt
output_dat_root:输出train.txt 或者 val.txt,记录第一个图片的路径

'''


img_root = '/data1/chenww/my_research/yolov3/data/pcb/images/test/'
output_dat_root = '/data1/chenww/my_research/yolov3/data/pcb/'
output_txt_root = '/data1/chenww/my_research/yolov3/data/pcb/labels/'


cls2id = {'Missing_hole':0, 'Mouse_bite':1, 'Open_circuit':2, 'Short':3, 'Spur':4, 'Spurious_copper':5}
train_or_val = 'test' # 生成'train.dat或生成val.dat'

def read_xml(xml_filename):
    dom = minidom.parse(xml_filename)
    root = dom.documentElement
    assert (len(root.getElementsByTagName('filename')) == 1)
    assert (len(root.getElementsByTagName('size')) == 1)

    for filename in root.getElementsByTagName('filename'):
        filename = filename.firstChild.data

    # for c in root.getElementsByTagName('folder'):
    #     cls = c.firstChild.data

    # for size in root.getElementsByTagName('size'):
    #     width = size.getElementsByTagName('width')[0].firstChild.data
    #     height = size.getElementsByTagName('height')[0].firstChild.data
    #     depth = size.getElementsByTagName('depth')[0].firstChild.data
    #     # print(width, height, depth)

    label_name_list = []
    for i, label_name in enumerate(root.getElementsByTagName('name')):
        ln = label_name.firstChild.data
        label_name_list.append(ln)

    bboxes = []
    for bndbox in root.getElementsByTagName('bndbox'):
        xmin = bndbox.getElementsByTagName('xmin')[0].firstChild.data
        ymin = bndbox.getElementsByTagName('ymin')[0].firstChild.data
        xmax = bndbox.getElementsByTagName('xmax')[0].firstChild.data
        ymax = bndbox.getElementsByTagName('ymax')[0].firstChild.data
        xmin, ymin, xmax, ymax = int(xmin), int(ymin), int(xmax), int(ymax)
        bboxes.append((xmin, ymin, xmax, ymax))
    # return filename, bboxes, cls
    return  bboxes, label_name_list


def xyxy2xywh(shape, box_xyxy):
    imgh, imgw = shape
    dw = 1. / imgw
    dh = 1. / imgh

    xmin, ymin, xmax, ymax = box_xyxy
    bw = xmax - xmin
    bh = ymax - ymin
    bcx = (xmin + xmax) / 2.0 - 1
    bcy = (ymin + ymax) / 2.0 - 1

    x = bcx * dw
    y = bcy * dh
    w = bw * dw
    h = bh * dh

    return x, y, w, h

ots_img_path = []
fas_img_path = []
txt_file_cnt = 0

for i, class_name in enumerate(os.listdir(img_root)):
    if class_name not in cls2id: continue

    path = os.path.join(img_root, class_name)

    for img_file in os.listdir(path):
        if img_file.endswith('.xml'): continue
        
        xml = img_file[:-3] + 'xml'
        xml_filename_path = os.path.join(img_root,class_name, xml)
        img_file_path = os.path.join(img_root,class_name, img_file)

        try:  # 防止 xml中的 bboxes信息为空或者没有xml这个文件，会发生错误
            # filename, bboxes, cls = read_xml(xml_filename_path)
            bboxes, label_name_list = read_xml(xml_filename_path)
        except:
            print('xml is none or bbox in xml is none:', xml)
            continue

        img = cv2.imread(img_file_path)
        height, width, _ = img.shape
        assert img is not None, img_file_path

        output_txt_path = osp.join(output_txt_root, train_or_val, class_name)
        if not osp.exists(output_txt_path):  os.makedirs(output_txt_path)
        output_txt_path = output_txt_path + '/' + img_file[:-3] + 'txt'
        
        with open(output_txt_path, 'w') as f:
            assert bboxes is not None
            txt_file_cnt += 1
            for xmin, ymin, xmax, ymax in bboxes:
                cx, cy, fw, fh = xyxy2xywh([height, width], [xmin, ymin, xmax, ymax])
                f.write('{} {} {} {} {}\n'.format(cls2id[class_name], cx, cy, fw, fh))

        # 生成train.txt的ots_img_path要放在最后面，因为要保证通过标注信息滤除掉的标注文件 == 图片文件
        ots_img_path.append(img_file_path)

print("==================================")
print("img_num:", len(ots_img_path))
print("txt_num:", txt_file_cnt)


with open(output_dat_root + '{}.txt'.format(train_or_val), 'w') as f:
    for ots_img in ots_img_path:
        f.write(ots_img + '\n')