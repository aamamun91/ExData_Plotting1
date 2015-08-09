if (!file.exists("household_power_consumption")) {
  message("downloading data ...")
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                "./energy.zip", mode='wb')
  message("extracting data ...")
  unzip("energy.zip", files=NULL, overwrite=TRUE, exdir=".", unzip="internal")
}
message("reading files ...")
energy<- read.table("household_power_consumption.txt", header=FALSE, sep=";", quote="\"", dec=".", skip=grep("1/2/2007", readLines("household_power_consumption.txt")), nrows=2879, na.strings="NA", as.is=TRUE)
colnames(energy)<- c("date", "time", "g_act_pow", "g_react_pow", "volt", "g_intense", "sub_met1", "sub_met2", "sub_met3")
energy$date<- as.Date(energy$date, format="%d/%m/%Y")
energy$datetime<- paste(energy$date, energy$time, sep=" ")
energy$datetime<- strptime(energy$datetime, format="%Y-%m-%d %H:%M:%S")
plot(energy$datetime, energy$g_act_pow, type="l", col="black", main=NULL, xlab=" ", ylab="Global Active Power(Kilowatts)")
