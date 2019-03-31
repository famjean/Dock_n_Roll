# Dock_n_Roll  
Get stable versions of R, R packages, Rstudio, Git and Latex with graphical user interface through X11 socket mounting on a docker container and checkpoint R package.

***   

version 0.0.1 alpha   

***   
## Overview
This project contains scripts and indications to create and run a docker container image with a graphical user interface (GUI) with R, Rstudio, Git and Latex. It allows to fix versions of programs and of R packages and use it in a graphical mode.  

For the R packages stability we used in addition of the checkpoint package (Microsoft Corporation (2018). checkpoint: Install Packages from Snapshots on the Checkpoint Server for Reproducibility. https://CRAN.R-project.org/package=checkpoint) to fix packages to date of release of R version. Hence your analysis will be perfectly replicable.

Pandoc and Latex are provided to permit use of Rmarkdown to create reports.

Git allows to manage versions of your projects.

***
## How to use
### Install
+ install docker (for windows xming in addition and for macos socat and xquartz in addition)
+ Create on your Desktop an LinkFile file. It will be connected with the same file inside your container.
+ Put file in LinkFile before working with container.  
+ Save files in LinkFile when you are working in the container.   

### Launch image (could take a while for packages loading, more if you are not online):   
####For linux:
```bash
xhost local:root # To correct bug for ubuntu X11
docker run -it -v ~/Desktop/LinkFile:/home/LinkFile  -v ~/OneDrive13/Git:/home/Gits  -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY famjean/dock_n_roll  
```

#### For windows:  
```bash
xming :0 -ac -clipboard -multiwindow   
docker run -it -e DISPLAY=hostip:0   -v c:/Users/Desktop/LinkFile:/home/LinkFile famjean/dock_n_roll
```

#### For macos:  
```bash
brew install socat  
brew cask install xquartz   
open -a XQuartz  
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"   
docker run -it -e DISPLAY=hostip:0 -v ~/Desktop/LinkFile:/home/LinkFile famjean/dock_n_roll
```

### More:
See a good [tutorial](http://somatorio.org/en/post/running-gui-apps-with-docker/) for more details on adding function for docker's containers.

See the [documentation](https://docker-curriculum.com/) for docker.

See [example](https://www.r-bloggers.com/running-your-r-script-in-docker/amp/) of using docker container with R without GUI.

***
## Commit changes in image   
```bash
# Before launching, be sure that no images with the same name is running with docker ps
#Launch:
xhost local:root # for linux
docker run -d -it -v ~/Desktop/LinkFile:/home/LinkFile -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY famjean/dock_n_roll bash && NUMIMAGE=`docker ps |  grep "famjean" | tr "        " "\n" | sed -n '1p'` && docker exec -it $NUMIMAGE launch.sh && docker commit $NUMIMAGE new_name && docker stop $NUMIMAGE
#Relaunch
docker run -d -it -v ~/Desktop/LinkFile:/home/LinkFile -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY new_name bash && NUMIMAGE=`docker ps |  grep "new_name" | tr "        " "\n" | sed -n '1p'` && docker exec -it $NUMIMAGE launch.sh && docker commit $NUMIMAGE new_name && docker stop $NUMIMAGE
```

***
## Generate image from Dockerfile and save it
```bash
#Put you in the file with Dockerfile and other files (use cd or equivalent).
docker build -t famjean/dock_n_roll:latest -t famjean/dock_n_roll:latest .
# tag image
docker tag d61 famjean/dock_n_roll:UBUNTU.16.04.6_R.3.5.3_MRAN.2019-03-11
#Save image
docker save famjean/dock_n_roll:latest | gzip > UBUNTU.16.04.6_R.3.5.3_MRAN.2019-03-11.tgz
#Load image
gunzip -c UBUNTU.16.04.5_R.3.5.1_MRAN.2018-12-20.tgz | docker load
```

***
## Bug Report   
Fill free to report bugs and difficulties in Issues.

***
## Known Issues
+ lme4 is pre-installed beceause an issue in installing minqa dependancy when open message is activated. So, just require(lme4) and do not install it.
