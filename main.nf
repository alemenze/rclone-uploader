#!/usr/bin/env nextflow
/*
                              (╯°□°)╯︵ ┻━┻

========================================================================================
                Workflow for uploading data using rsync to a managed environment
========================================================================================
                  https://github.com/alemenze/rsync-uploader
*/

nextflow.enable.dsl = 2

def helpMessage(){
    log.info
}

// Show help message
if (params.help) {
    helpMessage()
    exit 0
}


////////////////////////////////////////////////////
/* --              Parameter setup             -- */
////////////////////////////////////////////////////
if (params.samplesheet) {file(params.samplesheet, checkIfExists: true)} else { exit 1, 'Samplesheet file not specified!'}

////////////////////////////////////////////////////
/* --              IMPORT MODULES              -- */
////////////////////////////////////////////////////

include { Transfers } from './modules/main_workflows/transfers'

////////////////////////////////////////////////////
/* --           RUN MAIN WORKFLOW              -- */
////////////////////////////////////////////////////

Channel
    .fromPath(params.samplesheet)
    .splitCsv(header:true)
    .map{ row -> tuple(row.project_name,row.bcl_path)}
    .set { transfer_paths_bcls }

Channel
    .fromPath(params.samplesheet)
    .splitCsv(header:true)
    .map{ row -> tuple(row.project_name,row.fastq_path)}
    .set { transfer_paths_fastq }

workflow {
    Transfers(
        transfer_paths_bcls,
        transfer_paths_fastq
    )
}