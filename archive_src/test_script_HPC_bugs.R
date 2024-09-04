min.cov <- 5
analysis.version <- "0.1"
sample.type <- "all"

library(ggpubr)
path.to.main.src <- "/home/hieunguyen/PBMC_methylKit/src_v2"
source(file.path(path.to.main.src, "import_libraries.R"))
source(file.path(path.to.main.src, "helper_functions.R"))
source(file.path(path.to.main.src, "configs.R"))

min.cov.bases <- configs[[analysis.version]]$min.cov.bases
qvalue.cutoff <- configs[[analysis.version]]$qvalue.cutoff
methdiff.cutoff <- configs[[analysis.version]]$methdiff.cutoff
log2FC.cutoff <- configs[[analysis.version]]$log2FC.cutoff
up.flank <- configs[[analysis.version]]$up.flank
down.flank <- configs[[analysis.version]]$down.flank

maindir <- "/home/hieunguyen/PBMC_methylKit"
path.to.input <- file.path(maindir, "input_5x")
path.to.main.output <- file.path(maindir, "output_v2")

path.to.05.output <- file.path(path.to.main.output, sprintf("05_output_%s", analysis.version), sprintf("minCov_%s_sampleType_%s", min.cov, sample.type))
dir.create(path.to.05.output, showWarnings = FALSE, recursive = TRUE)

original.all.cov.files <- Sys.glob(file.path(path.to.input, sprintf("filtered_%sreads_cov", min.cov), "*.cov"))
names(original.all.cov.files) <- unlist(lapply(original.all.cov.files, function(x){
  x <- basename(x)
  x <- str_replace(x, ".deduplicated.bedGraph.gz.bismark.zero.filtered.cov", "")
  # x <- str_split(x, "-")[[1]][[2]]
  # x <- str_split(x, "_")[[1]][[1]]
  return(x)
}))

meta.data <- data.frame(filename = names(original.all.cov.files))
meta.data <- meta.data %>% rowwise() %>%
  mutate(Sample.type = ifelse(grepl("BCI", filename) == TRUE, "I", "V")) %>%
  mutate(spike.in.Label = str_split(filename, "_")[[1]][[1]]) %>%
  mutate(spike.in.Label = str_split(spike.in.Label, "-")[[1]][[2]]) %>%
  mutate(spike.in.Label = str_replace(spike.in.Label, "BCI", "")) %>%
  mutate(spike.in.Label = str_replace(spike.in.Label, "BCV", "")) %>%
  mutate(spike.in.Label = str_split(spike.in.Label, "R")[[1]][[1]])

original.metadata <- meta.data

cpg.island <- read.csv("/home/hieunguyen/PBMC_methylKit/CpG_island.hg19.txt", sep = "\t") %>% 
  subset(select = -c(X.bin)) %>%
  rowwise() %>%
  mutate(chr = str_replace(chrom, "chr", "")) %>%
  subset(chr %in% seq(1, 22))

cpg.island.grange <- makeGRangesFromDataFrame(df = cpg.island, seqnames.field = "chr", start.field = "chromStart", end.field = "chromEnd", keep.extra.columns = TRUE)

meth <- hash()
mat <- hash()
mat.pivot <- hash()

for (chosen.spike.in.label in unique(original.metadata$spike.in.Label)){
  meta.data <- subset(original.metadata, original.metadata$spike.in.Label %in% c(chosen.spike.in.label))
  meta.data <- meta.data %>% rowwise() %>%
    mutate(Label = ifelse(Sample.type == "I", 1, 0))
  all.cov.files <- original.all.cov.files[meta.data$filename]
  labels <- meta.data$Label
  
  DML.obj <- readBismarkCoverage( all.cov.files,
                                  sample.id = names(all.cov.files),
                                  assembly = "hg19",
                                  treatment = labels,
                                  context = "CpG",
                                  min.cov = min.cov)
  for (i in seq(1, length(DML.obj))){
    DML.obj[[i]] <- selectByOverlap(DML.obj[[i]], cpg.island.grange)
  }
  meth[[chosen.spike.in.label]] <- methylKit::unite(object = DML.obj, destrand = FALSE) 
  mat[[chosen.spike.in.label]] <- percMethylation(meth[[chosen.spike.in.label]], rowids = TRUE)  %>% as.data.frame() %>% rownames_to_column("locus")
  mat.pivot[[chosen.spike.in.label]] <- mat[[chosen.spike.in.label]] %>% pivot_longer(!locus, names_to = "sample", values_to = "meth_density")
  mat.pivot[[chosen.spike.in.label]] <- merge(mat.pivot[[chosen.spike.in.label]], meta.data, by.x = "sample", by.y = "filename", all.x = TRUE)
}

print("Code finished!")
