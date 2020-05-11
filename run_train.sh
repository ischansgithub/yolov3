SAVE_PATH=/data1/chenww/my_research/yolov3/output/pcb_ori_1024_768_bs2_ep300_scratch_oriAnachor/
rm -rf ${SAVE_PATH} ${SAVE_PATH}
mkdir ${SAVE_PATH}  ${SAVE_PATH}

nohup python train.py \
--cfg=/data1/chenww/my_research/yolov3/cfg/yolov3-spp-6cls.cfg  \
--data=/data1/chenww/my_research/yolov3/data/pcb/pcb.data  \
--epochs=300  \
--batch-size=2 \
--weights='' \
--weight_save_path=${SAVE_PATH}  \
2>&1 | tee  ${SAVE_PATH}"pcb_ori_6cls_ep300_bs2_scratch.txt" &
