##' bowtie indexing from given reference genome
##'
##' Use combined function to make sure of bowtie arguments as options
##'
##' please refer 'bowtie2-build --help' for documentation.
##' @title bowtieIndexing
##' @param opts Options/arguments passed for bowtie index command.
##' @param threads Threading process to be allocated, default is 4
##' @param refgen string file path to Reference genome
##' @param outfile string for output file name
##' @return Indexed files and the output results for further aligning step.
##' @export
##' @author Dilip G
bowtieIndex <- function(opts = "", threads = 4, refgen, outfile) {
  .checkFiles(refgen)
  args <- c(opts, "--threads", threads, refgen, outfile)
  .execBin("bowtie2-build", args)
}

##'  An ultrafast memory-efficient short read aligner
##'
##' Use combined function c() to pass in arguments as options
##'
##' please refer 'bowtie2 --help' for documentation/
##' @title bowtie
##' @param opts Options/arguments passed for bowtie index command.
##' @param threads Threading process to be allocated, default is 4
##' @param refgen string file path to Reference genome
##' @param outfile string for output file name
##' @return Aligned sam files
##' @export
##' @author Dilip G
bowtie2 <- function(opts = "", threads = 4) {
  args <- c(opts, "--threads", threads)
  .execBin("bowtie2", args)
}
