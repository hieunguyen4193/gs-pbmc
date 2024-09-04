gc()
rm(list = ls())

set.seed(42)

path.to.main.src <- "/home/hieunguyen/PBMC_methylKit/src_v2"
source(file.path(path.to.main.src, "import_libraries.R"))
source(file.path(path.to.main.src, "helper_functions.R"))

rerun <- TRUE

for (analysis.version in c("0.1")){
  path.to.html.output <- file.path(path.to.main.src, sprintf("html_outputs_20240117_%s", analysis.version))
  dir.create(path.to.html.output, showWarnings = FALSE, recursive = TRUE)
  
  path.to.RMD.files <- c(file.path(path.to.main.src, "05_correlation_between_V_and_I_samples.CpG_island.Rmd"))
  
  for (path.to.RMD.file in path.to.RMD.files){
    for (min.cov in c(5, 3)){
      html_name <- str_replace(basename(path.to.RMD.file), ".Rmd", sprintf("minCov_%s.html", min.cov))
      if (file.exists(file.path(path.to.html.output, html_name)) == FALSE | rerun == TRUE) {
        rmarkdown::render(input = path.to.RMD.file,
                          output_file = html_name,
                          output_dir = path.to.html.output,
                          params = list(min.cov = min.cov))          
      }
    }
  }
}
