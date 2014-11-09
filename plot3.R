# Read data files
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
#variable, which of these four sources have seen decreases in emissions from 1999???2008 
#for Baltimore City? Which have seen increases in emissions from 1999???2008? 
#Use the ggplot2 plotting system to make a plot answer this question.
bmore.emissions <- NEI[NEI$fips=="24510",]

# Group data by year and type of the source
bmore.emissions.aggr <- aggregate(Emissions ~ year + type,
                                  data=bmore.emissions,
                                  FUN=sum)
#Plot graph using ggplot
library(ggplot2)
png("plot3.png", height=480, width=680)
ggplot(bmore.emissions.aggr, aes(x=factor(year), y=Emissions, fill=type)) +
  geom_bar(stat="identity") +
  facet_grid(. ~ type) +
  xlab("year") +
  ylab(expression("total PM"[2.5]*" emission")) +
  ggtitle(expression("PM"[2.5]*paste(" emissions in Baltimore ",
                                     "City by various source types", sep="")))
dev.off()
