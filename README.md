# rclone-uploader
![GitHub last commit](https://img.shields.io/github/last-commit/alemenze/rclone-uploader)
[![Nextflow](https://img.shields.io/badge/nextflow%20DSL2-%E2%89%A520.11.0--edge-23aa62.svg?labelColor=000000)](https://www.nextflow.io/)
[![run with docker](https://img.shields.io/badge/run%20with-docker-0db7ed?labelColor=000000&logo=docker)](https://www.docker.com/)
[![run with singularity](https://img.shields.io/badge/run%20with-singularity-1d355c.svg?labelColor=000000)](https://sylabs.io/docs/)
[![run with GCP](https://img.shields.io/badge/run%20with-GCP-ffff00.svg?labelColor=000000&logo=googlecloud)](https://cloud.google.com/)
[![run with slurm](https://img.shields.io/badge/run%20with-slurm-ff4d4d.svg?labelColor=000000)](https://slurm.schedmd.com/)

## Description
This tool is meant to facilitate upload batches using rsync to managed bucket storage. You must first generate your config file (or use the parameters) to define your target location and your rclone config file. 

Usage:
```bash
    nextflow run alemenze/rsync-uploader \
    --samplesheet ./metadata.csv \
    -c config \
    -profile docker
```

Mandatory for full workflow:
    --samplesheet               CSV file with information on the samples (see example)
    -c                          Config file with preset details
    -profile                    Currently available for docker (local) or singularity (HPC local), or slurm (HPC multi node)

RClone parameters
    --rclone_config             Config file from RClone. This is required if you are using any kind of secrets
    --target                    Target bucket or location for data deposition

