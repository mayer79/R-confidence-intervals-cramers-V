# R-confidence-intervals-cramers-V

Function to compute confidence intervals for Cramér's V measure of association. Useful to express how **strong** the relation between the two categorical variables truely is with specified (approximate) certainty. A significant result of the chi-squared test of accociation goes along with a positive lower bound of the one-sided confidence interval.

## Example in R
```
library(MBESS)
pw <- iris$Petal.Width > 1
ct <- chisq.test(pw, iris$Species)
confintCramersV(ct, alternative = "greater") # Estimate 0.91, lower c.i. 0.77
confintCramersV(ct, conf.level = 0.9)        # [0.77, 1]
```
