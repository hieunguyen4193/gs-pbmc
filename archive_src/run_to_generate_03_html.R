gc()
rm(list = ls())

set.seed(42)

path.to.main.src <- "/home/hieunguyen/PBMC_methylKit/src_v2"
source(file.path(path.to.main.src, "import_libraries.R"))
source(file.path(path.to.main.src, "helper_functions.R"))

for (analysis.version in c("0.1")){
  path.to.html.output <- file.path(path.to.main.src, sprintf("html_outputs_20240117_%s", analysis.version))
  dir.create(path.to.html.output, showWarnings = FALSE, recursive = TRUE)
  
  path.to.RMD.files <- c(file.path(path.to.main.src, "03_summary_all_validation_spike_in_methyl_results.Rmd"))
  
  for (path.to.RMD.file in path.to.RMD.files){
    for (sample.type in c("I", "V", "all")){
      for (min.cov in c(5, 3)){
          html_name <- str_replace(basename(path.to.RMD.file), ".Rmd", sprintf("minCov_%s_sampleType_%s.html", min.cov, sample.type))
          if (file.exists(file.path(path.to.html.output, html_name)) == FALSE) {
            rmarkdown::render(input = path.to.RMD.file,
                              output_file = html_name,
                              output_dir = path.to.html.output,
                              params = list(min.cov = min.cov, 
                                            sample.type = sample.type,
                                            analysis.version = analysis.version))          
          }
        }
      }
    }
  }
