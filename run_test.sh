CUDA_VISIBLE_DEVICES=2 python test.py  \
--cfg=/data1/chenww/my_research/yolov3/cfg/yolov3-1cls.cfg \
--data=/data1/chenww/my_research/yolov3/data/d13/small_1cls/small_1cls.data \
--weights=/data1/chenww/my_research/yolov3/output/1cls_896_bs8_ep300_scratch_oriAnachor_yolo3ori/best.pt \
--batch-size=2 \
--img-size=1024 \
--conf-thres=0.001 \
--iou-thres=0.7 \
