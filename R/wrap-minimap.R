## minimap2  [-H]  [-k  kmer]  [-w miniWinSize] [-I batchSize] -d target.mmi target.fa

##' mapping and alignment between DNA sequences using minimap2
##'
##' Minimap2  is a fast sequence mapping and alignment program that can find overlaps between long noisy reads, or map long reads or their assemblies to a reference genome optionally with detailed alignment (i.e. CIGAR). At present, it works efficiently with query sequences from a few kilobases to ~100 megabases in length at a error rate ~15%. Minimap2 outputs in the PAF or the SAM format.
##'
##' Please refer the manpage for minimap2 via 'man minimap2' or 'minimap2 --help' for help and documentation
##' @title minimap wrapper
##' @param target String for the indexed reference genome file name
##' @param query String for input fastq file for aligning.
##' @param opts Options or arguments to pass for minimap2 command
##' @return Returns the stdout from the logs
##' @export
##' @author Dilip G
minimap2 <- function(target, query, opts = "") {
  .checkFiles(c(target, query))
  args <- c(target, query, opts)
  .execBin("minimap2", args)
}


##' Indexing of reference genome using minimap2
##'
##' Indexer for aligning sequence against refernce using minimap2
##' @title minimap Indexer
##' @param save string of filename to output the aligned results
##' @param inpfile input fastq file for aligning
##' @param kmer k-mer size, default is 15
##' @param targetram number of target bases to load into memory for indexing
##' @param opts Options or arguments to pass for minimap2 command
##' @return Index file output with raw logs as displayed
##' @export
##' @author Dilip G
minimap2Index <- function(save, inpfile, kmer = 15, targetram = "4G", opts = "") {
  .checkFiles(inpfile)
  if (kmer >= 28) {
    stop("k-mer size in minimap2Index() cannot be more than 28")
  }
  args <- c("-d", save, inpfile, "-k", kmer, "-I", targetram, opts)
  .execBin("minimap2", args)
}
