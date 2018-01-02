#' Closes previously opened plot.
#'
#' Closes plot.  Updates latest plot and history file.
#'
#' @return Nothing.
#' @export closePlot cp
#' @aliases closePlot cp
#' @importFrom grDevices dev.off
#' @importFrom utils savehistory
closePlot = cp =  function() {
  #Should we save history too?
  if(params$saveHistory){
    tgt = file.path(params$plotDir,params$historyName)
    savehistory(tgt)
  }
  #Close the plot
  dev.off()
  #Make a symlink to latest.png
  makeSymLinks()
  #If we want to do any other custom BS do it here.
}
