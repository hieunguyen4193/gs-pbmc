outdir="/media/hieunguyen/HNSD_mini/data/PBMC";
# data_version="20240513";
# data_version="20240601"
data_version="20240617";
mkdir -p ${outdir}/${data_version}/filtered_5reads_cov;
mkdir -p ${outdir}/${data_version}/filtered_3reads_cov;
mkdir -p ${outdir}/${data_version}/filtered_10reads_cov;
files=$(ls ${outdir}/${data_version}/raw_cov);

for file in $files;do filename=${file%.cov*} && \
echo -e "working on sample " $filename "\n" && \
awk -F'\t' '$5 + $6 >= 5' ${outdir}/${data_version}/raw_cov/${filename}.cov > ${outdir}/${data_version}/filtered_5reads_cov/${filename}.filtered.cov && \
awk -F'\t' '$5 + $6 >= 3' ${outdir}/${data_version}/raw_cov/${filename}.cov > ${outdir}/${data_version}/filtered_3reads_cov/${filename}.filtered.cov && \
awk -F'\t' '$5 + $6 >= 10' ${outdir}/${data_version}/raw_cov/${filename}.cov > ${outdir}/${data_version}/filtered_10reads_cov/${filename}.filtered.cov;done