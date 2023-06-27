#!/usr/bin/env nextflow

////////////////////////////////////////////////////
/* --              Parameter setup             -- */
////////////////////////////////////////////////////

////////////////////////////////////////////////////
/* --              IMPORT MODULES              -- */
////////////////////////////////////////////////////

include { md5checksums as md5checksums_bcls } from '../tools/md5/md5'
include { md5checksums as md5checksums_fastqs } from '../tools/md5/md5'
include { upload as upload_bcls } from '../tools/rclone/rclone'
include { upload as upload_fastqs } from '../tools/rclone/rclone'

////////////////////////////////////////////////////
/* --           RUN MAIN WORKFLOW              -- */
////////////////////////////////////////////////////

workflow Transfers {
    take:
        transfer_paths_bcls
        transfer_paths_fastq

    main:

        md5checksums_bcls(
            transfer_paths_bcls,
            "bcls"
        )

        md5checksums_fastqs(
            transfer_paths_fastq,
            "fastqs"
        )

        upload_bcls(
            md5checksums_bcls.out.paths_md5s,
            "bcls"
        )

        upload_fastqs(
            md5checksums_fastqs.out.paths_md5s,
            "fastqs"
        )    
}