# Dock_n_Roll  
Get stable versions of R, Rstudio, Git and Latex with graphical user interface through X11 socket mounting on a docker container.

***   

version 0.0.1 alpha   

***   
## Overview
This project contains scripts and indication to create and run a docker container image with a graphical user interface (GUI) with R, Rstudio, Git and Latex. It allows to fix versions of programs and use it in a graphical mode.  

For the R packages stability we used in addition of the checkpoint package (Microsoft Corporation (2018). checkpoint: Install Packages from Snapshots on the Checkpoint Server for Reproducibility. https://CRAN.R-project.org/package=checkpoint) to fix packages to date of release of R version. Hence your analysis will be perfectly replicable.

Git and Latex are provided to permit use of Rmarkdown to create reports.

***
## How to use
Create image when you are in the file with Dockerfile with:
sudo docker build -t famjean/dock_n_roll:xenial_3.5.1 .

Next launch image:
xhost local:root
docker run -it  \
        -v /home/Input:/~/Desktop/Input \
        -v /home/Output:/~/Desktop/Output  \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY \
        famjean/dock_n_roll:xenial_3.5.1

# Create on your Desktop an Output and an Input file. There will be connected with the same file inside your containre.
# Save files in Output when you are working in the container.
***
## Bug Report   
Fill free to report bugs and difficulties in Issues.
