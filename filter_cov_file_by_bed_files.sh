export PATH=/home/hieunguyen/bedtools2/bin:$PATH;

path_to_bed_files="/media/hieunguyen/GSHD_HN01/storage/PBMC/bed_files";

vi_bedfile=${path_to_bed_files}/covered_targets_Twist_Methylome_hg19_annotated_collapsed_plus_gapfill_SpikeIn_modified.bed;
truong_bedfile=${path_to_bed_files}/merged_probe_file_shareable_Methyl_Genesolutions_CustomMethyl_MTE-95699147_hg19_Rev1_ProbeShift_LowStringency_240712165101_modified.bed;

maindir="/media/hieunguyen/GSHD_HN01/storage/PBMC";

##### new batch data, 20250110, Truong
# batch_name="20250110"
# path_to_raw_cov=${maindir}/${batch_name}/raw_cov
# new_batch_name=${batch_name}_filtered_bed

# mkdir -p ${maindir}/${new_batch_name}/raw_cov;

# all_cov_files=$(ls ${path_to_raw_cov}/*.cov);

# for file in ${all_cov_files};do \
# echo -e "Filtering file " ${file}; 
# bedtools intersect -a ${file} -b ${truong_bedfile} -wa -wb > ${maindir}/${new_batch_name}/raw_cov/$(basename ${file});
# done

##### new batch data, 20250110, Vi
# for batch_name in 20250117_Vi_Breast 20250117_Vi_Liver 20250117_Vi_Rectum 20250117_Vi_CRC 20250117_Vi_Lung 20250117_Vi_Stomach; do \
#     path_to_raw_cov=${maindir}/${batch_name}/raw_cov;
#     new_batch_name=${batch_name}_filtered_bed;
#     mkdir -p ${maindir}/${new_batch_name}/raw_cov;
#     all_cov_files=$(ls ${path_to_raw_cov}/*.cov);
#     for file in ${all_cov_files};do \
#     echo -e "Filtering file " ${file}; 
#     bedtools intersect -a ${file} -b ${vi_bedfile} -wa -wb > ${maindir}/${new_batch_name}/raw_cov/$(basename ${file});
# done;done

##### split to chromosomes, raw original data
# path_to_save_splitChrom_data=${maindir}/20250117_Vi_data
# mkdir -p ${path_to_save_splitChrom_data}

# for i in {1..22};do \
#     for batch_name in 20250117_Vi_Breast 20250117_Vi_Liver 20250117_Vi_Rectum 20250117_Vi_CRC 20250117_Vi_Lung 20250117_Vi_Stomach;do \
#         echo -e "working on batch " ${batch_name} " at chrom " ${i};
#         mkdir -p ${path_to_save_splitChrom_data}/${batch_name}/${batch_name}_chr${i};
#         rsync -avh --progress ${maindir}/${batch_name}/metadata.xlsx ${path_to_save_splitChrom_data}/${batch_name}/${batch_name}_chr${i};
#         mkdir -p ${path_to_save_splitChrom_data}/${batch_name}/${batch_name}_chr${i}/raw_cov;
#         files=$(ls ${maindir}/${batch_name}/raw_cov/*.cov);
#         for file in ${files};do \
#             echo -e "Filtering file " ${file};
#             awk -v chr="${i}" -F'\t' '$1 == chr' ${file} > ${path_to_save_splitChrom_data}/${batch_name}/${batch_name}_chr${i}/raw_cov/$(basename ${file});
#         done;
#     done;
# done

##### split to chromosomes, filtered-bed-file data
path_to_save_splitChrom_data=${maindir}/20250117_Vi_data
mkdir -p ${path_to_save_splitChrom_data}

for i in {1..22};do \
    for batch_name in 20250117_Vi_Breast 20250117_Vi_Liver 20250117_Vi_Rectum 20250117_Vi_CRC 20250117_Vi_Lung 20250117_Vi_Stomach;do \
        batch_name=${batch_name}_filtered_bed;
        echo -e "working on batch " ${batch_name} " at chrom " ${i};
        mkdir -p ${path_to_save_splitChrom_data}/${batch_name}/${batch_name}_chr${i};
        rsync -avh --progress ${maindir}/${batch_name}/metadata.xlsx ${path_to_save_splitChrom_data}/${batch_name}/${batch_name}_chr${i};
        mkdir -p ${path_to_save_splitChrom_data}/${batch_name}/${batch_name}_chr${i}/raw_cov;
        files=$(ls ${maindir}/${batch_name}/raw_cov/*.cov);
        for file in ${files};do \
            echo -e "Filtering file " ${file};
            awk -v chr="${i}" -F'\t' '$1 == chr' ${file} > ${path_to_save_splitChrom_data}/${batch_name}/${batch_name}_chr${i}/raw_cov/$(basename ${file});
        done;
    done;
done


