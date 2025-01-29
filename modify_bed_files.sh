export PATH=/home/hieunguyen/bedtools2/bin:$PATH;

path_to_bed_files="/media/hieunguyen/GSHD_HN01/storage/PBMC/bed_files";

vi_bedfile=${path_to_bed_files}/covered_targets_Twist_Methylome_hg19_annotated_collapsed_plus_gapfill_SpikeIn.bed;
truong_bedfile=${path_to_bed_files}/merged_probe_file_shareable_Methyl_Genesolutions_CustomMethyl_MTE-95699147_hg19_Rev1_ProbeShift_LowStringency_240712165101.bed;

##### replace chr in chromosome name

echo -e "replacing chr in chromosome name in bed files ...."
awk 'BEGIN{OFS="\t"} {gsub(/^chr/, "", $1); print}' "$vi_bedfile" | cut -f1,2,3 > "${vi_bedfile%.bed}_modified.bed"
awk 'BEGIN{OFS="\t"} {gsub(/^chr/, "", $1); print}' "$truong_bedfile" | cut -f1,2,3 > "${truong_bedfile%.bed}_modified.bed"

