#' Open a new plot
#'
#' Opens a new plot in the active session folder.  The plot will be named using the current time and the RLogBook params.
#'
#' @param plotName Extra name to prepend to automatic file name.
#' @param ... Extra arguments passed to plot creation function.
#' @return Nothing.
#' @aliases openPlot op
#' @export openPlot op
openPlot = op =  function(plotName,...){
  #Check if we have initialised things
  checkInit()
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
  argList = c(list(file.path(params$plotDir,params$plotName)),argList)
  #Open the plot
  do.call(params$plotEngine,argList)
}
