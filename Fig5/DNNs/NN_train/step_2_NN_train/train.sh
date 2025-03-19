#!/bin/bash
# EXPERIMENT_INDEX=$(date +"%Y%m%d_%H%M")
# EXPERIMENT_INDEX='20231218_1734'
NUM_EPOCHS=100
EXPERIMENT_INDEX='202404-full-l-r-04'
python train_MB.py  --num_epochs $NUM_EPOCHS --experiment_index $EXPERIMENT_INDEX
python evaluation_MB.py    --experiment_index $EXPERIMENT_INDEX

# EXPERIMENT_INDEX='202404-simple-l-r-02'
# python train_MB.py  --num_epochs $NUM_EPOCHS --experiment_index $EXPERIMENT_INDEX
# python evaluation_MB.py    --experiment_index $EXPERIMENT_INDEX

# EXPERIMENT_INDEX='202404-simple-l-r-03'
# python train_MB.py  --num_epochs $NUM_EPOCHS --experiment_index $EXPERIMENT_INDEX
# python evaluation_MB.py    --experiment_index $EXPERIMENT_INDEX

# EXPERIMENT_INDEX='202404-simple-r-r-04'
# python train_MB.py  --num_epochs $NUM_EPOCHS --experiment_index $EXPERIMENT_INDEX
# python evaluation_MB.py    --experiment_index $EXPERIMENT_INDEX

# EXPERIMENT_INDEX='202404-simple-l-r-05'
# python train_MB.py  --num_epochs $NUM_EPOCHS --experiment_index $EXPERIMENT_INDEX
# python evaluation_MB.py    --experiment_index $EXPERIMENT_INDEX

# EXPERIMENT_INDEX='202404-simple-l-r-06'
# python train_MB.py  --num_epochs $NUM_EPOCHS --experiment_index $EXPERIMENT_INDEX
# python evaluation_MB.py    --experiment_index $EXPERIMENT_INDEX

# EXPERIMENT_INDEX='202404-simple-l-r-07'
# python train_MB.py  --num_epochs $NUM_EPOCHS --experiment_index $EXPERIMENT_INDEX
# python evaluation_MB.py    --experiment_index $EXPERIMENT_INDEX

# EXPERIMENT_INDEX='202404-simple-l-r-08'
# python train_MB.py  --num_epochs $NUM_EPOCHS --experiment_index $EXPERIMENT_INDEX
# python evaluation_MB.py    --experiment_index $EXPERIMENT_INDEX

# EXPERIMENT_INDEX='202404-simple-l-r-09'
# python train_MB.py  --num_epochs $NUM_EPOCHS --experiment_index $EXPERIMENT_INDEX
# python evaluation_MB.py    --experiment_index $EXPERIMENT_INDEX

# EXPERIMENT_INDEX='202404-simple-l-r-10'
# python train_MB.py  --num_epochs $NUM_EPOCHS --experiment_index $EXPERIMENT_INDEX
# python evaluation_MB.py    --experiment_index $EXPERIMENT_INDEX