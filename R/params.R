#' Define an environment to hold package params and define some defaults
params = new.env()
#Should we save history as well as the plots
params$saveHistory=TRUE
#What to call the saved history
params$historyName='sessionHistory'
#A special name for this session.
params$sessionName=''
#Prefix given to every session
params$sessionPrefix='session'
#Timestamp format given to every session as a suffix
params$sessionDateFormat='%Y%m%d_%H_%M_%S'
#Prefix given to every plot
params$plotPrefix='plot'
#Timestamp format given to every plot as a suffix
params$plotDateFormat='%Y%m%d_%H_%M_%S'
#Name of file that will always be symlinked to latest plot
params$latestName='latest.png'
#Function used to make plots.  Default guesses from file extension of latestName
params$plotEngine=get(gsub('.*\\.','',params$latestName))
#Any extra params to set when making plots.  If not using png (and you probably should use png), 
params$plotParams=list(width=10,
                       height=10,
                       units='in',
                       res=500)
#Should we use "Continuous plotting" mode, where a new plot device is created every time we finish a plot
params$contPlotting=TRUE


