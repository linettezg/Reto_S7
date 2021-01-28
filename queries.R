library(DBI)
library(RMySQL)

#Conexión a Shiny

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

#Query para regresar el % que habla español en todos los países
dbListFields(MyDataBase, 'CountryLanguage')

DataDB <- dbGetQuery(MyDataBase, "select * from CountryLanguage")
head(DataDB)

library(dplyr)

prctg.esp <-  DataDB %>% filter(Language == "Spanish")   
head(prctg.esp)

prctg.df <- as.data.frame(prctg.esp)

library(ggplot2)
prctg.df %>% ggplot(aes(x = CountryCode, y = Percentage, fill = IsOfficial)) +
  geom_bin2d() + coord_flip()


