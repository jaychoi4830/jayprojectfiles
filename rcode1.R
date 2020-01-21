library(tidyverse)
library(dplyr)
setwd("C:/Users/com/Desktop/¾î°æ½Ä/R")
dt1=read.csv("sym.133p.csv")
dt1$PROBEID = as.character(dt1$PROBEID)
dt2=read.csv("padjust.csv")
dt3=read.csv("Data 1.csv")
dt3$Database_ID = as.character(dt3$Database_ID)
dt4=read.csv("rmaExpressionTable1.csv")
dt4$probe_id = as.character(dt4$probe_id)

file1 = inner_join(dt1,dt2,by =c("ENTREZID" = "Entrez.ID"))
file2 = inner_join(file1,dt4, by = c ("PROBEID" = "probe_id"))
file2 = as.data.frame(file2)
file3 = file2[-c(1:3, 5:10, 109)]

names = variable.names(file3)
require(data.table)
file4 = transpose(file3)
colnames(file4) = rownames(file3)
rownames(file4) = colnames(file3)

file5 = file4
colnames(file5) = file5[1, ]
file5 = file5[-1, ]
rownames(file5) = str_replace_all(rownames(file5), "A.", "A-")

require(tibble)

file6 = rownames_to_column(file5, var = "database_id")

file7 = left_join(file6, dt3, by = c("database_id" = "Database_ID"))
