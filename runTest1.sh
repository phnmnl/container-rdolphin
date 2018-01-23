#!/bin/bash

R -e library(rDolphin);setwd(paste(system.file(package = "rDolphin"),"extdata",sep='/')); imported_data=import_data("Parameters_MTBLS242_15spectra_5groups.csv"); plot=exemplars_plot(imported_data)
