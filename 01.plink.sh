#VCF 生成 plink 输入文件（ped和map）
vcftools --vcf SNP_merge.vcf --plink --out SNP
#cover the pink to bed files
plink --file projiect_254s_zhangjun-ID --out ../../02/cy --make-bed
#maf
plink --bfile cy --make-bed --maf 0.05 --geno 0.05 --out ./test3/cy_final
#tassel cover the ped to hmp database
run_pipeline.pl -fork1 -plink -ped cy_final.ped -map cy_final.map -export cy_final -exportType Hapmap -runfork1
#snp 
#42285个

#admixture to cal the K vaule
for K in 1 2 3 4 5 6 7 8 9; do admixture --cv cy_final.bed $K | tee log${K}.out; done 
#提取K值：
grep "CV error" log.txt >k_1to13
grep -h CV log*.out







