library(plyr)

NEI <- readRDS("summarySCC_PM25.rds")

png("plot2.png")

plot_data2 <- NEI[NEI$fips == "24510", ]
plot_data2 <- ddply(plot_data2, .(year), summarise, sum = sum(Emissions))

plot(plot_data2$year, plot_data2$sum, type = "l", xlab = "Year", 
     ylab = "Total PM2.5 Emission in Baltimore (in tons)")
title("Total PM2.5 Emission in Baltimore vs Year")

dev.off()