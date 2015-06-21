library(plyr) #for ddply

NEI <- readRDS("summarySCC_PM25.rds")

png("plot1.png") #default height, width = 480

#processing data according to our needs
plot_data1 <- ddply(NEI, .(year), summarise, sum = sum(Emissions))

#plotting data
plot(x = plot_data1$year, y = plot_data1$sum, type = "l", xlab = "Year", 
     ylab = "Total PM2.5 Emission in US (in tons)")
title("Total PM2.5 Emission in US vs Year")

#closing connection
dev.off()