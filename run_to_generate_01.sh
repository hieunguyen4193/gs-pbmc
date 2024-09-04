output_version="20240716";

for data_version in "20240617" "20240601" "20240513";do \
for min_cov in 5 10;do \
for analysis_version in "0.1" "0.2" "0.3" "0.4";do \
echo -e $data_version "\t" $min_cov "\t" $analysis_version;
Rscript /media/hieunguyen/HNSD01/src/PBMC/run_to_generate_01.R --data_version $data_version --output_version $output_version --min_cov $min_cov --analysis_version $analysis_version;done;done;done
