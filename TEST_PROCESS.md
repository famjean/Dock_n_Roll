# Test process

1/ launch normal mode: check opening is ok (interface, r customizations, rstudio customizations, mran, versions, keyboard, mouse, wd) and quit
2/ launch commit mode and
3/ apply write.csv("ee","ee.csv")
4/ install package: install.packages("meta")
5/ check if linkfile is ok
6/ run something and plot something : vector1 <- rnorm(100) ; factor1 <- factor(sample(c("A","B"),100,T)) ; lm( vector1 ~ factor1)-> lm1 ; summary(lm1); anova(lm1) ; plot(lm1)
7/ clone github project "DossierTest"
8/ launch script
9/ modify script commit and pull on github
10/ knit something for html docx and pdf formats
11/ quit
12/ reopen and check installed package: require(meta) and github
13/ test command roll_rXXX and shortcut
14/ save image as archive and pull it on dock hub and valid release
docker save famjean/dock_n_roll:latest | gzip > UBUNTU.16.04.6_R.3.6.1_MRAN.2019-07-05.tgz
docker login --username=yourhubusername --password=yourpassword
docker push famjean/dock_n_roll:latest  
docker push famjean/dock_n_roll:UBUNTU.16.04.6_R.3.6.1_MRAN.2019-07-05   
15/ Change the readme on https://hub.docker.com/
