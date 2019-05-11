# Test process

1/ launch normal mode: check opening is ok (interface, r customizations, rstudio customizations, mran, versions, keyboard, mouse, wd) and quit
2/ launch commit mode (1st launch and apply write.csv("ee","ee.csv") and quit and relaunch)
3/ install package: install.packages("meta")
4/ run something: vector1 <- rnorm(100) ; factor1 <- factor(sample(c("A","B"),100,T)) ; lm( vector1 ~ factor1)-> lm1 ; summary(lm1); anova(lm1)
5/ plot something: plot(lm1)
6/ clone github project
7/ launch script
8/ modify script commit and pull on github
9/ knit something for html docx and pdf formats
10/ check linkfile is ok
11/ quit
12/ reopen and check installed package: require(meta) and github
13/ test command roll_r
14/ save image as archive and pull it on dock hub and valid release
docker save famjean/dock_n_roll:latest | gzip > UBUNTU.16.04.6_R.3.6.0_MRAN.2019-04-26.tgz
docker login --username=yourhubusername --password=yourpassword
docker push famjean/dock_n_roll:latest  
docker push famjean/dock_n_roll:UBUNTU.16.04.6_R.3.6.0_MRAN.2019-04-26    
