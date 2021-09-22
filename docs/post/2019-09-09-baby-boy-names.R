---
title: "Baby Boy Name Trends: How a Data Scientist Names his Son"
author: ~
date: '2019-09-09'
slug: baby-boy-names
thumbnailImagePosition: left  
thumbnailImage: img/20190909/top50.png
categories: []
tags: ['r', 'plotly', 'dataviz']
draft: true
publish: false
---

I'm going to be a dad (again) in November. I don't want my boy to have a common name, so I gotta do my research. I'm curious: how do names trend over time? If I pick a name today, will it be popular tomorrow?

Step 1: The Social Security Administration reports all baby names each year in the United States, given the name occurs at least 5 times. Thankfully, I can download these easily from [here]( https://www.ssa.gov/oact/babynames/limits.html).
Step 2: Combine the data across years.

```{r, echo=F, warning=F, message=F}
knitr::opts_chunk$set(echo = T, warning = F, message = F)
```


```{r, echo=F}
install.load::install_load('tidyverse', 'plotly', 'DT')
```

```{r, include=T, echo=F, warning=F, eval=FALSE}
# hello
df_all = data.frame()
prefix = '/Users/bryanwhiting/Downloads/names/yob'
# for (y in 2018:2000){
for (y in 1920:1890){
  path = paste0(prefix, y, '.txt')
  df_new = read.csv(path, header = F) 
  df_new$year = y
  df_all = rbind(df_all, df_new)
}
colnames(df_all) <- c('name', 'sex', 'number', 'year')
# Save
save(df_all, file="~/github/blog/static/img/20190909/names.Rda")
```

Let's dive into the data and find the top baby three names each year for each sex.
```{r}
load("~/github/blog/static/img/20190909/names.Rda")
# Add 
df2 <- df_all %>%
  group_by(year, sex) %>%
  arrange(year, sex, desc(number)) %>%
  mutate(pct = number/sum(number) * 100,
       cum_pct = cumsum(pct),
       tenk = pct/100 * 10000,
       rank = rank(desc(number), ties.method='first')) %>%
  ungroup()

# Look at the top 3 in each year
df2 %>% 
  group_by(sex, year) %>% 
  top_n(desc(3)) %>% 
  select(-tenk, -cum_pct) %>%
  mutate(pct = round(pct, 2)) %>%
  arrange(desc(year)) %>% #names()
  datatable(colnames =c("Name", "Sex", "Number Babies", "Year", "% of Pop.", "Rank" ))
```
That's interesting - it makes me wonder: what of the total % of babies are taken up in the top 100 names?

```{r}
df2 %>% filter(sex == 'M', year == 2018, rank < 100) %>%
  ggplot(aes(x=rank, y = cum_pct)) + 
  geom_point() + 
  ylim(c(0, 100)) + 
  labs(x = "Name Rank", y = "Cumulative % of All Names", 
       title = "The top 100 names account for > 40% of all names",
       caption = "Top 100 boy names, 2018") + 
  theme_minimal()
```

Interesting. If you name your kid somewhere in the top 100, according to the [Birthday Paradox](https://betterexplained.com/articles/understanding-the-birthday-paradox/), you're likely to have a pretty common name!

Makes me think - 
```{r}
df2 %>% 
  filter(sex == 'M', year == 2018, rank < 2251) %>%
  # View()
  ggplot(aes(x=rank, y = cum_pct)) + 
  geom_point() + 
  ylim(c(0, 100)) + 
  labs(x = "Name Rank", y = "Cumulative % of All Names", 
       title = "The top 500 boy names account for  75% of all names") + 
  scale_x_continuous(breaks = seq(0, 2250, by=250)) + 
  theme_minimal() + 
  theme(panel.grid.minor = element_blank())
```

```{r, echo=T, message=T}
tmp <- df2 %>%
  filter(rank < 50,
         sex == 'M') %>%
  mutate(rank = rank) %>%
  highlight_key(~name)#, group='Search Names (Select multiple holding "shift" + click)')

# Working ggplotly example: https://plotcon17.cpsievert.me/workshop/day2/#18
p <- ggplot(tmp, aes(year, rank, group=name)) + 
  geom_line() + 
  geom_point() + 
  labs(x = "Year", y="Name Rank", title="Top 50 Boy Names Over Time") +
  scale_y_reverse() + 
  theme_minimal()
gg <- ggplotly(p, tooltip = c("name", "rank"))
gg

highlight(gg, 'plotly_hover') 
# highlight(gg, 'plotly_click') 
# selectize = T, 
#           dynamic=T, 
#           #colors = c(rgb(225, 200, 100, maxColorValue = 255)),
#           defaultValues = c("Liam", "Noah", "William"))
```

```{r}
# Top 2500 boy names
df2 %>%
  filter(year >= 2015) %>%
  mutate(rank = rank) %>%
  View()
```

```{r}
all_yrs = df2 %>%
  filter(year >= 2010,
         sex == 'M') %>%
  mutate(year = str_replace(paste0('y', year), '20','')) %>%
  select(name, year, rank) %>%
  spread(year, rank) %>%
  arrange(y18) 

rank2018 <- df2 %>% 
  filter(year == 2018, sex=='M') %>% 
  ungroup() %>% 
  select(rank, pct, number) 

# How "off" are the aggregate numbers here? Should we inflate?
# Compare the total of our names to the CDC data
df2 %>% 
  filter(year == 2017) %>%
  summarize(sum(number))
# 3,561,975
# CDC reports: https://www.cdc.gov/nchs/fastats/births.htm
# 2017 actual: 3,855,500
# 3561975/3855500 = 92%
# so let's assume that our numbers are off by 8%. Just divide the number by .9238

# number of boys in 2018
# df2 %>%
#   filter(year == 2018, sex == 'F') %>%
#   summarise(sum(number))
# 1,800,392
# 1686961

name_rank <- all_yrs %>% 
  left_join(rank2018, by=c("y18" = "rank")) %>%
  mutate(number = floor(number/.9238),
         name = paste(name, 'Whiting')) %>%
  select(name, number, pct, paste0('y', 18:10)) 

name_rank %>%
  View()
```

Dimensions of criteria around name:
* Rarity: is your kid going to grow up with 3 other kids in the grade with the same name?
* Phonetics: do you like the sound? You'll be the one saying it 100x per day.
* Symbolism: give a name symbolic of something else. For example, "Aonani" is a Hawaiian name meaning "beautiful light"/
* Season: related to when they were born, e.g., "summer". Or if they are born on a full moon, name them luna.
* Family heritage: touch base with your family roots and name your child after an ancestor.
* Personal touch: you name them after someone you have a close connection to.
* Historical: with some reference to a historical person, e.g., "Martin Luther King" named after "Martin Luther"
* Biblical/Religious: a name common in your 

Pronunciation
Different Spellings


```{r}
# I updated the data to go back to 1980
# df_80 <- df2
plot_time <- function(n){
  df_80 %>% 
    filter(sex == 'M', name == n) %>%
    select(name, year, rank) %>%
    ggplot(aes(x = year, y = rank)) + 
    geom_line() + 
    expand_limits(y=0) + 
    scale_y_reverse() + 
    labs(title=n)
}

plot_time('Desmond')
plot_time('Theodore')
plot_time('England')
plot_time('George')
plot_time('Henry')
plot_time('Leo')
plot_time('Hugh')

plot_multi <- function(n, s='M'){
  df_80 %>% 
    filter(sex == s, 
           rank < 1200,
           name %in% n) %>%
    select(name, year, rank) %>%
    ggplot(aes(x = year, y = rank, color=name)) + 
    geom_line() +
    expand_limits(y=0) + 
    scale_y_reverse() 
}
plot_multi(c('Desmond', 'Hugh', 'Henry', 'Leo', 'Theodore', 'Rhett', 'Christopher', 'Liam', 'Oliver', 'Noah', 'Beckett'))

plot_multi(c('Everett', 'Henry', 'Finley', 'Tray', 'Nile', 'Beckett', 'Oscar', 'Stewart', 'Walker', 'Donovan', 'Troy', 'Phillip', 'Greyson', 'Parker', 'Bodie'))
# maria normington parker
# edwin whiting?
# Daron Whiting, Shephard Whiting: 
# bodie
# emerson
# everest: I like the phonetics, 
# england: I like the phonetics
# philip: phonetics
# Felix: Seems unique.
# Forrest: Unique. 
# Owen: Sounds cool
# Elisha: Family heritage, Eli nickname.  

# Family names:
# Lofgren
# Nils: Simple


# Veronica's list
plot_multi(c('Desmond', 'Hugh', 'Dean', 'Tray', 'Rhett', 'Noah', 'Beckett', 'Orlando', 'Landen', 'Tatum', 'August'))
# Forrest: 

plot_multi(c('Payton', 'Peyton', 'Peytin', 'Paytin'))
plot_multi(c('Tristin', 'Tristan', 'Triston'))

plot_multi(c('Kate', 'Helena', 'Molly'), 'F')
plot_multi(c('Quinn', 'West', 'Hayes'))
```

Further research:
* Are Utah names really that odd? Compare the average distribution over last 10 years to the national average.

```{r}
# old names: 1890 - 1920
df2 %>% 
  filter(sex == 'M') %>%
  group_by(name) %>% 
  summarise(number = sum(number)) %>%
  mutate(name = paste(name, 'Whiting')) %>%
  arrange(desc(number)) %>%
  View()
```




