#!/usr/bin/env nextflow

process upload{
    tag "${meta}"
    label 'process_low'

    publishDir "${params.outdir}/logfiles/${meta}/${type}",
        mode: "copy",
        overwrite: true,
	    pattern: "*.logfile",
        saveAs: { filename -> filename }
 
    container "alemenze/rclone"
    containerOptions "-v $params.rclone_config:/root/.config/rclone"

    input:
        tuple val(meta), path(datapath), path(md5s)
        val(type)

    output:
        path("*.logfile"), emit: logfile

    script:
        """
	    cp $md5s $datapath/$md5s
        rclone copy $datapath $params.target/${type}/NewData/${meta} --log-file ${meta}_${type}.logfile
        """
}