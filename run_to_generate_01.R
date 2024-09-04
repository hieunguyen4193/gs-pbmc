# gc()
# rm(list = ls())

path.to.main.src <- "/media/hieunguyen/HNSD01/src/PBMC"
source(file.path(path.to.main.src, "import_libraries.R"))
source(file.path(path.to.main.src, "helper_functions.R"))
source(file.path(path.to.main.src, "prepare_promoter_regions.R"))
library(GenomicRanges)
source(file.path(path.to.main.src, "configs.R"))

# outdir <- "/media/hieunguyen/HNSD_mini/data/outdir"
outdir <- "/media/hieunguyen/HNHD01/backup/HNSD_mini/HNSD_mini1/data/outdir"

library(optparse)

# Define the list of options
option_list <- list(
  make_option(c("-d", "--data_version"), type = "character", 
              help = "input data version", metavar = "character"),
  make_option(c("-o", "--output_version"), type = "character", 
              help = "output version", metavar = "character"),
  make_option(c("-m", "--min_cov"), type = "numeric", 
              help = "min coverage", metavar = "character"),
  make_option(c("-a", "--analysis_version"), type = "character", 
              help = "analysis version", metavar = "character")
)

# Create a parser
parser <- OptionParser(option_list = option_list)

# Parse the command-line arguments
args <- parse_args(parser)

data.version <- args$data_version
output.version <- args$output_version
min.cov <- args$min_cov
analysis.version <- args$analysis_version

# for (data.version in c("20240617", "20240601", "20240513")){
path.to.rmd <- file.path(path.to.main.src, "01_analysis.Rmd")
  
  # for (min.cov in c(10, 5)){
  #   for (analysis.version in names(configs)){
path.to.save.html.output <- file.path(outdir, "PBMC", "output", "html", sprintf("data_%s", data.version), output.version)
dir.create(path.to.save.html.output, showWarnings = FALSE, recursive = TRUE)
save.html.name <- sprintf("%s_minCov_%s_v%s.html", str_replace(basename(path.to.rmd), ".Rmd", ""), min.cov, analysis.version) 
print(sprintf("working on sample %s", save.html.name))
if (file.exists(file.path(path.to.save.html.output, save.html.name)) == FALSE){
  rmarkdown::render(input = path.to.rmd, 
                    output_file = save.html.name,
                    output_dir = path.to.save.html.output,
                    params = list(  min.cov = min.cov,
                                    analysis.version = analysis.version,
                                    data.version = data.version,
                                    output.version = output.version))      
} else {
  print(sprintf("File %s exists!", save.html.name))
}
    # }
#   }
# }



