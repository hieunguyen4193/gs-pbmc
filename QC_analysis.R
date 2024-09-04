gc()
rm(list = ls())

path.to.main.src <- "/media/hieunguyen/HNSD01/src/PBMC"
source(file.path(path.to.main.src, "import_libraries.R"))
source(file.path(path.to.main.src, "helper_functions.R"))
source(file.path(path.to.main.src, "prepare_promoter_regions.R"))
library(GenomicRanges)
source(file.path(path.to.main.src, "configs.R"))

PROJECT <- "PBMC"
maindir <- "/media/hieunguyen/HNSD_mini/data"
# data.version <- "20240601"
data.version <- "20240513"

path.to.depthdf <- file.path(maindir, PROJECT, data.version, "Depth_in_CpG.csv")

depthdf <- read.csv(path.to.depthdf)

sumdf <- data.frame()
sumdf.pct <- data.frame()
for (sample.id in setdiff(colnames(depthdf), c("X0", "X1", "X2"))){
  tmpdf <- data.frame(SampleID = c(sample.id))
  tmpdf.pct <- data.frame(SampleID = c(sample.id))
  count.read <- depthdf[[sample.id]]
  count.read <- count.read[is.na(count.read) == FALSE]
  for (i in c(3, 5, 10, 15, 20)){
    tmpdf[[sprintf("numCpG_depth%s", i)]] <- length(count.read[count.read >= i])
    tmpdf.pct[[sprintf("pctCpG_depth%s", i)]] <- 100* length(count.read[count.read >= i])/length(count.read)
  }
  sumdf <- rbind(sumdf, tmpdf)
  sumdf.pct <- rbind(sumdf.pct, tmpdf.pct)
}

writexl::write_xlsx(sumdf, file.path(maindir, PROJECT, data.version, "summary_depth_at_CpG.xlsx"))
writexl::write_xlsx(sumdf.pct, file.path(maindir, PROJECT, data.version, "summary_pct_depth_at_CpG.xlsx"))
