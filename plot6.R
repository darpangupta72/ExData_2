library(reshape2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

png("plot6.png", width = 960, height = 960)

data_bal_la <- NEI[NEI$fips %in% c("24510", "06037"), ]
merged_data3 <- merge(data_bal_la, SCC[, c(1,3)], by = "SCC")

#all ON-ROAD vehicles are taken to be motor vehicle type
index2 <- grep("ON-ROAD", merged_data3$type)
plot_data6 <- merged_data3[index2, ]

plot_data6 <- melt(plot_data6, id = c("fips", "year"), measure.vars = "Emissions")
plot_data6 <- dcast(plot_data6, fips + year~variable, sum)
data_la <- plot_data6[plot_data6$fips == "06037", ]
data_bal <- plot_data6[plot_data6$fips == "24510", ]

la_1999 <- data_la$Emissions[which(data_la$year == 1999)]
bal_1999 <- data_bal$Emissions[which(data_bal$year == 1999)]

#plotting data relative to emissions in 1999
#CHANGE WITH TIME CAN BE OBSERVED BY CHECKING MAGNITUDE OF SLOPE OF DIFFERENT 
#LINE SEGMENTS. EG - FROM 2005-2008, LINE CORR. TO L.A. HAS GREATER MAGNITUDE OF
#SLOPE, SO IT HAS GREATER CHANGE IN EMISSION IN THAT PERIOD

plot(data_la$year, data_la$Emissions/la_1999, type = "l", xlab = "Year",
     ylab = "Emissions from motor vehicle sources (relative to year 1999)",
     col = "red", ylim = c(0.1, 1.6), cex.lab = 1.5, cex.axis = 1.5)
lines(data_bal$year, data_bal$Emissions/bal_1999, col = "blue")
title("Emissions from motor vehicle sources (Baltimore v LA)", cex.main = 2)
legend("topright", legend = c("Baltimore", "Los Angeles"), lty = 1, 
       col = c("blue", "red"), bty = "n", lwd = 2, cex = 2)

dev.off()