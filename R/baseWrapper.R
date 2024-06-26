## A core set of functions

##' A generic function to check for executable command in the environment.
##' Used to check whether tool or command exists, and stop with error message.
##'
##' In unix system, you can refer 'man which'
##' @title binary command checker
##' @param bin string indicating the executable command
##' @return Boolean to check whether an executable command is available or not
##' @author Dilip G
##' @export
.checkBin <- function(bin) {
  rep <- Sys.which(bin)
  if (rep == "") {
    stop(bin, " command is not found. Please install it your OS or environment")
  }
}
##' Function that executes the given statement in system shell environment,
##' if command is found. Returns the output of the commands log.
##'
##' @title execute binary
##' @param bin string indicating the executable command
##' @param args arguments passed to the command
##' @return error if command is not found, else output log of the command run
##' @author Dilip G
##' @export
.execBin <- function(bin, args) {
  cliword <- unlist(strsplit(bin, " "))
  .checkBin(cliword[1])
  output <- system2(cliword[1], c(cliword[2], args))
  return(output)
}

##' Function to check if files exists, so command can proceed
##'
##' @title check File
##' @param file path string for the files
##' @return Boolean for existense of the files
##' @author Dilip G
##' @export
.checkFiles <- function(file) {
  for (eachfile in c(file)) {
    if (!file.exists(eachfile)) {
      stop(eachfile, " file does not exist in the given directory. Please fix the path")
    }
  }
  return(TRUE)
}
##' Function to extract gz files using gunzip command
##' Not meant to be used manually, only for running indexing command we make us of this.
##'
##' @title GzExtractor
##' @param file path string for the .gz files
##' @return Extracts the gunzip file
##' @examples
##' .extGz("human-refseq.fna.gz")
##' @author Dilip G
##' @export
.extGz <- function(file) {
  if (.checkFiles(file) && length(grep("*.gz", file))) {
    .execBin("gunzip", c("-k", file))
  }
}
