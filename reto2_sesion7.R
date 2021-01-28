library(rvest)
URL = "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"

file <- read_html(URL)   
summary(file)
tables <- html_nodes(file, "table") 
table1 <- html_table(tables[1], fill = TRUE)
table <- na.omit(as.data.frame(table1))
str(table) 

#Quitar caracteres no necesarios de sueldos 
sueldo <- gsub("MXN", "", table$Sueldo)
sueldo <- gsub("mes", "", sueldo)
sueldo <- gsub("/","", sueldo)
sueldo <- gsub("\\$", "", sueldo)
sueldo <- gsub(",", "", sueldo)
sueldo <- as.numeric(sueldo)

str(sueldo)

table$Sueldo <- sueldo

"Empresa que más paga"

max <- which.max(table$Sueldo)
table[max,]

"Empresa que menos paga"
min <- which.min(table$Sueldo)
table[min,]
