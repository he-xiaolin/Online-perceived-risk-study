#!/bin/bash

# EXPERIMENT_INDEX=$(date +"%Y%m%d_%H%M")
EXPERIMENT_INDEX='20231219_2222'
python evaluation_AMB.py   --experiment_index $EXPERIMENT_INDEX
python evaluation_HB.py    --experiment_index $EXPERIMENT_INDEX
python evaluation_MAL_1.py   --experiment_index $EXPERIMENT_INDEX
python evaluation_MAL_2.py   --experiment_index $EXPERIMENT_INDEX
python evaluation_MAL_3.py   --experiment_index $EXPERIMENT_INDEX
python evaluation_MB.py    --experiment_index $EXPERIMENT_INDEX