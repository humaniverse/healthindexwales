# Methodology: Health Index Wales - Healthy Lives

## Step 1: Data collection

- See metadata for data sources for each indicator: Metadata
- Data was collected for each indicator in the form of rates or percentages, age standardised where available.

## Step 2: Data standardization

- For each indicator, z scores were calculated for each area.
- Z scores are calculated as follows:
\[
Z = \frac{\text{{data value for area}} - \text{{mean value for indicator}}}{\text{{standard deviation for indicator}}}
\]

## Step 3: Score creation (indicators)

- For each indicator, standardised scores were created so that the mean value for every indicator is 100.
- The scores were calculated as follows:
(Z score x 10) + 100
- Using these standardised scores, every 10 units above or below 100 corresponds to 1 standard deviation away from the mean.
- For example, a score of 110 corresponds to 1 standard deviation higher than the mean, while a score of 90 corresponds to 1 standard deviation lower than the mean.

## Step 4: Score creation (subdomains)

- Subdomain scores were created by taking the mean standardised scores from Step 3 of all the indicators in that subdomain
- For example, for the Physiological Risk Factors subdomain, the subdomain score is the mean of the Step 3 scores for Low Birth Weight, Reception Overweight/Obesity and Adult Overweight/Obesity

## Step 5: Score creation (domain)

- The score for the Healthy Lives domain was created by taking the mean standardised scores from Step 3 of all indicators