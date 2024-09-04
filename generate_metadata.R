#####----------------------------------------------------------------------#####
##### GENERATE METADATA VERSION DATA 20240513
#####----------------------------------------------------------------------#####
# gc()
# rm(list = ls())
# library(comprehenr)
# library(stringr)
# outdir <- "/media/hieunguyen/HNSD_mini/data/outdir"
# 
# path.to.main.output <- file.path(outdir, "PBMC", "output")
# path.to.main.input <- "/media/hieunguyen/HNSD_mini/data/PBMC"
# data.version <- "20240513"
# 
# all.raw.cov.files <- Sys.glob(file.path(path.to.main.input, data.version, "raw_cov", "*.cov"))
# meta.data <- data.frame(raw_path = all.raw.cov.files,
#                         SampleID = to_vec(for (item in all.raw.cov.files) str_split(basename(item), ".deduplicated")[[1]][[1]]))
# 
# meta.data <- meta.data[, c("SampleID", "raw_path")]
# 
# writexl::write_xlsx(meta.data, file.path(path.to.main.input, data.version, "metadata.xlsx"))

#####----------------------------------------------------------------------#####
##### GENERATE METADATA VERSION 20240601
#####----------------------------------------------------------------------#####

gc()
rm(list = ls())
library(comprehenr)
library(stringr)
outdir <- "/media/hieunguyen/HNSD_mini/data/outdir"

path.to.main.output <- file.path(outdir, "PBMC", "output")
path.to.main.input <- "/media/hieunguyen/HNSD_mini/data/PBMC"
data.version <- "20240601"

all.raw.cov.files <- Sys.glob(file.path(path.to.main.input, data.version, "raw_cov", "*.cov"))
meta.data <- data.frame(raw_path = all.raw.cov.files,
                        SampleID = to_vec(for (item in all.raw.cov.files) str_split(basename(item), ".deduplicated")[[1]][[1]]))

meta.data <- meta.data[, c("SampleID", "raw_path")]

writexl::write_xlsx(meta.data, file.path(path.to.main.input, data.version, "metadata.xlsx"))