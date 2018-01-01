#' Checks log book has been initialised.
#' 
#' Checks that the required initialisation parameters exist and are sane.
#'
#' @return None.  An error if initialisation not complete.
checkInit = function(){
  #Check init run correctly
  if(!('initialised' %in% names(params)) | !('readyToPlot' %in% names(params)))
    stop("Session not initialised, run initLogBook.")
  #Make sure plot directory exists
  if(!dir.exists(params$plotDir))
    stop("Session directory is not available.")
}

