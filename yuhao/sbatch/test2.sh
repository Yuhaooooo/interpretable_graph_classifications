#!/bin/bash

#SBATCH --partition=SCSEGPU_UG
#SBATCH --qos=q_ug8
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8000M 
#SBATCH --job-name=job 

echo $PATH