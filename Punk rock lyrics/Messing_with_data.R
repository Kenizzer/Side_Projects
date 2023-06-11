

#Libraries
library(tidyverse)
library(ggpubr)

# Theme set
theme_set(theme_pubr())

# Load data
word_counts <- read.csv("df.csv", header = FALSE)
bands_1 <- read.csv("bands_A-J_USA.csv", header = TRUE)
bands_2 <- read.csv("bands_L-Z_USA.csv", header = TRUE)

# Tidying
colnames(word_counts) <- word_counts[2,]
word_counts <- word_counts[-(1:2),]
word_counts[,2] <- NULL
colnames(word_counts)[1] <- "BAND_NAME"
all_bands <- rbind(bands_1, bands_2)
all_bands[sapply(all_bands, is.character)] <- lapply(all_bands[sapply(all_bands, is.character)], as.factor)
all_bands$ORIGIN_YEAR <- as.factor(all_bands$ORIGIN_YEAR)
colnames(all_bands)[1] <- "BAND_NAME"
#sanity check
summary(all_bands)
all_bands[all_bands$BAND_NAME == "Youth Brigade",] # two bands with same name (this is correct) DC/LA
# Remove .count in band names and replace underscores
word_counts$BAND_NAME <- gsub('.{6}$', '', word_counts$BAND_NAME)
word_counts$BAND_NAME <- gsub("_", " ", word_counts$BAND_NAME)
# Merging the metadata to the count dataframe
merged_df <- merge(all_bands, word_counts, by = "BAND_NAME")
# Reformat all columns to numeric
merged_df[,6:35090] <- sapply(merged_df[,6:35090],as.numeric)
merged_df[,6:32] <- NULL
merged_df[,6:35063] <- (merged_df[,6:35063] / rowSums(merged_df[,6:35063], na.rm = TRUE)) # convert to percentage


ggplot(merged_df, aes(x = UPPER_POLITICAL, y = fuck, fill = UPPER_POLITICAL)) +
  geom_point(position = position_jitterdodge(jitter.width = 0.1)) +
  geom_boxplot(alpha = 0.8, outlier.colour = NA, color = "black") +
  scale_y_continuous(labels = scales::percent) +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))

ggplot(merged_df, aes(x = UPPER_POLITICAL, y = love, fill = UPPER_POLITICAL)) +
  geom_point(position = position_jitterdodge(jitter.width = 0.1)) +
  geom_boxplot(alpha = 0.8, outlier.colour = NA, color = "black") +
  scale_y_continuous(labels = scales::percent) +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))

merged_df[merged_df$UPPER_POLITICAL == "New York", ] %>%
ggplot(aes(x = BAND_NAME, y = fuck)) +
  geom_col() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))
