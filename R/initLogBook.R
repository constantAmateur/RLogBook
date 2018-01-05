#' Initialise the logBook session.
#'
#' Initialises log Book parameters, starts a "session" (which is basically just a directory to store stuff).  This means making a directory.  Parameters are set in the following order:
#'  - package defaults.
#'  - previously set values in this R session.
#'  - values from RLOGBOOK_<> environmental variables.
#'  - values passed to this function.
#'
#' @param baseDir The top level directory where sessions are logged. Can be omitted if set by RLOGBOOK_baseDir or an earlier call to \code{initLogBook}.
#' @param ... Extra parameters to be set.
#' @return Nothing, but a new session is created and plots can now be logged.
#' @export
initLogBook = function(baseDir,...){
  theDots = list(...)
  if(!missing(baseDir))
    theDots$baseDir = baseDir
  #Initialise parameters
  initParams(theDots)
  #Create session directory and save it
  nom = paste0(params$sessionPrefix,format(Sys.time(),params$sessionDateFormat))
  if(params$sessionName!='')
    nom = paste0(nom,'_',params$sessionName)
  params$sessionDir = nom
  #Join with baseDir and create it
  params$plotDir = file.path(params$baseDir,params$sessionDir)
  dir.create(params$plotDir)
  params$readyToPlot = TRUE
  params$activePlot=''
  if(params$contPlotting){
    openPlot()
  }
}
