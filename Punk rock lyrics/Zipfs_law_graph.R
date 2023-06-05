x <- read.csv("Zipfs_law.tsv", header = FALSE, sep = "\t")
x2 <- cbind(x, 1:nrow(x))

###
"Zipf's law is most easily observed by plotting the data on a log-log graph, 
with the axes being log (rank order) and log (frequency). For example, the 
word the (as described above) would appear at x = log(1), y = log(69971). 
It is also possible to plot reciprocal rank against frequency or reciprocal 
frequency or interword interval against rank.[2] The data conform to Zipf's
law to the extent that the plot is linear."
###

plot(log(x2[,1]), log(x2[,3]), xlab = "log(rank)", ylab = "log(frequency)", col = "red")

