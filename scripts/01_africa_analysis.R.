library(tidyverse)
library(gapminder)

# 1. Keep African countries only and save the data
africa <- gapminder |> filter(continent == "Africa")
write_csv(africa, "data/africa_gapminder.csv")

# 2. Rank countries by life expectancy in the latest year (2007)
latest <- africa |>
  filter(year == max(year)) |>
  arrange(desc(lifeExp))

top10 <- slice_head(latest, n = 10)
bottom10 <- slice_tail(latest, n = 10)

print(top10)
print(bottom10)
write_csv(top10, "output/top10_life_expectancy.csv")
write_csv(bottom10, "output/bottom10_life_expectancy.csv")

# 3. Chart 1: Kenya and its neighbours over time
neighbours <- c("Kenya", "Uganda", "Tanzania", "Rwanda", "Ethiopia")

p1 <- africa |>
  filter(country %in% neighbours) |>
  ggplot(aes(x = year, y = lifeExp, colour = country)) +
  geom_line(linewidth = 1) +
  labs(title = "Life expectancy: Kenya and neighbours, 1952-2007",
       x = NULL, y = "Life expectancy (years)", colour = "Country") +
  theme_minimal()

# 4. Chart 2: income vs life expectancy, Kenya labelled
p2 <- ggplot(latest, aes(x = gdpPercap, y = lifeExp, size = pop)) +
  geom_point(alpha = 0.6, colour = "darkgreen") +
  geom_text(data = filter(latest, country == "Kenya"),
            aes(x = gdpPercap, y = lifeExp, label = country),
            inherit.aes = FALSE, vjust = -1, fontface = "bold") +
  scale_x_log10(labels = scales::dollar) +
  labs(title = "Income and life expectancy across Africa, 2007",
       x = "GDP per person (log scale)", y = "Life expectancy (years)",
       size = "Population") +
  theme_minimal()

print(p1)
print(p2)

ggsave("output/life_expectancy_neighbours.png", p1, width = 7, height = 4)
ggsave("output/income_vs_life_expectancy.png", p2, width = 7, height = 5)
