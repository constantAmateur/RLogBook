% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/makeSymLinks.R
\name{makeSymLinks}
\alias{makeSymLinks}
\title{Make symbolic links.}
\usage{
makeSymLinks(srcFile = NULL)
}
\arguments{
\item{srcFile}{Which plot to sym link to.  Must be relative to sessionDir.  If NULL try and guess it from modification time or params$plotName.}
}
\description{
Make symbolic links pointing to latest plot.
}
