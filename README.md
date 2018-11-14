# PhenoCam Lab - Week 11
Lab materials for BIOL_368 Plant Ecophysiology at Macalester College (Fall 2018)

The week prior to this lab activity, we discussed PhenoCams and the PhenoCam network (https://phenocam.sr.unh.edu/webcam/) and how data from them can be used as a proxy for tracking plant leaf development. 

As a class, we read and discussed Wu et al. (2016) in Science (DOI: 10.1126/science.aad5068) and Richardson et al. (2018) in Nature (https://doi.org/10.1038/s41586-018-0399-1) and its accompanying blog write up (https://natureecoevocommunity.nature.com/users/82876-andrew-richardson/posts/37522-phenocams-have-an-eye-on-the-seasons-at-the-spruce-ecosystem-warming-experiment)  

The lab is broken into 3 parts - Part I is an exploration of 'Phenocam Explorer' http://explore.phenocam.us/, starting with Harvard Forest. Student examine start of season and end of season dates, as well as overlay MODIS EVI and NDVI data (recently also discussed in class). 
Part II is a practice in R/Rstudio using the script included here. Students practice using phenocamr to download data, again using the Harvard Forest data set. After producing plots in ggplot, they are challenged to pick a new phenocam location, and make the same plots, comparing how seasonality of greenness (here mean_gcc) changes with local climate and vegetation type. 
Part III continues with Harvard Forest data (I had to explain why it was all Harvard based so my students didn't think I was some elitist) downloaded from AmeriFlux (AMF) (http://ameriflux.lbl.gov/). I truncated the AMF data to start at 2008 to align with the early phenocam data. In Part III, we mainly focused on curating the data (removing -9999) and making a couple ggplots to look at overall trends. 
In summary, this lab allowed students to explore multiple datasets through different means, with the objective of practicing ggplot and being comfortable using new R packages with different functionalities (ie phenocamr). 
