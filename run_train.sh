SAVE_PATH=/data1/chenww/my_research/yolov3/output/1cls_896_bs8_ep300_scratch_oriAnachor_yolo3ori/
#SAVE_PATH=/data1/chenww/my_research/yolov3/output/temp/
rm -rf ${SAVE_PATH} ${SAVE_PATH}
mkdir ${SAVE_PATH}  ${SAVE_PATH}

nohup python train.py \
--cfg=/data1/chenww/my_research/yolov3/cfg/yolov3-1cls.cfg  \
--data=/data1/chenww/my_research/yolov3/data/d13/small_1cls/small_1cls.data  \
--epochs=300  \
--batch-size=8 \
--weight_save_path=${SAVE_PATH}  \
--weights='' \
2>&1 | tee  ${SAVE_PATH}"log.txt" &

#--weights=/data1/chenww/my_research/yolov3/weights/yolov3-spp.weights \
