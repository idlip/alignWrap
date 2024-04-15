##' RNA Spliced Transcripts Alignment to a Reference
##'
##' An rna sequence aligner that is fast and accurate
##' @title STAR wrapper
##' @param gendir string of file path for genomic files
##' @param inpfiles string or combined function of input fastq files for aligning
##' @param threads Threading process to be allocated, default is 4
##' @param opts Options or arguments to be passed for 'STAR' command
##' @return Aligned results of input sequences against a reference, output in sam file format.
##' @export
##' @author Dilip G
starIndex <- function(gendir, inpfiles, threads = 4, opts = "") {
  .checkFiles(inpfiles)
  if (!dir.exists(gendir)) {
    stop(gendir, " directory does not exist. Please fix or make directory to proceed.")
  }
  args <- c(opts, "--runThreadN", threads, "--genomeDir", gendir, "--readFilesIn", inpfiles)
  .execBin("STAR", args)
}
