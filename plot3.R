library(ggplot2)
library(reshape2)

NEI <- readRDS("summarySCC_PM25.rds")

png("plot3.png", width = 960)

plot_data3 <- NEI[NEI$fips == "24510", ]
plot_data3 <- melt(plot_data3, id = c("year", "type"), measure.vars = "Emissions")
plot_data3 <- dcast(plot_data3, type + year~variable, sum)
p <- qplot(year, Emissions, data = plot_data3, facets = .~type, geom = c("smooth", "point"))
p + labs(x = "Year", y = "PM2.5 Emissions in Baltimore (in tons)", 
         title = "Source-wise PM2.5 Emissions in Baltimore vs Year")

dev.off()