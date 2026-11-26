library(tidyverse)

africa <- read_csv("data/africa_gapminder.csv")

# 1. Life expectancy gain per country, 1952 to 2007
gains <- africa |>
  filter(year %in% c(1952, 2007)) |>
  select(country, year, lifeExp) |>
  pivot_wider(names_from = year, values_from = lifeExp,
              names_prefix = "y") |>
  mutate(gain = round(y2007 - y1952, 1)) |>
  arrange(desc(gain))

print(head(gains, 10))
write_csv(gains, "output/life_expectancy_gains.csv")

# 2. Countries where life expectancy fell between 1987 and 1997
setbacks <- africa |>
  filter(year %in% c(1987, 1997)) |>
  select(country, year, lifeExp) |>
  pivot_wider(names_from = year, values_from = lifeExp,
              names_prefix = "y") |>
  mutate(change = round(y1997 - y1987, 1)) |>
  filter(change < 0) |>
  arrange(change)

print(setbacks)
write_csv(setbacks, "output/setbacks_1987_1997.csv")

# 3. Chart 1: top 10 gainers
p3 <- gains |>
  slice_head(n = 10) |>
  ggplot(aes(x = reorder(country, gain), y = gain)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "Biggest life expectancy gains in Africa, 1952-2007",
       x = NULL, y = "Years gained") +
  theme_minimal()

# 4. Chart 2: Kenya against the African average
avg_africa <- africa |>
  group_by(year) |>
  summarise(lifeExp = mean(lifeExp)) |>
  mutate(country = "Africa average")

p4 <- africa |>
  filter(country == "Kenya") |>
  select(year, lifeExp, country) |>
  bind_rows(avg_africa) |>
  ggplot(aes(x = year, y = lifeExp, colour = country)) +
  geom_line(linewidth = 1.2) +
  geom_point() +
  labs(title = "Kenya vs the African average, 1952-2007",
       x = NULL, y = "Life expectancy (years)", colour = NULL) +
  theme_minimal()

print(p3)
print(p4)

ggsave("output/top_gainers.png", p3, width = 7, height = 4)
ggsave("output/kenya_vs_africa.png", p4, width = 7, height = 4)
