# Team stats and Bootleg power rankings by years#

library(tidyverse)
library(nflfastR)

theme_set(theme_bw())


# Get data 

team_stats <- fast_scraper_schedules(2000:2024) %>% filter(!is.na(result))

# Step 1: Reshape the data to one row per team per game
team_games <- team_stats %>%
  filter(game_type == "REG") %>%  # Optional: regular season only
  select(season, game_id, home_team, home_score, away_team, away_score) %>%
  # Home team stats
  mutate(
    home_team = toupper(home_team),
    away_team = toupper(away_team)
  ) %>%
  bind_rows(
    team_stats %>%
      filter(game_type == "REG") %>%
      select(season, game_id, home_team, home_score, away_team, away_score) %>%
      rename(team = away_team, opponent = home_team,
             points_for = away_score, points_against = home_score)
  ) %>%
  bind_rows(
    team_stats %>%
      filter(game_type == "REG") %>%
      select(season, game_id, home_team, home_score, away_team, away_score) %>%
      rename(team = home_team, opponent = away_team,
             points_for = home_score, points_against = away_score)
  ) %>%
  select(season, game_id, team, opponent, points_for, points_against)

# Step 2: Summarize per team per season
team_summary <- team_games %>%
  group_by(season, team) %>%
  summarise(
    games_played = n(),
    total_points_for = sum(points_for, na.rm = TRUE),
    total_points_against = sum(points_against, na.rm = TRUE),
    points_for_pg = total_points_for / games_played,
    points_against_pg = total_points_against / games_played,
    point_diff_pg = points_for_pg - points_against_pg,
    .groups = "drop"
  )