# Dockerfile for Dock_N_R
#------------------------

# Set OS
#-------
# Choose distribution to https://hub.docker.com/_/ubuntu/
# Define distribution
FROM ubuntu:bionic
# to know version
RUN cat /etc/*release

# Update source list
RUN apt-get update

# Set environment as non noninteractive
ENV DEBIAN_FRONTEND noninteractive

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
RUN apt-get update
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
                    fonts-texgyre \
                    gnupg gnupg2

# Necessary Packages for R
RUN apt-get install -y --no-install-recommends \
                    littler apt-utils libopenblas-base \
                    curl libcairo2-dev libxml2-dev ssh-askpass libcurl4-openssl-dev \
                    libssl-dev littler g++ build-essential libgtk2.0-dev libicu-dev \
                    libbz2-dev liblzma-dev zlib1g-dev libopencv-features2d-dev lib32z1-dev \
                    zlib* libblas-dev liblapack-dev libgsl0-dev libudunits2-dev libglu1-mesa-dev \
                    libnlopt-dev libmagick++-dev libperl-dev gfortran jags

# Install java
RUN apt-get install -y --no-install-recommends \
                    default-jdk \
                    default-jre \
                    libpcre++-dev

# Install git
RUN apt-get install -y --no-install-recommends \
                    git
RUN git config --global user.email "you@example.com"
RUN git config --global user.name "Your Name"

# Install ssh
RUN apt-get install -y --no-install-recommends \
                    openssh-server

# Install Latex and pandoc
RUN apt-get install -y --no-install-recommends --fix-missing \
                    texlive \
                    texlive-base \
                    texlive-latex-extra \
                    texlive-pstricks \
		    texlive-bibtex-extra \
		    biber \
		    latexmk \
                    lmodern \
                    pandoc \
                    pandoc-citeproc

#for last pandoc https://github.com/jgm/pandoc/releases
RUN wget https://github.com/jgm/pandoc/releases/download/2.9.2.1/pandoc-2.9.2.1-1-amd64.deb
RUN gdebi -n *.deb
RUN rm *.deb

# Install evince and ristretto to read rmarkdown output
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                    evince \
                    ristretto \
                    tumbler \
                    thunar

# Install libreoffice
# get link on https://www.libreoffice.org/download/download/
RUN wget https://download.documentfoundation.org/libreoffice/stable/6.4.3/deb/x86_64/LibreOffice_6.4.3_Linux_x86-64_deb.tar.gz
RUN tar -xf *.tar.gz
RUN rm *.tar.gz
RUN dpkg -i LibreOffice_*/DEBS/*.deb
RUN rm -R LibreOffice_*/

#alternative
#RUN apt-get install -y --no-install-recommends \
#                  libreoffice

# Install R and Rstudio
#----------------------
# Install R
# For ubuntu go to: https://cran.r-project.org/bin/linux/ubuntu/ to see updates
# For updated keys, go to the same site
RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu bionic-cran40/" >> /etc/apt/sources.list

RUN DEBIAN_FRONTEND=noninteractive apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
                    
RUN apt-get update && \
      apt-get install -y --no-install-recommends r-base \
                                                 r-base-dev \
                                                 r-base-html \
                                                 r-doc-html

RUN R --version

# Install Rstudio
# Go to https://rstudio.com/products/rstudio/download/#download
RUN wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.2.5042-amd64.deb
RUN gdebi -n *.deb
RUN rm *.deb

# Config R
#---------
# r java
RUN R CMD javareconf

# packages
RUN mkdir -p /home
COPY Install_Packages.R Install_Packages.R
RUN Rscript Install_Packages.R

# rstudio preferences
RUN mkdir -p /root/.rstudio-desktop/monitored/user-settings
COPY user-settings /root/.rstudio-desktop/monitored/user-settings/user-settings

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
# correct bug on qt
RUN apt-get install -y libqt5x11extras5
RUN apt-get install --reinstall libxcb-xinerama0

# Correct bug of launch libreoffice in rstudio
#RUN export LD_LIBRARY_PATH=:/usr/lib/libreoffice/program:/usr/lib/x86_64-linux-gnu/
#RUN export LD_LIBRARY_PATH="/usr/lib/libreoffice/program:$LD_LIBRARY_PATH"

# Launching
#----------
# Create files and set wd
RUN mkdir -p /home/LinkFile
RUN mkdir -p /home/Gits
WORKDIR /home

# packages
COPY launch.sh /bin/launch.sh
RUN chmod 777 /bin/launch.sh

# Label
#------
MAINTAINER "François A.M. Jean francois.jean.pro@gmx.com"
LABEL OS="ubuntu bionic 18.04.3" \
      R="R 4.0.0" \
      MRAN="2020.04.24"

# Set default start application (script needed beceause bug on QT5 keybord sharing)
CMD /bin/launch.sh

#CMD /usr/bin/rstudio
