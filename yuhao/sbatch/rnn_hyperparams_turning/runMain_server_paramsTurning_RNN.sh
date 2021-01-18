
MODEL=DFScodeRNN_cls_LSTM
# MODEL=DFScodeRNN_cls_GRU

DATA=MUTAG
# DATA=NCI-H23
# DATA=TOX21_AR
# DATA=PTC_FR

epochs=(50 100)
number_of_rnn_layers=(1 2)
embedding_sizes=(8 16)
hidden_sizes=(4 8)
number_of_mlp_layers=(0 1 2)
learning_rates=(0.0001 0.0003 0.001 0.003 0.01)

for epoch in "${epochs[@]}"
do
    for number_of_rnn_layer in "${number_of_rnn_layers[@]}"
    do
        for embedding_size in "${embedding_sizes[@]}"
        do
            for hidden_size in "${hidden_sizes[@]}"
            do 
                for number_of_mlp_layer in "${number_of_mlp_layers[@]}"
                do
                    for learning_rate in "${learning_rates[@]}"
                    do
                        sbatch runMain_server_RNN.sh\
                            -M $MODEL\
                            -D $DATA\
                            -E $epoch\
                            -N $number_of_rnn_layer\
                            -e $embedding_size\
                            -h $hidden_size\
                            -n $number_of_mlp_layer\
                            -l $learning_rate
                    done
                done
            done
        done
    done
done
