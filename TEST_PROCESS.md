# Test process

docker build -t famjean/dock_n_roll:latest .

1/ launch normal mode: check opening is ok (interface, r customizations, rstudio customizations, mran, versions, keyboard, mouse, wd) and quit :
xhost local:root # To correct bug for ubuntu X11
docker run -it -v ~/Desktop/LinkFile:/home/LinkFile  -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY famjean/dock_n_roll

2/ launch commit mode
NAMEROLLR="roll_r404"
docker run -d -it -v ~/Desktop/LinkFile:/home/LinkFile -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY famjean/dock_n_roll bash && NUMIMAGE=`docker ps |  grep "dock_n_roll" | tr "        " "\n" | sed -n '1p'` && docker exec -it $NUMIMAGE launch.sh && docker commit $NUMIMAGE $NAMEROLLR && docker stop $NUMIMAGE

3/ apply:
write.csv("ee","ee.csv")

4/ install package:
install.packages("meta") ; require( meta )

5/ check if linkfile is ok

6/ run something and plot something:
vector1 <- rnorm(100) ; factor1 <- factor(sample(c("A","B"),100,T)) ; lm( vector1 ~ factor1)-> lm1 ; summary(lm1); anova(lm1) ; plot(lm1) ; x11() ; plot(lm1,1)

7/ clone github project "DossierTest":
https://github.com/famjean/DossierTest.git

8/ launch script
9/ modify script commit and pull on github
10/ knit something for html docx and pdf formats
11/ quit
12/ reopen:
docker run -d -it -v ~/Desktop/LinkFile:/home/LinkFile -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY $NAMEROLLR bash && NUMIMAGE=`docker ps |  grep "roll_r404" | tr "        " "\n" | sed -n '1p'` && docker exec -it $NUMIMAGE launch.sh && docker commit $NUMIMAGE $NAMEROLLR && docker stop $NUMIMAGE

13/ check installed package: require(meta) and github
14/ test command roll_rXXX and shortcut
NAMEROLLR="roll_r404"

echo '#!/bin/bash
xhost local:root
NAMEROLLR="roll_r404"
docker run -d -it -v ~/Desktop/LinkFile:/home/LinkFile -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY $NAMEROLLR bash && NUMIMAGE=`docker ps |  grep "roll_r404" | tr "        " "\n" | sed -n '1p'` && docker exec -it $NUMIMAGE launch.sh && docker commit $NUMIMAGE $NAMEROLLR && docker stop $NUMIMAGE' > ~/$NAMEROLLR

sudo chmod 777 ~/$NAMEROLLR && sudo cp ~/$NAMEROLLR /usr/local/bin/ && rm ~/$NAMEROLLR

echo '[Desktop Entry] Version=1.0
Type=Application
Terminal=true
Name=Roll R404
Exec=/usr/local/bin/roll_r404
Icon=rlogo_icon
Categories=Application;' > ~/$NAMEROLLR.desktop

sudo cp ~/$NAMEROLLR.desktop /usr/share/applications/$NAMEROLLR.desktop && rm  ~/$NAMEROLLR.desktop

roll_r404

# then delete shortcut
sudo rm /usr/share/applications/$NAMEROLLR.desktop

# rebuild
docker build -t famjean/dock_n_roll:latest .

14/ save image as archive and pull it on dock hub and valid release:

docker save famjean/dock_n_roll:latest | gzip > UBUNTU.18.04.5_R.4.0.4_MRAN.2021-02-15.tgz

docker login --username=yourhubusername --password=yourpassword

docker images

NUMIMAGE=`docker images |  grep "dock_n_roll" | grep "latest" | tr "              " "\n" | sed -n '39p'`

# 18p or 39p

echo $NUMIMAGE

docker tag $NUMIMAGE famjean/dock_n_roll:UBUNTU.18.04.5_R.4.0.4_MRAN.2021-02-15

docker images

docker push famjean/dock_n_roll:latest && docker push famjean/dock_n_roll:UBUNTU.18.04.5_R.4.0.4_MRAN.2021-02-15

15/ Change the readme on https://hub.docker.com/

16/ Archive testing file in version file

17/ Git changes


CLEAN
# Delete contener : docker rm $(docker ps -a -f status=exited -f status=created -q)
