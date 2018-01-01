#' Closes previously opened plot.
#'
#' Closes plot.  Updates latest plot and history file.
#'
#' @return Nothing.
#' @export
cp = closePlot = function() {
  #Should we save history too?
  if(params$saveHistory){
    tgt = file.path(params$plotDir,params$historyName)
    savehistory(tgt)
  }
  #Close the plot
  dev.off()
  #Work out which file to link to latest.png.  Could just use params$plotName, but this can be unreliable
  tmp = file.info(list.files(params$plotDir))
  srcFile = rownames(tmp)[which.max(tmp$mtime)]
  if(length(srcFile)==0)
    srcFile=params$plotName
  #Make a symlink to latest.png
  tgt = file.path(params$plotDir,params$latestName)
  tgtGlob = file.path(params$baseDir,params$latestName)
  #Remove it, if it's there.
  unlink(tgt)
  unlink(tgtGlob)
  #And make it.  Make it relative within the directory and don't fuck with our current working directory
  system(sprintf('cd %s && ln -s %s %s',params$plotDir,srcFile,params$latestName))
  system(sprintf('cd %s && ln -s %s %s',params$baseDir,file.path(params$sessionDir,srcFile),params$latestName))
  #If we want to do any other custom BS do it here.
}
