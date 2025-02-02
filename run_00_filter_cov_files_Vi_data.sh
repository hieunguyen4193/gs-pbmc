# for data_group in 20250117_Vi_Breast 20250117_Vi_Liver 20250117_Vi_Rectum 20250117_Vi_CRC 20250117_Vi_Lung 20250117_Vi_Stomach;do \
#     for data_version in {1..22};do \
#     echo -e "working on data gorup  " ${data_group} " at chrom " ${data_version};
#         bash 00_filter_cov_files.Vi_data.sh ${data_group} ${data_group}_chr${data_version};
#     done;
# done;


for data_group in 20250117_Vi_Breast 20250117_Vi_Liver 20250117_Vi_Rectum 20250117_Vi_CRC 20250117_Vi_Lung 20250117_Vi_Stomach;do \
    data_group=${data_group}_filtered_bed;
    for data_version in {1..22};do \
    echo -e "working on data gorup  " ${data_group} " at chrom " ${data_version};
        bash 00_filter_cov_files.Vi_data.sh ${data_group} ${data_group}_chr${data_version};
    done;
done;