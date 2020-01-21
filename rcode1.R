library(tidyverse)
library(dplyr)
setwd("C:/Users/com/Desktop/¾î°æ½Ä/R") ##Set file location to import from
dt1=read.csv("sym.133p.csv") ##specific to Array Type used by study; 133p or 95av2
dt1$PROBEID = as.character(dt1$PROBEID) ##making sure Probe_ID is set to character, not integer
dt2=read.csv("padjust.csv") ##original filter file
dt3=read.csv("demoAnnTable.csv") ##Demographic file
dt3$Database_ID = as.character(dt3$Database_ID) ##Make sure Database_ID is set to character, not integer
dt4=read.csv("rmaExpressionTable1.csv") ##expression file
dt4$probe_id = as.character(dt4$probe_id) ##Make sure probe_id is set to character, not integer; these are required for left_joining

file1 = inner_join(dt1,dt2,by =c("ENTREZID" = "Entrez.ID")) ##filter only wanted genes by Entrez ID
file2 = inner_join(file1,dt4, by = c ("PROBEID" = "probe_id")) ##apply the filter to expression dataset 
file2 = as.data.frame(file2) 
file3 = file2[-c(1:3, 5:10, 109)] ##remove columns that we do not want

require(data.table)
file4 = transpose(file3)
colnames(file4) = rownames(file3)
rownames(file4) = colnames(file3)

file5 = file4
colnames(file5) = file5[1, ]
file5 = file5[-1, ]
rownames(file5) = str_replace_all(rownames(file5), "A.", "A-")

library(tibble)

file6 = rownames_to_column(file5, var = "database_id")

file7 = left_join(file6, dt3, by = c("database_id" = "Database_ID"))
