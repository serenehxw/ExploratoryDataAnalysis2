# Read data files
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

#Qns6: Compare emissions from motor vehicle sources in Baltimore City with emissions from 
#motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?
normalize <- function(x) {(x-min(x)) / (max(x)-min(x))}

# Get Baltimore emissions from motor vehicle sources
bmore.emissions <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
bmore.emissions.aggr <- aggregate(Emissions ~ year, data=bmore.emissions, FUN=sum)

# Get Los Angeles emissions from motor vehicle sources
la.emissions <- NEI[(NEI$fips=="06037") & (NEI$type=="ON-ROAD"),]
la.emissions.aggr <- aggregate(Emissions ~ year, data=la.emissions, FUN=sum)

bmore.emissions.aggr$County <- "Baltimore City, MD"
la.emissions.aggr$County <- "Los Angeles County, CA"
both.emissions <- rbind(bmore.emissions.aggr, la.emissions.aggr)

# plot the graph
library(ggplot2)
png("plot6.png")
ggplot(both.emissions, aes(x=factor(year), y=Emissions, fill=County)) +
  geom_bar(stat="identity") + 
  facet_grid(County  ~ ., scales="free") +
  ylab("total emissions (tons)") + 
  xlab("year") +
  ggtitle(expression("Motor vehicle emission variation\nin Baltimore and Los Angeles"))
dev.off()
