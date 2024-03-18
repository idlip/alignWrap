##' .. content for \description{} (no empty lines) ..
##'
##' Please refer the manpage for minimap2 via 'man minimap2' or 'minimap2 --help' in terminal
##' @title minimap wrapper
##' @param target
##' @param query
##' @param opts
##' @return
##' @author Dilip G
minimap2 <- function(target, query, opts = "") {
  .checkFiles(c(target, query))
  args <- c(target, query, opts)
  .execBin("echo", args)
}

## minimap2  [-H]  [-k  kmer]  [-w miniWinSize] [-I batchSize] -d target.mmi target.fa

minimap2Index <- function(save, inpfile, kmer = 15, targetram = "4G", opts = "") {
  .checkFiles(inpfile)
  if (kmer >= 28) {
    stop("k-mer size in minimap2Index() cannot be more than 28")
  }
  args <- c("-d", save, inpfile, "-k", kmer, "-I", targetram, opts)
  .execBin("echo", args)
}
