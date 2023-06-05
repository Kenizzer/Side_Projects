
# Load data
word_counts.df <- read.csv("df.csv", header = FALSE)

# Tidying
colnames(word_counts.df) <- word_counts.df[2,]
word_counts.df <- word_counts.df[-(1:2),]
word_counts.df[,2] <- NULL
colnames(word_counts.df)[1] <- "Band"

