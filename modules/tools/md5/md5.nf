#!/usr/bin/env nextflow

process md5checksums{
    tag "${meta}"
    label 'process_low'

    container "python:3.12.0b3"

    publishDir "${params.outdir}/md5s/${meta}/${type}",
        mode: "copy",
        overwrite: true,
	pattern: "md5_*.csv",
        saveAs: { filename -> filename }

    input:
        tuple val(meta), path(datapath)
        val(type)

    output:
        tuple val(meta), path(datapath), path("*.csv"), emit: paths_md5s

    script:
        """
        md5.py \\
            $datapath \\
            md5_${type}.csv \\
	        ${meta}
        """
}