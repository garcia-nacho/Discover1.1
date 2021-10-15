#!/bin/bash
PATH="/home/docker/Scripts:/home/docker/miniconda3/bin:${PATH}"
source activate condaenv_discover
python discover.py -d Fastq -i illumina
