outdir="/media/hieunguyen/GSHD_HN01/storage/PBMC/20250117_Vi_data";

# data_version="20240513";
# data_version="20240601"
# data_version="20240617";
# data_version="20240911";
# data_version="20241010_CRC"
# data_version="20241010_Breast"

data_group=$1;
data_version=$2

mkdir -p ${outdir}/${data_group}/${data_version}/filtered_5reads_cov;
mkdir -p ${outdir}/${data_group}/${data_version}/filtered_3reads_cov;
mkdir -p ${outdir}/${data_group}/${data_version}/filtered_10reads_cov;
mkdir -p ${outdir}/${data_group}/${data_version}/filtered_15reads_cov;
files=$(ls ${outdir}/${data_group}/${data_version}/raw_cov/*.cov | xargs -n 1 basename);

for file in $files;do filename=${file%.cov*} && \
echo -e "working on sample " $filename "\n" && \
# awk -F'\t' '$5 + $6 >= 5' ${outdir}/${data_group}/${data_version}/raw_cov/${filename}.cov > ${outdir}/${data_group}/${data_version}/filtered_5reads_cov/${filename}.filtered.cov && \
# awk -F'\t' '$5 + $6 >= 3' ${outdir}/${data_group}/${data_version}/raw_cov/${filename}.cov > ${outdir}/${data_group}/${data_version}/filtered_3reads_cov/${filename}.filtered.cov && \
# awk -F'\t' '$5 + $6 >= 10' ${outdir}/${data_group}/${data_version}/raw_cov/${filename}.cov > ${outdir}/${data_group}/${data_version}/filtered_10reads_cov/${filename}.filtered.cov;
awk -F'\t' '$5 + $6 >= 15' ${outdir}/${data_group}/${data_version}/raw_cov/${filename}.cov > ${outdir}/${data_group}/${data_version}/filtered_15reads_cov/${filename}.filtered.cov
done