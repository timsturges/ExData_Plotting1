plot3 <- function () {
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
        png(file="plot3.png",480,480)
        plot(datetime,pwr_cns$Sub_metering_1,
             xlab="",ylab="Energy sub metering",type="n")
        lines(datetime,pwr_cns$Sub_metering_1)
        lines(datetime,pwr_cns$Sub_metering_2,col="red")
        lines(datetime,pwr_cns$Sub_metering_3,col="blue")
        legend("topright",
               legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               col=c("black","red","blue"),lwd=2)
        dev.off()
}