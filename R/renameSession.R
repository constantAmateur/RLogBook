#' Rename an open session
#'
#' Renames an existing session.  This basically just adds a prefix to the existing session folder and updates all the sym-links.  It doesn't change the time stamp for the directory or anything else.
#'
#' @param sessionName The new session name to use.
#' @export
renameSession = function(sessionName){
  #Check init
  checkInit()
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
  #Update sym-links
  makeSymLinks(basename(normalizePath(file.path(params$plotDir,params$latestName))))
}
