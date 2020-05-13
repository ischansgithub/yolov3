CUDA_VISIBLE_DEVICES=2 python test.py  \
--cfg=/data1/chenww/my_research/yolov3/cfg/yolov3-spp-6cls.cfg  \
--data=/data1/chenww/my_research/yolov3/data/pcb/pcb.data \
--weights=/data1/chenww/my_research/yolov3/output/pcb_ori_1024_768_bs2_ep300_scratch_oriAnchor/best.pt \
--batch-size=2 \
--img-size=1024 \
--conf-thres=0.001 \
--iou-thres=0.001 \
