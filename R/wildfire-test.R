# ---- Setup ----
# devtools::load_all(".")
library(tidyverse)
library(psych)
library(ggcorrplot)
library(factoextra)
library(sf)

# ==========================
# ---- ENGLAND & WALES ----
data(indic_msoa_eng_wales)

# ---- Prepare and test data for PCA  ----
# Scale using z-score
scaled_df <- indic_msoa_eng_wales |>
  dplyr::select(-msoa_code, -msoa_name) |>
  mutate_all(~ scale(.))

# Visualise correlation
# Visually confirm that indicators are correlated
corr_matrix <- cor(scaled_df)
ggcorrplot(corr_matrix) # Quite a few indicators are correlated

# KMO and Bartlett's test
# KMO score is 0.78, which is >0.6 indicating variables overlap and there is partial correlation
# Barlett's test p-value is less than 0, reject null hypothesis that there is no correlation
kmo_result <- KMO(scaled_df)
bartlett_result <- cortest.bartlett(scaled_df)
print(kmo_result)
print(bartlett_result)

# ---- PCA ----
# Instantiate model using varimax to increase interpretability + reduce # variables
pca <- principal(scaled_df, nfactors = 5, rotate = "varimax")

# Check variance explained
eigenvalues <- pca$values
variance_proportion <- eigenvalues / sum(eigenvalues)
print(variance_proportion)

# Check loadings
factor_loadings <- pca$loadings
loadings_table <- data.frame(
  Variable = colnames(scaled_df),
  Factor1 = factor_loadings[, 1],
  Factor2 = factor_loadings[, 2],
  Factor3 = factor_loadings[, 3],
  Factor4 = factor_loadings[, 4],
  Factor5 = factor_loadings[, 5]
)

# ---- Creation of the Social Vulnerability Index ----
scores <- as.data.frame(pca$scores)

# SoVI score = each rotated component * its variance / cum variance
scores$SoVI <- ((scores$RC1 * variance_proportion[1]) +
                  (scores$RC2 * variance_proportion[2]) +
                  (scores$RC3 * variance_proportion[3]) +
                  (scores$RC4 * variance_proportion[4]) +
                  (scores$RC5 * variance_proportion[5]) /
                  (variance_proportion[1] + variance_proportion[2] + variance_proportion[3] + variance_proportion[4]))

sovi_england_wales <- tibble(
  msoa21_code = indic_msoa_eng_wales$msoa_code,
  msoa21_name = indic_msoa_eng_wales$msoa_name,
  SoVI = scores$SoVI
)

sovi_england <- sovi_england_wales |>
  filter(grepl("^E", msoa21_code)) |>
  mutate(SoVI_standardised = scale(SoVI)[, 1])

sovi_wales <- sovi_england_wales |>
  filter(grepl("^W", msoa21_code)) |>
  mutate(SoVI_standardised = scale(SoVI)[, 1])

# ---- Save datasets ----
usethis::use_data(sovi_england, overwrite = TRUE)
usethis::use_data(sovi_wales, overwrite = TRUE)