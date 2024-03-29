# Dock_n_Roll  
Get stable versions of R, R packages, Rstudio, Git and Latex with a graphical user interface through X11 socket mounting on a docker container and checkpoint R package.

***   

version 0.0.1 alpha   

***   
## Overview
This project contains scripts and indications to create and run a docker container image with a graphical user interface (GUI) with R, Rstudio, Git and Latex. It allows to fix versions of programs and of R packages and use it in a graphical mode.  

For the R packages stability we used in addition of the checkpoint package (Microsoft Corporation (2018). checkpoint: Install Packages from Snapshots on the Checkpoint Server for Reproducibility. https://CRAN.R-project.org/package=checkpoint) to fix packages to date of release of R version. Hence your analysis will be perfectly replicable.

Pandoc and Latex are provided to permit the use of Rmarkdown to create reports.

Git allows managing versions of your projects.

***
## How to use 
### Install
+ install docker (for windows xming in addition and for macos socat and xquartz in addition)
+ Create on your Desktop and LinkFile file. It will be connected with the same file inside your container.
+ Put the file in LinkFile before working with a container.  
+ Save files in LinkFile when you are working in the container.   

### Launch image (could take a while for packages loading, more if you are not online):   
####For linux:
```bash
sudo apt-get install dbus-x11 # To correct bug for ubuntu X11
xhost +local:docker # To correct bug for ubuntu X11
docker run -it --privileged -v ~/Desktop/LinkFile:/home/LinkFile  -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY famjean/dock_n_roll  
```

#### For windows:  
```bash
xming :0 -ac -clipboard -multiwindow   
docker run -it --privileged -e DISPLAY=hostip:0   -v c:/Users/Desktop/LinkFile:/home/LinkFile famjean/dock_n_roll
```

#### For macos:  
```bash
brew install socat  
brew cask install xquartz   
open -a XQuartz  
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"   
docker run -it --privileged -e DISPLAY=hostip:0 -v ~/Desktop/LinkFile:/home/LinkFile famjean/dock_n_roll
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
xhost +local:docker # for linux
NAMEROLLR="roll_rXXX" # replace XXX by R version number
docker run -d -it --privileged -v ~/Desktop/LinkFile:/home/LinkFile -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY famjean/dock_n_roll bash && NUMIMAGE=`docker ps |  grep "dock_n_roll" | tr "        " "\n" | sed -n '1p'` && docker exec -it --privileged $NUMIMAGE launch.sh && docker commit $NUMIMAGE $NAMEROLLR && docker stop $NUMIMAGE

#Relaunch
docker run -d -it --privileged -v ~/Desktop/LinkFile:/home/LinkFile -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY $NAMEROLLR bash && NUMIMAGE=`docker ps |  grep "roll_rXXX" | tr "        " "\n" | sed -n '1p'` && docker exec -it --privileged $NUMIMAGE launch.sh && docker commit $NUMIMAGE $NAMEROLLR && docker stop $NUMIMAGE

# For linux users: create an executable script launchable and a shortcut for the menu
NAMEROLLR="roll_rXXX" # replace XXX by R version number

# replace XXX by R version number
echo '#!/bin/bash
xhost local:root
NAMEROLLR="roll_rXXX"
docker run -d -it --privileged -v ~/Desktop/LinkFile:/home/LinkFile -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY $NAMEROLLR bash && NUMIMAGE=`docker ps |  grep "roll_rXXX" | tr "        " "\n" | sed -n '1p'` && docker exec -it --privileged $NUMIMAGE launch.sh && docker commit $NUMIMAGE $NAMEROLLR && docker stop $NUMIMAGE' > ~/$NAMEROLLR

sudo chmod 777 ~/$NAMEROLLR && sudo cp ~/$NAMEROLLR /usr/local/bin/ && rm ~/$NAMEROLLR

# replace XXX by R version number
echo '[Desktop Entry] Version=1.0
Type=Application
Terminal=true
Name=Roll RXXX
Exec=/usr/local/bin/roll_rXXX
Icon=rlogo_icon
Categories=Application;' > ~/$NAMEROLLR.desktop

sudo cp ~/$NAMEROLLR.desktop /usr/share/applications/$NAMEROLLR.desktop && rm  ~/$NAMEROLLR.desktop

# To launch
roll_rXXX # replace XXX by R version number
# or go to the launcher
```

***
## Generate image from Dockerfile and save it
```bash
# see last ubuntu version
docker run ubuntu:focal cat /etc/issue
#Put you in the file with Dockerfile and other files (use cd or equivalent).
docker build -t famjean/dock_n_roll:latest .
# tag image
docker images
NUMIMAGE=`docker images |  grep "dock_n_roll" | grep "latest" | tr "              " "\n" | sed -n '39p'` # 18p or 39p
docker tag $NUMIMAGE famjean/dock_n_roll:UBUNTU.XX.XX.X_R.X.X.X_MRAN.X-XX-XX  # replace XXX by version numbers and dates
#Save image
docker save famjean/dock_n_roll:latest | gzip > UBUNTU.XX.XX.X_R.X.X.X_MRAN.X-XX-XX.tgz
#Load image
gunzip -c UBUNTU.XX.XX.X_R.X.X.X_MRAN.X-XX-XX.tgz | docker load
```

***
## Bug Report   
Fill free to report bugs and difficulties in Issues.

***
## Known Issues
+ lme4 is pre-installed because of an issue in installing minqa dependency when the open message is activated. So, just require(lme4) and do not install it.
+ a .Rprofile file is needed for each project reprository for R 4.0.1
