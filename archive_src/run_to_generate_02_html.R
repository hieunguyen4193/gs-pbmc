gc()
rm(list = ls())

set.seed(42)

path.to.main.src <- "/home/hieunguyen/PBMC_methylKit/src_v2"
source(file.path(path.to.main.src, "import_libraries.R"))
source(file.path(path.to.main.src, "helper_functions.R"))

all.labels <- c("0", "0.1", "01",  "05",  "10",  "100")
pairs <- list(
  test1 = c("0", "0.1"),
  test2 = c("0", "01"),
  test3 = c("0", "05"),
  test4 = c("0", "10"),
  test5 = c("0", "100"),
  test6 = c("0", "0.1"),
  test7 = c("0.1", "01"),
  test8 = c("01", "05"),
  test9 = c("05", "10"),
  test10 = c("10", "100"),
  test11 = c("0.1", "100"),
  test12 = c("01", "100"),
  test13 = c("05", "100"),
  test14 = c("10", "100")
)
for (analysis.version in c("0.1")){
  path.to.html.output <- file.path(path.to.main.src, sprintf("html_outputs_20240221_%s", analysis.version))
  dir.create(path.to.html.output, showWarnings = FALSE, recursive = TRUE)
  
  path.to.RMD.files <- c(file.path(path.to.main.src, "02_analysis_spike_in_methylation_data.Rmd"))
  
  for (path.to.RMD.file in path.to.RMD.files){
    for (sample.type in c("I", "V")){
      for (min.cov in c(5, 3)){
          for (i in names(pairs)){
            group0 <- pairs[[i]][[1]]
            group1 <- pairs[[i]][[2]]
            html_name <- str_replace(basename(path.to.RMD.file), ".Rmd", sprintf("_minCov_%s_sampleType_%s.%s_vs_%s.html", min.cov, sample.type, group1, group0))
            if (file.exists(file.path(path.to.html.output, html_name)) == FALSE) {
              rmarkdown::render(input = path.to.RMD.file,
                                output_file = html_name,
                                output_dir = path.to.html.output,
                                params = list(min.cov = min.cov, 
                                              sample.type = sample.type,
                                              analysis.version = analysis.version,
                                              group1 = group1,
                                              group0 = group0))          
            }
          }
      }
    }
  }
}
