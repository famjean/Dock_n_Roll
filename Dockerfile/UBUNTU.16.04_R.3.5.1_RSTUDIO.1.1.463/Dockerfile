# Dockerfile for Dock_N_R
#------------------------

# Set OS
#-------
# Choose distribution to https://hub.docker.com/_/ubuntu/
# Define distribution
FROM ubuntu:xenial

# Update source list
RUN apt-get update

# Configure default locale, see https://github.com/rocker-org/rocker/issues/19
RUN apt-get install -y --no-install-recommends \
                    locales
RUN locale-gen en_US en_US.UTF-8 \
          && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales \
          && update-locale LANG=en_US.UTF-8 \
          && update-locale LANGUAGE=en_US.UTF-8 \
          && update-locale LC_ALL=en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
# cat /etc/default/locale
# to see available locales:  sudo nano /var/lib/locales/supported.d/all

# Set tools
#----------
# Necessary Packages for installation
RUN apt-get install -y --no-install-recommends \
                    nano \
                    gdebi-core \
                    libapparmor1 \
                    wget \
                    ed \
		                less \
		                ca-certificates \
                    fonts-texgyre

# Necessary Packages for R
RUN apt-get install -y --no-install-recommends \
                    littler apt-utils libopenblas-base \
                    curl libcairo2-dev libxml2-dev ssh-askpass libcurl4-openssl-dev \
                    libssl-dev littler g++ build-essential libgtk2.0-dev libicu-dev \
                    libbz2-dev liblzma-dev zlib1g-dev libopencv-features2d-dev lib32z1-dev \
                    zlib* libblas-dev liblapack-dev libgsl0-dev libudunits2-dev libglu1-mesa-dev \
                    libnlopt-dev libmagick++-dev

# Install java
RUN apt-get install -y --no-install-recommends \
                    default-jdk \
                    default-jre \
                    libpcre++-dev

# Install git
RUN apt-get install -y --no-install-recommends \
                    git

# Install Latex and pandoc
RUN apt-get install -y --no-install-recommends \
                    texlive \
                    texlive-base \
                    texlive-latex-extra \
                    texlive-pstricks \
                    pandoc \
                    pandoc-citeproc

#for last pandoc https://github.com/jgm/pandoc/releases/tag/2.6
RUN wget https://github.com/jgm/pandoc/releases/download/2.6/pandoc-2.6-1-amd64.deb
RUN gdebi -n *.deb
RUN rm *.deb

# Install R and Rstudio
#----------------------
# Install R
# For ubuntu go to: http://cran.rstudio.com/bin/linux/ubuntu/ to see updates
RUN  echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial-cran35/" >> /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

RUN apt-get update && apt-get install -y r-base r-base-dev

# Install Rstudio
# Go to https://www.rstudio.com/products/rstudio/download/ and get link for rstudio package installer for 64 bits
RUN wget https://download1.rstudio.org/rstudio-xenial-1.1.463-amd64.deb
RUN gdebi -n *.deb
RUN rm *.deb

# Config R
#---------
# r java
RUN R CMD javareconf

# packages
COPY Install_Packages.R Install_Packages.R
RUN Rscript Install_Packages.R

# rstudio preferences # Still bug
#RUN mkdir -p ~/.rstudio-desktop/monitored/user-settings/user-settings
#COPY user-settings ~/.rstudio-desktop/monitored/user-settings/user-settings
COPY user-settings /home/user-settings # put manualy afterwide 

# the default packages for everyone running R
COPY Rprofile.site /etc/R/Rprofile.site

# Cleaning
#---------
RUN apt-get autoremove -y && apt-get clean -y
RUN apt-get update -y

# Debuging
#---------
# packges for X11 sharing
RUN apt-get install -y --no-install-recommends \
                  libxslt-dev

# Label
#------
MAINTAINER "François A.M Jean francois.jean.pro@gmx.com"
LABEL OS="ubuntu xenial 16.04.5" \
      R="R 3.5.2" \
      Rstudio="Rstudio 1.0.136"

# Launching
#----------
# Set wd
RUN mkdir -p /home/Input
RUN mkdir -p /home/Output
WORKDIR ~/home/Output

# packages
COPY launch.sh /bin/launch.sh
RUN chmod 777 /bin/launch.sh

# Set default start application (script needed beceause bug on QT5 keybord sharing)
CMD /bin/launch.sh

#CMD /usr/bin/rstudio
