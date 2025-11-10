install.packages("nflreadr")
library(nflreadr)
library(tidyverse)

theme_set(theme_bw())

# Load player data
players <- nflreadr::load_players()

# Filter for linebackers
linebackers <- players[players$position == "LB", ]

linebackers$birth_year <- lubridate::year(linebackers$birth_date)
linebackers$birth_year <- as.factor(linebackers$birth_year)

LBs_w_year <- linebackers %>%
  filter(!is.na(birth_year))


# Birth Year
ggplot(LBs_w_year, aes(x = birth_year, y = weight)) +
  geom_jitter(size = 3, shape = 21, width = 0.2) +
  geom_boxplot(fill = "lightgreen", color = "black", lwd = 1, 
               alpha = 0.3, outlier.shape = NA, lwd = 1, fatten = 1) +
  labs(x = "Birth Year", y = "Weight (lbs)", title = "NFL Linebacker Weight across Years")
  
ggplot(LBs_w_year, aes(x = birth_year, y = height)) +
  geom_jitter(size = 3, shape = 21, width = 0.2) +
  geom_boxplot(fill = "lightgreen", color = "black", lwd = 1, 
               alpha = 0.3, outlier.shape = NA, lwd = 1, fatten = 1) +
  labs(x = "Birth Year", y = "Weight (lbs)", title = "NFL Linebacker Height across Years")



# All positions, Birth Year
players

players$birth_year <- lubridate::year(players$birth_date)
players <- players %>% filter(birth_year >= "1966")
players$birth_year <- as.factor(players$birth_year)

players_w_year <- players %>%
  filter(!is.na(birth_year) & !is.na(position_group))




players_w_year %>% 
  filter(weight > 100) %>%
ggplot(., aes(x = birth_year, y = weight)) +
  geom_jitter(size = 1, shape = 21, width = 0.2) +
  geom_boxplot(fill = "lightgreen", color = "black", lwd = 1, 
               alpha = 0.3, outlier.shape = NA, lwd = 1, fatten = 1) +
  labs(x = "Birth Year", y = "Weight (lbs)", title = "NFL Weight across Years") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1, size = 6)) +
  facet_wrap(~position_group)

players_w_year %>% 
  filter(!gsis_id == "00-0039306") %>%
ggplot(., aes(x = birth_year, y = height)) +
  geom_jitter(size = 1, shape = 21, width = 0.2) +
  geom_boxplot(fill = "lightgreen", color = "black", lwd = 1, 
               alpha = 0.3, outlier.shape = NA, lwd = 1, fatten = 1) +
  labs(x = "Birth Year", y = "Height (in)", title = "NFL Height across Years") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1, size = 6)) +
  facet_wrap(~position_group)


# Smooth lines
players_w_year %>% 
  filter(weight > 100) %>%
  ggplot(., aes(x = as.numeric(birth_year), y = weight)) +
  geom_jitter(size = 1, shape = 21, width = 0.2) +
  geom_smooth(color = "lightgreen") +
  labs(x = "Birth Year", y = "Weight (lbs)", title = "NFL Weight across Years") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1, size = 6)) +
  facet_wrap(~position_group)

players_w_year %>% 
  filter(!gsis_id == "00-0039306") %>%
  ggplot(., aes(x = as.numeric(birth_year), y = height)) +
  geom_jitter(size = 1, shape = 21, width = 0.2) +
  geom_smooth(color = "lightgreen") +
  labs(x = "Birth Year", y = "Height (in)", title = "NFL Height across Years") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1, size = 6)) +
  facet_wrap(~position_group)
