starIndex <- function(gendir, inpfiles, threads = 4, opts = "") {
  .checkFiles(inpfiles)
  if (!dir.exists(gendir)) {
    stop(gendir, " directory does not exist. Please fix or make directory to proceed.")
  }
  args <- c(opts, "--runThreadN", threads, "--genomeDir", gendir, "--readFilesIn", inpfiles)
  .execBin("echo", args)
}
