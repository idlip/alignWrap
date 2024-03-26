bowtieIndex <- function(opts = "", threads = 4, refgen, outfile) {
  .checkFiles(refgen)
  args <- c(opts, "--threads", threads, refgen, outfile)
  .execBin("echo", args)
}

bowtie2 <- function(opts = "", threads = 4) {
  args <- c(opts, "--threads", threads)
  .execBin("echo", args)
}
