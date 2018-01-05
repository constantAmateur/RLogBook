#' Open a new plot
#'
#' Opens a new plot in the active session folder.  The plot will be named using the current time and the RLogBook params.
#'
#' @param plotName Extra name to append to automatic file name.
#' @param ... Extra arguments passed to plot creation function.
#' @return Nothing.
#' @aliases openPlot op
#' @export openPlot op
openPlot = op =  function(plotName,...){
  #Check if we have initialised things
  checkInit()
  #Check if there is an active plot.
  if(params$activePlot!=''){
    #Don't allow a new plot until the old one is closed. We shan't allow more than one active plot at a time, that's not the point of this.
    if(params$contPlotting){
      #The exception is continuous plotting mode, where there should always be an active plot.  In this case, kill it with fire and we can then open a new one with the parameters specified.
      unlink(params$activePlot)
    }else{
      stop("There is already an RLogBook plot active.  Close this before opening a new plot.")
    }
  }
  #Construct name
  nom = paste0(params$plotPrefix,format(Sys.time(),params$plotDateFormat))
  if(!missing(plotName))
    nom = paste0(nom,'_',plotName)
  plotExt = gsub('.*\\.','.',params$latestName)
  nom = paste0(nom,plotExt)
  params$plotName = nom
  #Construct the argument list by mashing together the defaults in params with anything in ...
  argList = params$plotParams
  theDots = list(...)
  for(nom in names(theDots))
    argList[[nom]] = theDots[[nom]]
  #Make the filename the first argument always (the filename argument name varies by plot type)
  fnom = file.path(params$plotDir,params$plotName)
  argList = c(list(fnom),argList)
  #Open the plot
  do.call(params$plotEngine,argList)
  #This plot is now the active plot.  So record it as such.
  params$activePlot=fnom
}
