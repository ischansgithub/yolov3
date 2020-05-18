SAVE_PATH=/data1/chenww/my_research/yolov3/output/pcb_ori_1024_bs2_ep300_scratch_kmeansAnachor_yolo3tiny/
rm -rf ${SAVE_PATH} ${SAVE_PATH}
mkdir ${SAVE_PATH}  ${SAVE_PATH}

nohup python train.py \
--cfg=/data1/chenww/my_research/yolov3/cfg/yolov3-tiny-6cls-kmeans.cfg  \
--data=/data1/chenww/my_research/yolov3/data/pcb/pcb.data  \
--epochs=300  \
--batch-size=2 \
--weights='' \
--weight_save_path=${SAVE_PATH}  \
2>&1 | tee  ${SAVE_PATH}"log.txt" &
