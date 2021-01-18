#!/bin/bash

#SBATCH --partition=SCSEGPU_UG
#SBATCH --qos=q_ug8
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8000M 
#SBATCH --job-name=job 

module load anaconda
source /home/FYP/heyu0012/.bashrc
conda activate GCNN_GAP_graphgen
conda env list

MODEL=DFScodeRNN_cls_LSTM
DATA=MUTAG
EPOCH=50
NUMBER_OF_RNN_LAYER=1
EMBEDDING_SIZE=8
HIDDEN_SIZE=4
NUMBER_OF_MLP_LAYER=0
LEARNING_RATE=0.003


ROOT=/home/FYP/heyu0012/projects/interpretable_graph_classifications

BASE_PATH=${ROOT}/data/${DATA}/
export BASE_PATH=$BASE_PATH

# add graphgen bin for generating dfs code
export PATH=${ROOT}/models/graphgen/bin:/$PATH

cd $ROOT

CUDA_VISIBLE_DEVICES=0 python main.py\
    -gm=$MODEL\
    -data=$DATA\
    -epoch=$EPOCH\
    -number_of_rnn_layer=$NUMBER_OF_RNN_LAYER\
    -embedding_size=$EMBEDDING_SIZE\
    -hidden_size=$HIDDEN_SIZE\
    -number_of_mlp_layer $NUMBER_OF_MLP_LAYER\
    -learning_rate=$LEARNING_RATE

