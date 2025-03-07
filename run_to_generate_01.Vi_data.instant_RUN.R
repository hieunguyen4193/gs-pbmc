gc()
rm(list = ls())

path.to.main.src <- "/media/hieunguyen/HNSD01/src/PBMC"
source(file.path(path.to.main.src, "import_libraries.R"))
source(file.path(path.to.main.src, "helper_functions.R"))
source(file.path(path.to.main.src, "prepare_promoter_regions.R"))
library(GenomicRanges)
source(file.path(path.to.main.src, "configs.R"))

# outdir <- "/media/hieunguyen/HNSD_mini/data/outdir"
outdir <- "/media/hieunguyen/HNSD_mini/outdir"

library(optparse)

# Define the list of options

# data.version <- args$data.version
# output.version <- args$output_version
# min.cov <- args$min.cov
# analysis.version <- args$analysis.version
# data.group <- args$data.group

output.version <- "20241010"
for (data.group in c("20250117_Vi_Breast", 
     "20250117_Vi_Liver", 
     "20250117_Vi_Rectum", 
     "20250117_Vi_CRC",
     "20250117_Vi_Lung",
     "20250117_Vi_Stomach")){
  data.group <- sprintf("%s_filtered_bed", data.group) 
  for (data.version in seq(1,22)){
    data.version <- sprintf("%s_chr%s", data.group, data.version)
    for (min.cov in c(15)){
      for (analysis.version in c("0.1", "0.2", "0.3", "0.4")){
        path.to.rmd <- file.path(path.to.main.src, "01_analysis_Vi_data.Rmd")
        path.to.save.html.output <- file.path(outdir, "PBMC", "output", "html", sprintf("data_%s", data.version), output.version)
        dir.create(path.to.save.html.output, showWarnings = FALSE, recursive = TRUE)
        save.html.name <- sprintf("%s_minCov_%s_v%s.html", str_replace(basename(path.to.rmd), ".Rmd", ""), min.cov, analysis.version) 
        print(sprintf("working on sample %s", save.html.name))
        if (file.exists(file.path(path.to.save.html.output, save.html.name)) == FALSE){
          input.params <- list(  min.cov = min.cov,
                                 analysis.version = analysis.version,
                                 data.version = data.version,
                                 data.group = data.group,
                                 output.version = output.version)
          for (p in names(input.params)){
            print(sprintf("%s: %s", p, input.params[[p]]))
          }
          rmarkdown::render(input = path.to.rmd, 
                            output_file = save.html.name,
                            output_dir = path.to.save.html.output,
                            params = input.params)      
        } else {
          print("--------------------------------------------------------------------")
          print(sprintf("File %s exists at %s", save.html.name, path.to.save.html.output))
          print("--------------------------------------------------------------------")
        }
        
      }
    }
  }
} 




