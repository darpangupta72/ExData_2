library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png("plot5.png")

data_baltimore <- NEI[NEI$fips == "24510", ]
merged_data2 <- merge(data_baltimore, SCC[, c(1,3)], by = "SCC")

#all ON-ROAD sources are taken to be motor vehicle type
index1 <- grep("ON-ROAD", merged_data2$type)
plot_data5 <- merged_data2[index1, ]
plot_data5 <- ddply(plot_data5, .(year), summarise, sum = sum(Emissions))

p <- qplot(year, sum, data = plot_data5, geom = c("point", "smooth"))
p + labs(x = "Year", title = "Emissions from motor vehicle sources in Baltimore vs Year", 
         y = "PM2.5 Emissions in Baltimore from motor vehicle sources (in tons)")

dev.off()
