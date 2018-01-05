#' Rename an open session
#'
#' Renames an existing session.  This basically just adds a prefix to the existing session folder and updates all the sym-links.  It doesn't change the time stamp for the directory or anything else.
#'
#' @param sessionName The new session name to use.
#' @export
renameSession = function(sessionName){
  #Check init
  checkInit()
  #Check there is no active plot
  if(params$activePlot!=''){
    #The only time this will be allowed is if using continuous plotting mode
    if(params$contPlotting){
      #If we're doing this, we need to close the plot, then re-open it after changing directory
      unlink(params$activePlot)
    }else{
      stop("There is already an RLogBook plot active.  Close before renaming session.")
    }
  }
  #Existing directory
  oldDir = params$plotDir
  #New directory.  Strip any existing name
  nom = params$sessionDir
  if(params$sessionName!='')
    nom = substr(nom,nchar(params$sessionName)+2,nchar(nom))
  #Add new name
  if(sessionName!='')
    nom = paste0(nom,'_',sessionName)
  #Save updated params
  params$sessionName = sessionName
  params$sessionDir = nom
  params$plotDir = file.path(params$baseDir,params$sessionDir)
  file.rename(oldDir,params$plotDir)
  #Re-open the plot
  if(params$contPlotting){
    openPlot()
  }
  #Update sym-links (if there are any plots)
  if(file.exists(file.path(params$plotDir,params$latestName)))
    makeSymLinks(basename(normalizePath(file.path(params$plotDir,params$latestName))))
}
