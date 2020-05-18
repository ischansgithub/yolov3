CUDA_VISIBLE_DEVICES=3 python test.py  \
--cfg=/data1/chenww/my_research/yolov3/cfg/yolov3-spp-6cls.cfg  \
--data=/data1/chenww/my_research/yolov3/data/pcb/pcb.data \
--weights=/data1/chenww/my_research/yolov3/output/pcb_ori_1024_bs2_ep300_scratch_oriAnachor_spp/best.pt \
--batch-size=1 \
--img-size=1024 \
--conf-thres=0.001 \
--iou-thres=0.001 \
