##' bwa indexing from given input fasta sequence file.
##' The function executes `bwa index` with given opts and file as argument
##'
##' Use combine function to write required options
##'
##'   -a: STR    BWT construction algorithm: bwtsw, is or rb2 [auto]
##'
##'   -p: STR    prefix of the index [same as fasta name]
##'
##'   -b: INT    block size for the bwtsw algorithm (effective with -a bwtsw) [10000000]
##'
##'   -6:        index files named as <in.fasta>.64.* instead of <in.fasta>.*
##'
##' please do check bwa readme
##' @title bwaIndex
##' @param opts Options used for `bwa index` command.
##' @param file input reference fasta file to index
##' If the file is in gz, function will try to extract it using gunzip
##' @return Stdout from bwa command and generates index files from bwa to be used for aligning
##' @examples
##' bwaIndex("human-refgen.fa", c("-p 'indexed-'"))
##' bwaIndex("danio-reg.fna.gz") # Indexing without any options passed
##' @export
##' @author Dilip G
bwaIndex <- function(file, opts = c("-a 'bwtsw'", "-p 'indexed-'")) {
  .checkFiles(file)
  .extGz(file)
  args <- c(file, opts)
  .execBin("bwa index", args)
}

##' bwa-mem to align the sequence to reference
##'
##' The preffered algorithm to align short read sequences onto reference genome
##' using burrows wheeler transform with maximum exact match method.
##'
##' please refer 'bwa mem' for options and arguments to be passed
##' @title bwa
##' @param indfile string of indexed file name with path
##' @param inpfile string of input raw fastq file to be aligned
##' @param outfile string for output file name
##' @param threads Threading process to be allocated, default is 4
##' @param opts Options used for `bwa mem` command.
##' @param file input reference fasta file to index
##' If the file is in gz, function will try to extract it using gunzip
##' @return The aligned sequence files in sam format
##' @export
##' @author Dilip G
bwaMem <- function(indfile, inpfile, outfile, threads = 4, opts = c("")) {
  .checkFiles(inpfile)
  .checkFiles(indfile)
  if (file.exists(outfile)) {
    stop("There is already a file with named ", outfile)
  }
  if (is.numeric(threads)) {
    threadnum <- c("-t", threads)
  }
  outfile <- c("-o", outfile)
  args <- c(indfile, inpfile, outfile, threadnum, opts)
  .execBin("bwa mem", args)
}

##' gapped and ungapped alignment using bwa
##'
##' perform gapped or ungapped alignment of sequences
##'
##' please refer 'bwa aln' command for help and arguments options.
##' @title bwa aln
##' @param prefix string of prefix name to be passed for output files
##' @param inpfile string of input raw fastq file to be aligned
##' @param opts Options used for `bwa aln` command.
##' @return aligned sequences
##' @export
##' @author Dilip G
bwaAln <- function(prefix, inpfile, opts) {
  .checkFiles(inpfile)
  args <- c(prefix, inpfile, opts)
  .execBin("bwa aln", args)
}

##' Identify super-maximal exact matches using bwa
##'
##' For quick and efficient aligning of sequences using SMEM
##'
##' please refer 'bwa fastmap' for help and documentation.
##' @title bwa fastmap
##' @param indfile String of index file name with path
##' @param inpfile string of input raw fastq file to be aligned
##' @param opts Options used for `bwa aln` command.
##' @return Quick aligned results in sam file format
##' @export
##' @author Dilip G
bwaFastmap <- function(indfile, inpfile, opts) {
  .checkFiles(indfile)
  .checkFiles(inpfile)
  args <- c(indfile, inpfile, opts)
  .execBin("bwa fastmap", args)
}

##' merge overlapping paired ends
##'
##' An experimental algorithm to find overlapping region.
##'
##' please refer 'bwa pemerge' for help and documenation.
##' @title bwa pemerge
##' @param inpfile1 string of first input fastq file name
##' @param inpfile2 string of second input fastq file name
##' @param opts Options used for `bwa aln` command.
##' @return output results of overlapped data
##' @export
##' @author Dilip G
bwaPemerge <- function(inpfile1, inpfile2, opts) {
  .checkFiles(inpfile1)
  .checkFiles(inpfile2)
  args <- c(inpfile1, inpfile2, opts)
  .execBin("bwa pemerge", args)
}
