library(plyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png("plot4.png")

merged_data1 <- merge(NEI, SCC[, c(1,3)], by = "SCC")
index <- c(grep("coal", merged_data1$Short.Name), grep("Coal", merged_data1$Short.Name))
plot_data4 <- merged_data1[index, ]
plot_data4 <- ddply(plot_data4, .(year), summarise, sum = sum(Emissions))

p <- qplot(year, sum, data = plot_data4, geom = c("point", "smooth"))
p + labs(x = "Year", title = "Emissions from coal related sources vs Year", 
     y = "PM2.5 Emissions in US from coal related sources (in tons)")

dev.off()