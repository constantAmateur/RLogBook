# R Log Book

This package has two purposes:
1. To provide a semi-permanent, semi-complete record of plots generated interactively and the code that was entered to generate them.
2. To make looking at plots generated interactively on remote machines less painful.

# Usage

```R
library(RLogBook)
initLogBook('~/RLogBook/')
op()
#Do your plotting here
cp()
```

You can avoiding having to re-enter your log directory by adding an environmental variable RLOGBOOK_baseDir=~/RLogBook/.

# Example use case

The primary use case is as follows.  I've logged into some remote large machine with my large data to do interactive computations and generate plots to understand it.  I want to view these plots on my local machine.  This can be slow and painful using X11 forwarding so instead I do something like:

1. Mount remote filesystem locally.
2. Wrap all plot statement in `png('/path/to/some/temp/file.png')` and `dev.off()`
3. Open temp file on local machine.

This package basically provides a quicker, more reliable and lower effort version of the above loop.  You define some sensible parameters like your "Log Book" directory up front.  Then plots are done in the following way:

```R
library(RLogBook)
initLogBook('~/RLogBook/')
op()
plot(1:10,(1:10)**2,'l')
lines(1:10,(1:10)**3,col='red')
cp()
```

R log book creates a unique "session folder" for each R session in "~/RLogBook/" (or any other directory you specify).  Each time you wrap a plot in `op` and `cp` it will create a uniquely named plot and sym-link it to "latest.png" in "~/RLogBook".  What this means is you just need to have your local machine pointed at "~/RLogBook/latest.png", make your plot inside calls to `op()` (or `openPlot()`) and `cp()` (or `closePlot()`), then hit refresh to view the plot.

It's still a bit ugly, but an improvement on what I was doing.
