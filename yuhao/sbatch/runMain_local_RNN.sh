#!/bin/bash

# module load anaconda
# source /home/FYP/heyu0012/.bashrc
# conda activate GCNN_GAP_graphgen
# conda env list

while getopts M:D:E:N:e:h:n:l: option
do
case "${option}"
in
M) MODEL=${OPTARG};;
D) DATA=${OPTARG};;
E) EPOCH=${OPTARG};;
N) NUMBER_OF_RNN_LAYER=${OPTARG};;
e) EMBEDDING_SIZE=${OPTARG};;
h) HIDDEN_SIZE=${OPTARG};;
n) NUMBER_OF_MLP_LAYER=${OPTARG};;
l) LEARNING_RATE=${OPTARG};;
esac
done

ROOT=/home/FYP/heyu0012/projects/interpretable_graph_classifications

BASE_PATH=${ROOT}/data/${DATA}/
export BASE_PATH=$BASE_PATH

# add graphgen bin for generating dfs code
export PATH=${ROOT}/models/graphgen/bin:/$PATH

cd $ROOT

python main.py\
    -gm=$MODEL\
    -data=$DATA\
    -epoch=$EPOCH\
    -number_of_rnn_layer=$NUMBER_OF_RNN_LAYER\
    -embedding_size=$EMBEDDING_SIZE\
    -hidden_size=$HIDDEN_SIZE\
    -number_of_mlp_layer $NUMBER_OF_MLP_LAYER\
    -learning_rate=$LEARNING_RATE

