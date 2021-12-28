#!/bin/R
# Script to install packages with version control

# Choose CRAN miror
chooseCRANmirror(ind = 1)
getOption( "repos" )
.libPaths()

# Load checkpoint
install.packages( "checkpoint" ) ;
require( "checkpoint", character.only = TRUE ) ;

# WD

# job
getOption( "repos" ) -> oldrepos1 ;

paste( sessionInfo()$R.version$year, sessionInfo()$R.version$month,  sessionInfo()$R.version$day, sep = "-" ) -> date;

dir.create( file.path("/root", ".checkpoint", paste( sessionInfo()$R.version$year, sessionInfo()$R.version$month,  sessionInfo()$R.version$day, sep = "-" ), "lib", sessionInfo()$R.version$platform, paste0(sessionInfo()$R.version$major, ".", sessionInfo()$R.version$minor)  ), 
recursive = TRUE, showWarnings = FALSE )

checkpoint( date ) ;

getOption("repos")
.libPaths()

save( date, file = paste0( "/root/.checkpoint/", "date.RData" ) )

rm( date, file )

# define function
load.packages <- function( PackagesNames, ...,
                           install = TRUE,
                           load = TRUE )
{
  # Get a vector with packages names
  packages1 <- c( PackagesNames, ... ) ;

  # Require or install and require packages
  lapply( 1:length( packages1 ),
          function(a)
          {
            if ( install )
            { if ( !packages1[a] %in% installed.packages()[,1] )
            { install.packages( packages1[a] ) } }
            if ( load ) { require( packages1[a], character.only = TRUE  )  }
          } ) -> tmp
}

# load packages
load.packages(
"lme4", "packrat",
"tidyverse", "lubridate", "forcats", "stringr",
"magrittr",
"rmarkdown", "knitr", "caTools", "bitops", "rprojroot",
"pander", "officer", "xtable", "flextable",
"grid", "png", "cowplot","scales", "Cairo",
"openxlsx", "crayon", "gitcreds", "usethis", 
load = FALSE
)
