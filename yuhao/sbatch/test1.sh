#!/bin/sh

index=(1 2)

# TODO1 - mlp layers
# TODO2 - rename result log 

for i in "${index[@]}"
do
    sbatch test2.sh
done