#' Initialise parameters.  Internal function.
#'
#' Initialise parameters used by logBook.  See \code{\link{initLogBook}} for order of precedence when setting params.
#'
#' @param toSet List of parameters to be set.
#' @return The params object is updated, but nothing is returned.
initParams = function(toSet){
  theDots = list()
  #First try and update any of the core values from environmental variables
  for(nom in unique(c('baseDir',names(params)))){
    tmp = Sys.getenv(sprintf("RLOGBOOK_%s",nom))
    if(tmp!='')
      theDots[[nom]]=tmp
  }
  #Next try and use any of the supplied values
  for(nom in names(toSet))
    theDots[[nom]] = toSet[[nom]]
  #Check that we've got a minimal set of things
  if(!('baseDir' %in% names(params)) & !('baseDir' %in% names(theDots)))
    stop("baseDir must be specified.")
  if('baseDir' %in% names(theDots))
    if(!dir.exists(theDots[['baseDir']]))
      stop("baseDir must be a valid writeable directory.")
  #Finally set things
  for(nom in names(theDots))
    assign(nom,theDots[[nom]],envir=params)
  #Set flag to indicate we've initialised things
  assign('initialised',TRUE,envir=params)
}


