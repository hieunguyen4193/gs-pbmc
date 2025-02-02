# $data_group=$1;
# data_version=$2;
output_version="20241010";

for data_group in 20250117_Vi_Breast 20250117_Vi_Liver 20250117_Vi_Rectum 20250117_Vi_CRC 20250117_Vi_Lung 20250117_Vi_Stomach;do \
  for data_version in {1..22};do \
    for min_cov in 5 10;do \
      for analysis_version in "0.1" "0.2" "0.3" "0.4";do \
        echo -e "Working on data group: " $data_group " at chromosome " $data_version ", settings: " "\t" $min_cov "\t" $analysis_version;
        Rscript /media/hieunguyen/HNSD01/src/PBMC/run_to_generate_01.Vi_data.R \
          --data_version ${data_group}_chr${data_version} \
          --data_group $data_group \
          --output_version $output_version \
          --min_cov $min_cov \
          --analysis_version $analysis_version;
          done;done;done;done
