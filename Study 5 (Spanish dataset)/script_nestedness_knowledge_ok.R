# Path to file with all datasets
setwd("/Users/edgardubourg/Documents/Recherche/Travaux/Articles/Epistemic curiosity/Trivia Knowledge and Nestedness/Spanish study")

# Packages
library(tidyverse)
library(dplyr)

# 0. Load and translate ####

# Datasets 
a_answers = read.csv("answers.csv") 
a_items <- read.csv("items.csv", sep=";")
a_users <- read.csv("users.csv", sep=";")

# Translate categories

# Named vector of translations
translations <- c("arquitectura" = "architecture",
                  "arte" = "art",
                  "astronautas" = "astronauts",
                  "astronomia" = "astronomy",
                  "biologia" = "biology",
                  "botanica" = "botany",
                  "clasica" = "classics",
                  "comida" = "food",
                  "cuerpo" = "body",
                  "deportes" = "sports",
                  "economia" = "economics",
                  "europa" = "europe",
                  "filosofia" = "philosophy",
                  "fisica" = "physics",
                  "geografia" = "geography",
                  "historia" = "history",
                  "inventos" = "inventions",
                  "linguistica" = "linguistics",
                  "literatura" = "literature",
                  "marcas" = "brands",
                  "matematicas" = "mathematics",
                  "medicina" = "medicine",
                  "mediciones" = "measurements",
                  "mitologia" = "mythology",
                  "mundo" = "world",
                  "musica" = "music",
                  "organizaciones" = "organizations",
                  "peliculas" = "movies",
                  "politica" = "politics",
                  "psicologia" = "psychology",
                  "quimica" = "chemistry",
                  "records" = "records",
                  "religion" = "religion",
                  "tecnologia" = "technology",
                  "television" = "television",
                  "transportes" = "transportation",
                  "zoologia" = "zoology")

# Replace categories using the translations vector
a_items$category <- translations[a_items$category]


# 1. Cleaning and preparing the dataset ####

# I create a dataset with relevant columns

d_answer <- a_answers %>% dplyr::select(id_user, id_item, hit)
d_theme <- a_items %>% dplyr::select(id_item, category)
d <- full_join(d_answer, d_theme)
rm(d_answer, d_theme)

theme <- a_items %>% select(category) %>% unique

# 2. Computing the difficulty of the questions ####

d_difficulty_items <- d %>% 
  dplyr::select(id_item, hit) %>%
  group_by(id_item) %>%
  dplyr::summarise(difficulty_item=1-mean(hit))

# I create two identical datasets for id_item.x and id_item.y for later

d_difficulty_x <- d_difficulty_items
names(d_difficulty_x)[1]="id_item.x"

d_difficulty_y <- d_difficulty_items
names(d_difficulty_y)[1]="id_item.y"

# 3. Computing the thematic distance ####

# I create a matrix of user x theme with the hit rate for the questions that the user answered 

d_hit_matrix <- d %>% 
  group_by(id_user, category) %>%
  summarize(hit = mean(hit)) %>%
  pivot_wider(names_from = category, values_from = hit)

# I  use this matrix to calculate the covariance matrix (for PCA)

d_covariance_matrix <- cov(d_hit_matrix[, -1], use = "pairwise.complete.obs")

# I perform a PCA

pca_results <- prcomp(d_covariance_matrix, scale = TRUE)
print(pca_results)

# I determine the explained variance for each PC

explained_variance <- pca_results$sdev^2 / sum(pca_results$sdev^2)

# I determine the cumulative explained variance

cumulative_explained_variance <- cumsum(explained_variance)/sum(explained_variance)


# I decide on a threshold for the explained variance

threshold <- 0.7

# I find the number of principal components needed to reach the threshold

num_components_to_keep <- which(cumulative_explained_variance > threshold)[1]

# I extract the principal components to keep

principal_components <- pca_results$x[, 1:num_components_to_keep]

# I compute the Euclidian distance matrix 

d_distance_matrix <- as.matrix(dist(principal_components, method = "euclidean"))

# I transform the matrix into a dataframe

library(reshape2)
d_thematic_distance <- reshape2::melt(d_distance_matrix)
names(d_thematic_distance) <- c("category.x", "category.y", "thematic_distance")

# I plot the results on 2 dimensions (2 first PCs)

d_pca_coords <- data.frame(x = pca_results$x[, 1], y = pca_results$x[, 2], theme = rownames(pca_results$x))
library(ggrepel)
ggplot(d_pca_coords, aes(x, y)) + 
  geom_point(aes(color = theme), show.legend = F) + 
  geom_text_repel(aes(label = theme), hjust = 1.3, vjust = 0.4, size = 5) +
  xlab("PC1") + 
  ylab("PC2") + 
  ggtitle("Latent Space of Theme Similarity") + theme_bw()

# I remove all irrelevant datasets

rm(d_covariance_matrix, d_distance_matrix, d_hit_matrix, d_pca_coords, pca_results, principal_components, cumulative_explained_variance, explained_variance, num_components_to_keep, threshold)

# 4. Add id for all question pairs

d_pair_id <- d %>%
  left_join(d, by = c("id_user" = "id_user")) %>%
  filter(id_item.x < id_item.y) %>% 
  select(id_item.x, id_item.y) %>%
  unique() %>% arrange(id_item.x, id_item.y)

d_pair_id$id_pair=1:nrow(d_pair_id)

# 5. Joining all datasets together ####

# I create a dataset of all unique pairs of questions per participant

d_pairs_1 <- d %>%
  left_join(d, by = c("id_user" = "id_user")) %>%
  filter(id_item.x < id_item.y) # this removes the duplicate pairs

# I add pair id
  
d_pairs_2 <- full_join(d_pairs_1, d_pair_id, by = c("id_item.x", "id_item.y")) 

# I add thematic distance

d_pairs_3 <- full_join(d_pairs_2, d_thematic_distance, by = c("category.x", "category.y"))

# I add question_difficulty

d_pairs_4 <- full_join(d_pairs_3, d_difficulty_x, by="id_item.x")
d_pairs_5 <- full_join(d_pairs_4, d_difficulty_y, by="id_item.y")

# I re-order the column

d_pairs <- d_pairs_5 %>% select(id_user, id_item.x, difficulty_item.x, hit.x, category.x, id_item.y, difficulty_item.y, hit.y, category.y, id_pair, thematic_distance)
d_pairs <- na.exclude(d_pairs)

# I add the absolute difference between the difficulty of both questions of each pair

d_pairs$difficulty_differential=abs(d_pairs$difficulty_item.x-d_pairs$difficulty_item.y)

# I remove irrelevant dataset

rm(d_pairs_1, d_pairs_2, d_pairs_3, d_pairs_4, d_pairs_5, d_difficulty_items, d_pair_id, d_difficulty_x, d_difficulty_y, d_thematic_distance)

# 6. Computing nestedness compatibility ####

d_pairs <- d_pairs %>% 
  mutate(nestedness_compatibility = ifelse(
    (difficulty_item.x > difficulty_item.y & hit.x == 0 & hit.y == 1) | 
      (difficulty_item.x < difficulty_item.y & hit.x == 1 & hit.y == 0), # if they answered the easy question correctly and the difficult question of the pair incorrectly, then 1 (compatible)
    1, 
    ifelse(hit.x == hit.y, NA, 0))) # if they answered both question correctly or incorrectly, then NA, and if neither, then 0 (nestedness incompatible pairs)

d_pairs_final <- na.exclude(d_pairs) # exclude pairs of questions where participants got both questions right or wrong

d_pairs_final <- d_pairs_final %>% filter(thematic_distance!=0) # exclure pairs of questions from the same theme

hist(d_pairs_final$thematic_distance)

# 7. Statistical analysis ####

library(lmerTest)

null_model_1 <- glmer(data=d_pairs_final,family=binomial(link="logit"),  nestedness_compatibility ~ 1 + (1|id_user) + (1|id_item.x) + (1|id_item.y) + (1|id_pair) + difficulty_item.x + difficulty_item.y + difficulty_differential)
summary(null_model_1)

test_model_thematic_distance <- glmer(data=d_pairs_final,family=binomial(link="logit"),  nestedness_compatibility ~ 1 + (1|id_user) + (1|id_item.x) + (1|id_item.y) + (1|id_pair) + thematic_distance + difficulty_item.x + difficulty_item.y + difficulty_differential)
summary(test_model_thematic_distance)

AIC(null_model_1, test_model_thematic_distance)