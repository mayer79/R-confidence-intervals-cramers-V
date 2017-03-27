# Computes approximate one- or two-sided approximate confidence intervals for true Cramér's V
# Package MBESS is required in order to access the non-central chi-squared distribution
# 
# Example
#   pw <- iris$Petal.Width > 1
#   ct <- chisq.test(pw, iris$Species)
#   confintCramersV(ct, alternative = "greater") # Estimate 0.91, lower c.i. 0.77
#   confintCramersV(ct, conf.level = 0.9)        # [0.77, 1]
confintCramersV <- function(z, alternative = c('two.sided', 'less', 'greater'), conf.level = 0.95) {
  alternative <- match.arg(alternative)
  alpha.lower <- alpha.upper <- 0
  
  if (alternative == "two.sided") {
    alpha.lower <- alpha.upper <- (1 - conf.level) / 2
  } else if (alternative == "greater") {
    alpha.lower <- 1 - conf.level
  } else if (alternative == "less") {
    alpha.upper <- 1 - conf.level
  }
  
  df <- z$parameter
  chi <- as.numeric(z$statistic)
  n <- sum(z$observed)
  k <- min(dim(z$observed)) - 1
  Delta <- unlist(MBESS::conf.limits.nc.chisq(chi, 
                     conf.level = NULL, 
                     df,
                     alpha.lower, 
                     alpha.upper)[c("Lower.Limit", "Upper.Limit")])
  out <- sqrt(c(Cramers.V = chi, Delta) / (n * k))
  out[is.na(out)] <- 0
  pmin(out, 1)
}

