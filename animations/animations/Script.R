require(ggplot2)
require(rgl)
require(fields)
require(akima)
require(magick)
require(animation)

#Creates the gif for coral
# Directory pathing
dirpath <- "C:/Users/m414r/Source/Repos/RPhage2Shark/Phage2Sharkdata/Coral"
setwd(dirpath)

# Reading in files
file_list = list.files(pattern = "*.dat")

# Sorting to correct order
file_list.sorted <- sort(file_list)
split <- strsplit(file_list.sorted, "coraltime")
split <- as.numeric(sapply(split, function(x) x <- sub(".dat", "", x[2])))

filelist <- file_list.sorted[order(split)]

numfiles = length(file_list)

# Creates individual plots
for (i in numfiles){
    assign(file_list[i], read.table(file_list[i]))
}


data = read.table(file_list[1])
a = data[, 1]
b = data[,2]
c = data[,3]
datamat <- interp(a,b,c)
# End individual

# Reads in data for each time step, in order
for (i in 1:21)
{
    currdata = read.table(filelist[i])
    a = currdata[, 1]
    b = currdata[, 2]
    c = currdata[, 3]
    datamat <- interp(a, b, c)

    framename <- paste("frame",i,".png", sep="")
    plottitle <- paste("Coral at Time:", i)

    # Creates .png of plot at each timestep
    png(framename)

    filled.contour(datamat, xlab = "X", ylab = "Y",
    color.palette = colorRampPalette(c("Green", "Red", "Orange", "Blue", "Purple")),
        plot.title = title(main = plottitle),
        key.title = title(main = "Coral"),
        levels = c(0, 1, 2, 3, 4, 5))

    dev.off()
}

# Sorting created images
frame_list = list.files(pattern = ".png")

frame_list.sorted <- sort(frame_list)
fsplit <- strsplit(frame_list.sorted, "frame")
fsplit <- as.numeric(sapply(fsplit, function(x) x <- sub(".png", "", x[2])))

framelist <- frame_list.sorted[order(fsplit)]

# GIF creation
im.convert(files=framelist, output = "coral.gif")