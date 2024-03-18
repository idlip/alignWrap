##' bwa indexing from given input fasta sequence file.
##' The function executes `bwa index` with given opts and file as argument
##'
##' please do check bwa readme
##' @title bwaIndex
##' @param opts Options used for `bwa index` command.
##' Use combine function to write required options
##' -a: STR    BWT construction algorithm: bwtsw, is or rb2 [auto]
##' -p: STR    prefix of the index [same as fasta name]
##' -b: INT    block size for the bwtsw algorithm (effective with -a bwtsw) [10000000]
##' -6:        index files named as <in.fasta>.64.* instead of <in.fasta>.*
##' @param file input reference fasta file to index
##' If the file is in gz, function will try to extract it using gunzip
##' @return generates index files from bwa
##' @examples
##' bwaIndex(c("-p 'indexed-'"), "human-refgen.fa")
##' bwaIndex(, "danio-reg.fna.gz") # Indexing without any options passed
##' @author Dilip G
bwaIndex <- function(file, opts) {
  .checkFile(file)
  .extGz(file)
  args <- c(file, opts)
  .execBin("echo", args)
}

bwaMem <- function(indfile, inpfile, outfile, threads = 4, opts = c("")) {
  .checkFile(inpfile)
  .checkFile(indfile)
  if (file.exists(outfile)) {
    stop("There is already a file with named ", outfile)
  }
  if (is.numeric(threads)) {
    threadnum <- c("-t", threads)
  }
  outfile <- c("-o", outfile)
  args <- c(indfile, inpfile, outfile, threadnum, opts)
  .execBin("echo", args)
}

bwaAln <- function(prefix, inpfile, opts) {
  .checkFile(inpfile)
  args <- c(prefix, inpfile, opts)
  .execBin("echo", args)
}

bwaFastmap <- function(indfile, inpfile, opts) {
  .checkFile(indfile)
  .checkFile(inpfile)
  args <- c(indfile, inpfile, opts)
  .execBin("echo", args)
}

bwaPemerge <- function(inpfile1, inpfile2, opts) {
  .checkFile(inpfile1)
  .checkFile(inpfile2)
  args <- c(inpfile1, inpfile2, opts)
  .execBin("echo", args)
}
