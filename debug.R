# object <- meth.chr$`3`
object <- meth.chr$`3`[!duplicated(meth.chr$`3`), ] 
win.size=1000
step.size=1000 
cov.bases = min.cov.bases

g.meth =as(object,"GRanges")
#chrs   =IRanges::levels(seqnames(g.meth))
chrs   =as.character(unique(seqnames(g.meth)))
#widths =seqlengths(g.meth) # this doesn't work with BioC 3.0
widths =sapply(chrs,function(x,y) max(end(y[seqnames(y)==x,])),g.meth  )# lengths of max bp in each chr
all.wins=GRanges()
for(i in 1:length(chrs))
{
  # get max length of feature covered chromosome
  max.length=max(IRanges::end(g.meth[seqnames(g.meth)==chrs[i],])) 
  
  #get sliding windows with covered CpGs
  numTiles=floor(  (max.length-(win.size-step.size) )/step.size )+1
  numTiles=ifelse(numTiles<1, 1,numTiles)
  temp.wins=GRanges(seqnames=rep(chrs[i],numTiles),
                    ranges=IRanges(start=1+0:(numTiles-1)*step.size,
                                   width=rep(win.size,numTiles)) )
  all.wins=suppressWarnings(c(all.wins,temp.wins))
}
#catch additional args

# regionCounts(object,all.wins,cov.bases,strand.aware=FALSE,save.db=save.db,suffix=suffix,... = ...)
regions <- all.wins
regions <- sortSeqlevels(regions)
regions <- sort(regions,ignore.strand=TRUE)
# overlap object with regions
# convert object to GRanges

object.grange <- as(object,"GRanges")
object.df <- data.frame(object.grange)
regiondf <- as.data.frame(regions)

selected.region <- subset(regiondf, regiondf$start == 158243001) %>% row.names()

mat = IRanges::as.matrix( findOverlaps(regions,as(object,"GRanges")) ) %>% as.data.frame()

object.df[subset(mat, mat$queryHits == selected.region)$subjectHits,]

# #require(data.table)
# # create a temporary data.table row ids from regions and counts from object
# coverage=numCs=numTs=id=covered=NULL
# df=data.frame(id = mat[, 1], getData(object)[mat[, 2], c(5, 6, 7)])
# 
# dt=data.table(df)
# #dt=data.table(id=mat[,1],object[mat[,2],c(6,7,8)] ) worked with data.table 1.7.7
# 
# 
# # use data.table to sum up counts per region
# sum.dt=dt[,list(coverage=sum(coverage1),
#                 numCs   =sum(numCs1),
#                 numTs   =sum(numTs1),
#                 covered =length(numTs1)),
#           by=id] 
# sum.dt=sum.dt[sum.dt$covered>=cov.bases,]
# 
# 
# selected.regions <- regions[sum.dt$id,] %>% as.data.frame()
# 
# subset(selected.regions, selected.regions$start == 158243001)
# 
