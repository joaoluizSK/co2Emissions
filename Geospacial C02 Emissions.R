#Geospacial CO2 Emissions

library(raster)
library(rgdal)
library(ggplot2)
library(WDI)

setwd("/Users/JoaoLuizSK/Documents/r-workspace")

CO2 <- WDI(indicator= "EN.ATM.CO2E.KT", country = "all", 
           start = 1960, end=2016)

str(CO2)

NatEarth <- shapefile("Shapefile/ne_110m_admin_0_countries.shp")

str(NatEarth$admin)

str(unique(CO2)$country)

for(country in NatEarth$iso_a2){
  for(YEAR in 1960:2016){
    Value <- CO2[CO2$iso2c==country&CO2$year==YEAR, "EN.ATM.CO2E.KT"]
    
    if(length(Value) > 0){
      NatEarth[NatEarth$iso_a2==country, paste0("CO2_",YEAR)] <- as.numeric(paste(Value))
    }else{
      NatEarth[NatEarth$iso_a2==country, paste0("CO2_",YEAR)] <- NA
    }
  }
}

spplot(NatEarth, "C02_2011", main="CO2 Emissions (kt) - Year:2011", sub="Source: World Bank")

