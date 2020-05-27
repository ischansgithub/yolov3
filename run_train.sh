SAVE_PATH=/data1/chenww/my_research/yolov3/output/8cls_960_bs32_ep300_scratch_oriAnachor_tiny3se/
#SAVE_PATH=/data1/chenww/my_research/yolov3/output/temp/
rm -rf ${SAVE_PATH} ${SAVE_PATH}
mkdir ${SAVE_PATH}  ${SAVE_PATH}

nohup python train.py \
--cfg=/data1/chenww/my_research/yolov3/cfg/yolov3-tiny3-se-8cls.cfg  \
--data=/data1/chenww/my_research/yolov3/data/d13/small_8cls/small_8cls.data  \
--epochs=300  \
--batch-size=32 \
--weight_save_path=${SAVE_PATH}  \
--weights='' \
2>&1 | tee  ${SAVE_PATH}"log.txt" &

#--weights=/data1/chenww/my_research/yolov3/weights/yolov3-spp.weights \
