# Steps for Microarray Gene Expression Data Wrangling  🧬📊
This repository contains R code for processing and analyzing microarray data from the GEO database (GSE162412), including data retrieval, normalization, and gene symbol mapping. 🔬✨

## 1. Load Libraries 📚:
`affy`: Processes Affymetrix microarray data.
`GEOquery`: Retrieves GEO data.
`DESeq2`: Supports differential expression analysis (not used in this script).
`tidyr` & `tidyverse`: Facilitates data manipulation.

## 2. Download GEO Data 🌐: 
`getGEO`: Fetches supplementary files for GSE162412.
Extract Files 📦: Untars the downloaded .tar file to the data/ directory.
Read Microarray Data 📄: Loads .CEL files using ReadAffy.
Normalize Data ⚙️: Applies RMA normalization to raw microarray data.
Extract Expression Values 📈: Converts normalized data to a data frame.
Map Probe IDs to Gene Symbols 🔄:
Retrieves GEO metadata using getGEO.
Extracts feature data to map probe IDs to gene symbols.
Filters out empty gene symbols and joins with expression data.

## Save and Clean Data 🧹:
Saves the gene expression data to gene_expression.csv.
Selects relevant columns and cleans column names by removing suffixes.

Extract Phenotypic Data 🗂️: Retrieves sample metadata using pData.
