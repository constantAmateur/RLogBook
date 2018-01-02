#' Make symbolic links.
#'
#' Make symbolic links pointing to latest plot.
#'
#' @param srcFile Which plot to sym link to.  Must be relative to sessionDir.  If NULL try and guess it from modification time or params$plotName.
makeSymLinks = function(srcFile=NULL){
  if(!is.null(srcFile)){
    if(!file.exists(file.path(params$plotDir,srcFile))){
      stop("Target plot does not exist!")
    }
  }else{
    #Work out which file to link to latest.png.  Could just use params$plotName, but this can be unreliable
    tmp = file.info(list.files(params$plotDir))
    srcFile = rownames(tmp)[which.max(tmp$mtime)]
    if(length(srcFile)==0){
      srcFile=params$plotName
    }
  }
  #Two links to make
  tgt = file.path(params$plotDir,params$latestName)
  tgtGlob = file.path(params$baseDir,params$latestName)
  #Remove it, if it's there.
  unlink(tgt)
  unlink(tgtGlob)
  #And make it.  Make it relative within the directory and don't fuck with our current working directory
  system(sprintf('cd %s && ln -s %s %s',params$plotDir,srcFile,params$latestName))
  system(sprintf('cd %s && ln -s %s %s',params$baseDir,file.path(params$sessionDir,srcFile),params$latestName))
}
