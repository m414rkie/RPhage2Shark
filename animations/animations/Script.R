require(ggplot2)
require(rgl)
require(fields)
require(akima)

dirpath <- "C:/Users/m414r/Source/Repos/RPhage2Shark/Phage2Sharkdata/Coral"
setwd(dirpath)

file_list = list.files(pattern = "*.dat")

numfiles = length(file_list)

for (i in numfiles)
    assign(file_list[i], read.table(file_list[i]))

numfiles
file_list[1]

currgraph <- as.matrix(file_list[1], header = F)
file_list[1]

data = read.table(file_list[1])
a = data[, 1]
b = data[,2]
c = data[,3]
datamat <- interp(a,b,c)

filled.contour(datamat, xlab = "X", ylab = "Y", color.palette =
  colorRampPalette(c("Blue","Green","Orange","Red")))