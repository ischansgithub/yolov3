python detect.py \
--cfg=/data1/chenww/my_research/yolov3/cfg/yolov3-spp-6cls.cfg  \
--names=/data1/chenww/my_research/yolov3/data/pcb/pcb.names  \
--weights=/data1/chenww/my_research/yolov3/output/pcb_ori_1024_768_bs2_ep300_scratch_oriAnchor/best.pt \
--source=/data1/chenww/my_research/yolov3/data/pcb/images/val/  \
--output=/data1/chenww/my_research/yolov3/output/pcb_ori_1024_768_bs2_ep300_scratch_oriAnchor/temp3/  \
--img-size=1024 \
--conf-thres=0.3 \
--iou-thres=0.5