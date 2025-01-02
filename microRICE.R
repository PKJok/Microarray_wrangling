library(affy)
library(GEOquery)
library(DESeq2)
library(tidyr)
library(tidyverse)


setwd("C:/Users/ASUS/OneDrive/Desktop/microarray")

# get the supplementary file
getGEOSuppFiles("GSE162412")

# untar the files
untar("GSE162412/GSE162412_RAW.tar", exdir="data/")

# read .cel file
rawdata<- ReadAffy(celfile.path = "data/")

# perform rma normalization
normalized.data<- rma(rawdata)

#getting expression estimates
normalized.expr<- as.data.frame(exprs(normalized.data))

# getting GEO data to get gene symbols
#mapping probe ID to gene symbol
gse<- getGEO("GSE162412", GSEMatrix = TRUE)

# fetch feature data to get ID - gene symbol mapping
feature.data<- gse$GSE162412_series_matrix.txt.gz@featureData@data

# subsetting the feature.data
feature.data<- feature.data[,c(1,11)]
 unique(feature.data$`Gene Symbol`)

 
feature.data<- feature.data%>%
  rename( gene_symbol = `Gene Symbol`)
 
feature.data <- feature.data[nchar(feature.data$gene_symbol)>0,]

gene_expression<- normalized.expr%>%
  rownames_to_column(var = "ID")%>%
  inner_join(., feature.data, by="ID")

write.csv(gene_expression, "gene_expression.csv")

gene_expression<- gene_expression%>%
  select(8,2:7)
head(gene_expression)

cleaned_colnames <- str_remove_all(colnames(gene_expression), "_.*") 
colnames(gene_expression) <- cleaned_colnames
head(gene_expression)

pheno_data<- pData(phenoData(gse[[1]]))
tail(pheno_data)









