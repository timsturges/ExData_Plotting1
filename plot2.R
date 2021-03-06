plot2 <- function () {
        #import data into table (only the data we need!)
        pwr_cns <- read.table("household_power_consumption.txt",header=FALSE,
                              sep=";",colClasses="character",na.strings="?",
                              nrow=2880,skip=66637)
        
        #due to skips on import, we need to name the columns
        clnms <- readLines("household_power_consumption.txt",n=1)
        clnms <- strsplit(clnms,split=";")
        clnms <- unlist(clnms)
        colnames(pwr_cns) <- clnms
        
        #create datetime object for plotting
        datetime <- paste(pwr_cns$Date,pwr_cns$Time)
        datetime <- strptime(datetime,"%d/%m/%Y %H:%M:%S")
        
        #time to reclass the columns
        for (i in 3:9) {pwr_cns[,i]<-as.numeric(pwr_cns[,i])}
        
        #let the plotting begin
        png(file="plot2.png",480,480)
        plot(datetime,pwr_cns$Global_active_power,xlab="",
             ylab="Global Active Power (kilowatts)",type="n")
        lines(datetime,pwr_cns$Global_active_power)
        dev.off()
}